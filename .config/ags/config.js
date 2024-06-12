import Bar from './widgets/bar.js'
import NotificationPopups from './widgets/notifications.js'

App.config({
    style: "./style/style.css",
    windows: [
        Bar(0),
        NotificationPopups()
    ],
})
