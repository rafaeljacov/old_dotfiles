App.addIcons(`${App.configDir}/assets`)

const hypr = await Service.import('hyprland')
const main_monitor = 'eDP-1'
const hdmi_monitor = 'HDMI-A-1'

function keyword_monitor(monitor, value) {
    hypr.messageAsync(`keyword monitor ${monitor}, ${value}`)
}

const actions = [
    {
        icon: 'extend-symbolic',
        label: 'Extend',
        args: { monitor: hdmi_monitor, value: 'highres,auto,1' },
    },
    {
        icon: 'mirror-symbolic',
        label: 'Mirror',
        args: { monitor: hdmi_monitor, value: `highres,auto,1,mirror,${main_monitor}` }
    },
    {
        icon: 'screen_only-symbolic',
        label: 'PC Screen',
        args: { monitor: hdmi_monitor, value: 'disable' }
    },
]

const option = (icon, label, callback) => Widget.Button({
    child: Widget.Box({
        children: [
            Widget.Icon({
                icon,
                size: 48,
                margin_end: 24
            }),
            Widget.Label({
                label,
            })
        ],
        margin: 8
    }),
    on_clicked: callback,
    margin: 2
})

const setting = () => {
    const settings = actions.map(
        ({ icon, label, args }) => option(icon, label, () => keyword_monitor(args.monitor, args.value))
    )
    return Widget.Box({
        children: settings,
        vertical: true,
        margin: 8
    })
}

export const monitor_settings = Widget.Window({
    name: 'monitor_settings',
    // class_name: 'monitor_settings',
    child: setting(),
    setup: self => self.keybind('Escape', () => {
        App.closeWindow('monitor_settings')
    }),
    visible: false,
    keymode: 'exclusive',
    anchor: ['top', 'right'],
})
