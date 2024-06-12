import Bar from './widgets/bar.js'
import NotificationPopups from './widgets/notifications.js'

const style_dir = `${App.configDir}/style`
const widgets_dir = `${App.configDir}/widgets`

App.config({
    style: `${style_dir}/style.css`,
    windows: [
        Bar(0),
        NotificationPopups()
    ],
})

// Reload ags when modifying config and widgets

/** @param {string} path **/
function reloadAgs(path) {
    Utils.monitorFile(
        path,

        function() {
            Utils.execAsync('bash -c "ags quit && ags"')
        }
    )
}

reloadAgs(widgets_dir)
reloadAgs(`${App.configDir}/config.js`)

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
