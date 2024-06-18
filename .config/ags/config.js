import Bar from './widgets/bar.js'
import NotificationPopups from './widgets/notifications.js'
import { applauncher } from './widgets/applauncher.js'

const style_dir = `${App.configDir}/style`

App.config({
    style: `${style_dir}/style.css`,
    windows: [
        Bar(0),
        NotificationPopups(),
        applauncher
    ],
})

// Auto reload styles
Utils.monitorFile(
    style_dir,

    function() {
        // target css file
        const css = `${style_dir}/style.css`

        App.resetCss()
        App.applyCss(css)
    },
)
