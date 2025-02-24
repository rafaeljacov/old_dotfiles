import { exec } from "astal/process"

export const bluetooth_blocked = () => exec('rfkill list bluetooth').includes('yes')
