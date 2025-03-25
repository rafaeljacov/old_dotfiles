import { App } from "astal/gtk3"
import GLib from "gi://GLib"
import style from "./style.scss"
import Bar from "./widget/Bar"
import AppLauncher from "./widget/Applauncher"
import NotifyPopups from "./widget/Notification/NotifyPopups"
import MonitorSettings from "./widget/MonitorSettings"
import QuickControl from "./widget/QuickControl/QuickControl"
import OSD from "./widget/OSD"

const CONFIG_DIR = GLib.get_user_config_dir()

App.start({
    icons: `${CONFIG_DIR}/ags/assets/icons`,
    css: style,
    requestHandler(request: string, res: (response: any) => void) {
        if (request == "say hi") {
            return res("hi cli")
        }
        res("unknown command")
    },
    main() {
        App.get_monitors().map(Bar);
        App.get_monitors().map(NotifyPopups);
        App.get_monitors().map(OSD);
        AppLauncher();
        MonitorSettings();
        QuickControl();
    },
})
