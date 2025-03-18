import { Binding, Variable, bind } from "astal";
import { App, Gdk, Astal, Gtk } from "astal/gtk3";
import { Button, Slider } from "astal/gtk3/widget";
import GLib from "gi://GLib";
import Wp from "gi://AstalWp";
import Brightness from "../../lib/brightness";
import Network from "gi://AstalNetwork";
import Bluetooth from "gi://AstalBluetooth";
import { bluetooth_blocked } from './Bluetooth'
import { exec, execAsync } from "astal/process";
import MprisPlayers from "./MediaPlayer";
import WifiExpanded from './WifiExpanded'
import { truncate } from "../../lib/utils"

type ControlBtnProps = {
    className?: string;
    icon: Binding<string> | string;
    label: Binding<string> | string;
    active?: Binding<boolean>;
    callback?: (self: Button) => void;
    expand?: () => void;
};

type SliderEntryProps = {
    icon: string | Binding<string>;
    value: number | Binding<number>;
    onclick?: () => void;
    callback: (self: Slider) => void;
};

type ExpandProps = {
    toggle: Binding<boolean>;
    child?: JSX.Element;
}

enum Expander {
    WIFI,
    BT,
    NONE
}

let toggle_expand = Variable(false)
let expander = Variable(Expander.NONE)

export default function QuickControl() {
    return (
        <window
            name="quick_control"
            margin={7}
            width_request={400}
            application={App}
            visible={false}
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
            keymode={Astal.Keymode.ON_DEMAND}
            onKeyPressEvent={(self, event) => {
                if (event.get_keyval()[1] === Gdk.KEY_Escape) {
                    self.hide();
                }
            }}
        >
            <eventbox onHoverLost={() => {
                expander.set(Expander.NONE)
                toggle_expand.set(false)
                App.get_window('quick_control')?.hide()
            }}>
                <box className="QuickControl" vertical>
                    <Session />
                    <Sliders />
                    <MainControls />
                    <MprisPlayers />
                </box>
            </eventbox>
        </window>
    );
}

function Info({
    icon,
    label,
}: {
    icon: string;
    label: string | Binding<string>;
}) {
    let font_weight = "normal";
    let font_size = "unset";
    let margin_left = 0;

    if (icon == "hourglass-half") {
        margin_left = 3;
    } else {
        font_weight = "bold";
        font_size = "1.2em";
    }

    return (
        <box className="Info" hexpand>
            <icon
                icon={icon}
                css={`
          font-size: ${font_size};
          margin-left: ${margin_left};
        `}
            />
            <label
                label={label}
                css={`
          font-weight: ${font_weight};
        `}
            />
        </box>
    );
}

function Session() {
    const USER = GLib.getenv("USER");

    let uptime = Variable("00m").poll(20_000, "uptime", (out, _) => {
        let regex = out.match(/(\d+:\d+),/);
        if (regex) {
            let match = regex[1];
            let hour = match.slice(0, match.indexOf(":"));
            let min = match.slice(match.indexOf(":") + 1).padStart(2, "0");

            return `${hour}h ${min}m`;
        } else {
            regex = out.match(/up \d+/);
            let match = regex![0];
            let min = match.slice(3);

            return `${min}m`;
        }
    });

    return (
        <box className="Session">
            <box>
                <box className="profile-img" />
                <box valign={Gtk.Align.CENTER} vertical>
                    <Info icon="avatar-default-symbolic" label={USER!} />
                    <Info icon="hourglass-half" label={uptime()} />
                </box>
            </box>
            <box className="PowerControls" halign={Gtk.Align.END}>
                <PowerControlBtn icon="lock" callback={() => { }} />
                <PowerControlBtn
                    icon="system-shutdown-symbolic"
                    callback={() => {
                        exec("poweroff")
                    }}
                />
            </box>
        </box>
    );
}

function PowerControlBtn({ icon, callback }: { icon: string; callback: any }) {
    return (
        <box
            className="PowerControlBtn"
            valign={Gtk.Align.CENTER}
            halign={Gtk.Align.END}
        >
            <button
                hexpand
                onClicked={callback}
            >
                <icon icon={icon} />
            </button>
        </box>
    );
}

function Aside() {
    let warm_light_mode = Variable("eye-slash");

    return (
        <box className="Aside" vertical valign={Gtk.Align.CENTER}>
            <button
                vexpand
                className="sound-setting"
                cursor='pointer'
                onClicked={() => {
                    execAsync("pavucontrol");
                    App.toggle_window("quick_control");
                }}
            >
                <icon icon="sliders" />
            </button>
            <button
                vexpand
                className="warm-light-toggle"
                cursor='pointer'
                onClicked={() => exec(["hyprshade", "toggle", "blue-light-filter"])}
            >
                <icon icon={warm_light_mode()} />
            </button>
        </box>
    );
}

function SliderEntry({ icon, value, onclick, callback }: SliderEntryProps) {
    return (
        <box className="SliderEntry">
            {(onclick !== undefined)
                ? // if
                <button onClicked={onclick} cursor='pointer'>
                    <icon valign={Gtk.Align.CENTER} icon={icon} />
                </button>
                : // else
                <icon valign={Gtk.Align.CENTER} icon={icon} />
            }
            <slider value={value} hexpand onDragged={callback} />
        </box>
    );
}

