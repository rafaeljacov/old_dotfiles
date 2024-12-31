import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widget/Bar"
import AppLauncher from "./widget/Applauncher"
import NotifyPopups from "./widget/NotifyPopups"
import MonitorSettings from "./widget/Monitor"

App.start({
    css: style,
    // requestHandler(request: string, res: (response: any) => void) {
    //     if (request == "say hi") {
    //         return res("hi cli")
    //     }
    //     res("unknown command")
    // },
    main() {
        App.get_monitors().map(Bar);
        App.get_monitors().map(NotifyPopups);
        AppLauncher()
        MonitorSettings()
    },
})
