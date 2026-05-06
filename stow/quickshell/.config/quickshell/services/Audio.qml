import QtQuick
import Quickshell.Io

QtObject {
    id: service

    property string volume: "--"
    property bool muted: false

    function refresh(): void {
        if (!probe.running)
            probe.running = true;
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: service.refresh()
    }

    Process {
        id: probe
        command: ["sh", "-c", "if command -v pamixer >/dev/null 2>&1; then printf '%s\\n%s\\n' \"$(pamixer --get-volume 2>/dev/null || echo --)\" \"$(pamixer --get-mute 2>/dev/null || echo false)\"; else printf '%s\\n%s\\n' '--' 'false'; fi"]
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.trim().split("\n");
                service.volume = lines[0] || "--";
                service.muted = (lines[1] || "false") === "true";
            }
        }
    }
}