function Sliders() {
    const speaker = Wp.get_default()?.audio.default_speaker!;
    const brightness = Brightness.get_default();
    const THRESHOLD = 0.4

    let brightness_icon = bind(brightness, 'screen').as(v => (v <= THRESHOLD) ? 'moon' : 'sun');
    return (
        <box className="Sliders">
            <box vertical>
                <SliderEntry
                    icon={bind(speaker, "volumeIcon")}
                    value={bind(speaker, "volume")}
                    onclick={() => speaker.set_mute(!speaker.get_mute())}
                    callback={({ value }) => (speaker.volume = value)}
                />
                <SliderEntry
                    icon={brightness_icon}
                    value={bind(brightness, "screen")}
                    callback={({ value }) => (brightness.screen = value)}
                />
            </box>
            <Aside />
        </box>
    );
}

function ControlBtn({
    className,
    icon,
    label,
    active,
    callback,
    expand,
}: ControlBtnProps) {
    const LABEL_MAX_LENGTH = 12;
    const button_setup = (self: Button) => {
        if (active) {
            self.toggleClassName('active', active.get())
            self.toggleClassName('has-expand', expand !== undefined)
            self.hook(active, () => {
                self.toggleClassName('active', active.get())
            })
        }
    }

    let lb;
    if (typeof label == "string") {
        lb = label;
    } else {
        lb = bind(label).as((l) => truncate(l, LABEL_MAX_LENGTH));
    }

    return (
        <box className={`${className} ControlBtn` || "ControlBtn"} hexpand>
            <button
                onClicked={callback}
                setup={button_setup}
            >
                <box>
                    <icon icon={icon} />
                    <label label={lb} hexpand halign={Gtk.Align.START} />
                </box>
            </button>

            {expand !== undefined && (
                <button
                    className="expand"
                    onClicked={expand}
                    halign={Gtk.Align.END}
                    setup={button_setup}
                    cursor='pointer'
                >
                    <icon icon="caret-right" />
                </button>
            )}
        </box>
    );
}

function MainControls() {

    const network = Network.get_default();
    const wifi = network.wifi

    const mic = Wp.get_default()?.audio.default_microphone!

    const bluetooth = Bluetooth.get_default();
    const bt_adapter = bluetooth.get_adapter()

    const [DISABLED, DISCONNECTED, CONNECTING] = ['Disabled', 'Disconnected', 'Connecting...']
    const wifi_label = Variable.derive([
        bind(wifi, 'enabled'),
        bind(network, 'state'),
        bind(wifi, 'state'),
        bind(wifi, 'ssid'),
    ],
        (enabled, net_state, wifi_state, ssid) => {
            if (!enabled) {
                return DISABLED
            } else if (wifi_state === Network.DeviceState.DISCONNECTED) {
                return DISCONNECTED
            } else if (net_state === Network.State.CONNECTING) {
                return CONNECTING
            }

            return ssid !== null ? ssid : DISCONNECTED
        })

    return (
        <box className="MainControls" vertical>
            <box className="entry">
                <ControlBtn
                    icon={bind(wifi, "icon_name")}
                    label={wifi_label()}
                    active={bind(wifi, 'enabled')}
                    callback={() => wifi.set_enabled(!wifi.get_enabled())}
                    expand={() => {
                        if (expander.get() == Expander.WIFI) {
                            expander.set(Expander.NONE)
                            toggle_expand.set(false)
                        } else {
                            expander.set(Expander.WIFI)
                            toggle_expand.set(true)
                        }
                    }}
                />
                <ControlBtn
                    icon="bluetooth"
                    label={'Bluetooth'}
                    active={bind(bluetooth, 'is_powered')}
                    callback={() => {
                        if (bluetooth_blocked()) {
                            exec('rfkill unblock bluetooth')
                        }

                        return bt_adapter?.set_powered(!bt_adapter.get_powered())
                    }}
                    expand={() => {
                        if (expander.get() == Expander.BT) {
                            expander.set(Expander.NONE)
                            toggle_expand.set(false)
                        } else {
                            expander.set(Expander.BT)
                            toggle_expand.set(true)
                        }
                    }}
                />
            </box>
            <Expand toggle={toggle_expand()}>
                <WifiExpanded
                    inview={bind(expander).as(e => (e == Expander.WIFI))}
                />
            </Expand>
            <box className="entry">
                <ControlBtn
                    className='mic'
                    icon={bind(mic, 'mute').as(muted => muted ? 'mic-muted' : 'mic')}
                    label={bind(mic, 'mute').as(muted => muted ? 'Muted' : 'Unmuted')}
                    active={bind(mic, 'mute')}
                    callback={() => mic.set_mute(!mic.get_mute())}
                />
                <ControlBtn icon="x" label="Option" />
            </box>
        </box>
    );
}

function Expand({ toggle, child }: ExpandProps) {

    return <revealer
        className="Expand"
        setup={self => self.hook(toggle, (self) => self.set_reveal_child(toggle.get()))}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
    >
        {child}
    </revealer>
}
