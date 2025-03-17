import { Variable, GLib, bind } from "astal"
import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"
import Mpris from "gi://AstalMpris"
import Battery from "gi://AstalBattery"
import Wp from "gi://AstalWp"
import Network from "gi://AstalNetwork"
import Tray from "gi://AstalTray"
import { truncate } from "../lib/utils"

function SysTray() {
    const tray = Tray.get_default()

    return <box>
        {bind(tray, "items").as(items => items.map(item => {
            if (item.iconThemePath)
                App.add_icons(item.iconThemePath)

            const menu = item.create_menu()

            return <button
                css="margin-left: 7px"
                tooltipMarkup={bind(item, "tooltipMarkup")}
                onDestroy={() => menu?.destroy()}
                onClickRelease={self => {
                    menu?.popup_at_widget(self, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null)
                }}>
                <icon gIcon={bind(item, "gicon")} />
            </button>
        }))}
    </box>
}

function QuickControlBtn() {
    const { wifi } = Network.get_default()
    const speaker = Wp.get_default()?.audio.default_speaker!
    const mic = Wp.get_default()?.audio.default_microphone!

    return <button
        className='QuickControlBtn'
        onClicked={() => App.toggle_window('quick_control')}
        cursor='pointer'
    >
        <box>
            <icon
                tooltip_text={bind(wifi, "ssid")}
                className="Wifi"
                icon={bind(wifi, "iconName")}
            />
            <icon
                icon={bind(mic, "mute").as(muted => muted ? 'mic-muted' : 'mic')}
                setup={self => {
                    self.hook(bind(mic, 'mute'), 
                        (self, mute) => self.set_visible(mute))
                }}
            />
            <icon icon={bind(speaker, "volumeIcon")} />
        </box>
    </button> 
}

function BatteryLevel() {
    const bat = Battery.get_default()

    return <box className="Battery"
        visible={bind(bat, "isPresent")}>
        <icon icon={bind(bat, "batteryIconName")} />
        <label label={bind(bat, "percentage").as(p =>
            `${Math.floor(p * 100)} %`
        )} />
    </box>
}

function Media() {
    const mpris = Mpris.get_default()

    return <box className="Media">
        {bind(mpris, "players").as(ps => ps[0] ? (
            <box>
                <box
                    className="Cover"
                    valign={Gtk.Align.CENTER}
                    css={bind(ps[0], "coverArt").as(cover =>
                        `background-image: url('${cover}');`
                    )}
                />
                <label
                    label={bind(ps[0], "title").as(() =>
                        truncate(`${ps[0].title} - ${ps[0].artist}`, 30)
                    )}
                    tooltip_text={bind(ps[0], "title").as(() =>
                        `${ps[0].title} - ${ps[0].artist}`
                    )}
                />
            </box>
        ) : (
            ""
        ))}
    </box>
}

function Workspaces() {
    const hypr = Hyprland.get_default()

    return <box className="Workspaces">
        {bind(hypr, "workspaces").as(wss => wss
            .sort((a, b) => a.id - b.id)
            .filter(({ id }) => id > 0)
            .map(ws => (
                <button
                    className={bind(hypr, "focusedWorkspace").as(fw =>
                        ws === fw ? "focused" : "")}
                    onClicked={() => ws.focus()}>
                    {ws.id}
                </button>
            ))
        )}
    </box>
}

function Time({ format = "%e %a %H:%M" }) {
    const time = Variable("").poll(1000, () =>
        GLib.DateTime.new_now_local().format(format)!)
    return <label
        className="Time"
        onDestroy={() => time.drop()}
        label={time()}
    />
}

export default function Bar(monitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return <window
        className="Bar"
        gdkmonitor={monitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}>
        <centerbox>
            <box hexpand halign={Gtk.Align.START}>
                <icon 
                    margin_start={10} 
                    margin_end={7} 
                    css='font-size: 21px; margin-left: 4px;'
                    icon='nix'
                />
                <Workspaces />
            </box>
            <box>
                <Media />
            </box>
            <box hexpand halign={Gtk.Align.END} >
                <SysTray />
                <QuickControlBtn />
                <BatteryLevel />
                <Time />
            </box>
        </centerbox>
    </window>
}
