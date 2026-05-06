import QtQuick
import Quickshell.Io

QtObject {
    id: service

    property string percent: "--"
    property string state: ""
    readonly property bool available: percent !== "--"

    function refresh(): void {
        if (!probe.running)
            probe.running = true;
    }

    Timer {
        interval: 15000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: service.refresh()
    }

    Process {
        id: probe
        command: ["sh", "-c", "battery=$(ls /sys/class/power_supply 2>/dev/null | grep -m1 '^BAT' || true); if [ -n \"$battery\" ]; then cat \"/sys/class/power_supply/$battery/capacity\" 2>/dev/null; cat \"/sys/class/power_supply/$battery/status\" 2>/dev/null; else printf '%s\\n%s\\n' '--' ''; fi"]
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.trim().split("\n");
                service.percent = lines[0] || "--";
                service.state = lines[1] || "";
            }
        }
    }
}
