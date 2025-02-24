import Hyprland from "gi://AstalHyprland"
import { App, Astal, Gdk } from "astal/gtk3"

const Monitor = {
    MAIN: 'eDP-1',
    HDMI: 'HDMI-A-1'
}

function keyword_monitor(monitor: string, value: string) {
    Hyprland.get_default().message(`keyword monitor ${monitor}, ${value}`)
}

const actions = [
    {
        icon: 'extend-symbolic',
        label: 'Extend',
        args: { monitor: Monitor.HDMI, value: 'highres,auto,1' },
    },
    {
        icon: 'mirror-symbolic',
        label: 'Mirror',
        args: { monitor: Monitor.HDMI, value: `highres,auto,1,mirror,${Monitor.MAIN}` }
    },
    {
        icon: 'screen_only-symbolic',
        label: 'PC Screen',
        args: { monitor: Monitor.HDMI, value: 'disable' }
    },
]

function Option(icon: string, label: string, callback: any) {
    return <button onClicked={callback} margin={2}>
        <box margin={8}>
            <icon icon={icon} css='font-size: 35px;' margin_end={20} />
            <label label={label} css='font-size: 18px;' />
        </box>
    </button>
}

function Setting() {
    const options = actions.map(
        ({ icon, label, args }) => Option(icon, label, () => keyword_monitor(args.monitor, args.value))
    )

    return <box orientation={1} margin={8}>
        {options}
    </box>
}


export default function MonitorSettings() {
    return <window
        name='monitor'
        application={App}
        keymode={Astal.Keymode.EXCLUSIVE}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        css='border-radius: 7px;'
        anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
        visible={false}
        margin={7}
        onKeyPressEvent={function (self, event) {
            if (event.get_keyval()[1] === Gdk.KEY_Escape)
                self.hide()
        }}
    >
        <Setting />
    </window>
}
