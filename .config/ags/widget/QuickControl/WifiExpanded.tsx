import { execAsync } from 'astal/process'
import { Binding } from 'astal'

export default function WifiExpanded({ inview }: { inview: Binding<boolean> }) {
    return <box
        vertical
        setup={self => {
            self.hook(inview, (self) => {
                if (inview.get()) {
                    let wifi_list = get_wifi()

                    if (self.children.length === 0) {
                        self.child = <label label='scanning...' />
                    }

                    wifi_list.then(list => {
                        if (list !== undefined) {
                            self.children = Object.values(list).map(WifiEntry)
                        }
                    })
                }
            })
        }}
    />
}

function WifiEntry(wifi: WifiInfo) {
    return <box>
        <label label={wifi.SSID} />
        {wifi.SECURITY !== '' &&
            <entry
                visible={false}
            />}
    </box>
}

class WifiInfo {
    private ssid: string
    private bssid: string
    private signal: number
    private security: string
    constructor(SSID: string, BSSID: string, SIGNAL: number, SECURITY: string) {
        this.ssid = SSID
        this.bssid = BSSID
        this.signal = SIGNAL
        this.security = SECURITY
    }

    get SSID() { return this.ssid }
    get BSSID() { return this.bssid }
    get SIGNAL() { return this.signal }
    get SECURITY() { return this.security }
}

async function get_wifi() {
    let cmd = execAsync([
        'nmcli',
        '-t',
        '--mode',
        'multiline',
        '-f',
        'SSID,BSSID,SIGNAL,SECURITY',
        'device',
        'wifi',
        'list',
        '--rescan',
        'yes'
    ])

    let out = await cmd
    if (out == '') {
        return undefined
    }

    const get_val = (field: string) => field.slice(field.indexOf(':') + 1)
    let entries = out.split('\n')

    let wifi: { [key: string]: WifiInfo } = {}
    for (let i = 1; i <= entries.length; i += 4) {
        let ssid = get_val(entries[i - 1])
        let bssid = get_val(entries[i])
        let signal = parseInt(get_val(entries[i + 1]))
        let security = get_val(entries[i + 2])

        if (ssid !== '') {
            if (ssid in wifi) {
                if (signal > wifi[ssid].SIGNAL) {
                    wifi[ssid] = new WifiInfo(ssid, bssid, signal, security)
                }
            } else {
                wifi[ssid] = new WifiInfo(ssid, bssid, signal, security)
            }
        }
    }
    return wifi
}
