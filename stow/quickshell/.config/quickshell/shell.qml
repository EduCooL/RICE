import Quickshell
import QtQuick
import "./modules" as Modules
import "./services" as Services

ShellRoot {
    id: root

    property bool dashboardVisible: false

    function toggleDashboard(): void {
        dashboardVisible = !dashboardVisible;
    }

    Services.Hyprland {
        id: hypr
    }

    Services.System {
        id: system
    }

    Services.Audio {
        id: audio
    }

    Services.Battery {
        id: battery
    }

    Variants {
        variants: Quickshell.screens

        Modules.Bar {
            property var modelData

            screen: modelData
            shell: root
            hypr: hypr
            system: system
            audio: audio
            battery: battery
        }
    }

    Variants {
        variants: Quickshell.screens

        Modules.Dashboard {
            property var modelData

            screen: modelData
            shell: root
            hypr: hypr
            system: system
            audio: audio
            battery: battery
            dashboardOpen: root.dashboardVisible
        }
    }
}
