import QtQuick
import Quickshell.Io

Item {
    id: service

    property string hostname: "arch"
    property string kernel: "linux"
    property string uptime: "--"

    function refresh(): void {
        if (!probe.running)
            probe.running = true;
    }

    Timer {
        interval: 30000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: service.refresh()
    }

    Process {
        id: probe
        command: ["sh", "-c", "printf '%s\\n' \"$(hostname 2>/dev/null || echo arch)\" \"$(uname -r 2>/dev/null || echo linux)\" \"$(uptime -p 2>/dev/null || echo --)\""]
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.trim().split("\n");
                service.hostname = lines[0] || "arch";
                service.kernel = lines[1] || "linux";
                service.uptime = lines[2] || "--";
            }
        }
    }
}
