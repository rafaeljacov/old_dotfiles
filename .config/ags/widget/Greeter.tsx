import { App, Astal } from "astal/gtk3"
import Greet from "gi://AstalGreet"

const details = {
    USER: "",
    PASSWORD: "",
}

function login() {
    const { USER, PASSWORD } = details
    Greet.login(USER, PASSWORD, "dbus-run-session Hyprland", (_, res) => {
        try {
            Greet.login_finish(res)
        } catch (err) {
            printerr(err)
        }
    })
}

const Username = () => {
    return <entry placeholder_text="Username"
        onChanged={() => {
            details.USER = Username().text
            Password().grab_focus()
        }}></entry>
}

const Password = () => {
    return <entry placeholder_text="Password"
        onChanged={() => {
            details.PASSWORD = Password().text
            login()
        }}></entry>
}

const Greeter = () => {
    const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor
    return <window monitor={0} anchor={TOP | LEFT | RIGHT | BOTTOM} keymode={Astal.Keymode.ON_DEMAND}>
        <box vertical={true} hexpand={true} vexpand={true}>
            <Username />
            <Password />
        </box>
    </window>
}

App.start({
    main() {
        Greeter()
    }
})
