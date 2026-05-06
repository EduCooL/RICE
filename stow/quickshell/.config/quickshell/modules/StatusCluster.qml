import QtQuick
import QtQuick.Layouts
import "../theme" as Theme

RowLayout {
    id: root

    property var shell: null
    property var audio: null
    property var battery: null
    readonly property bool audioMuted: audio !== null && audio !== undefined && audio.muted === true
    readonly property string audioVolume: audio && audio.volume !== undefined && audio.volume !== "" ? audio.volume : "--"
    readonly property bool batteryAvailable: battery !== null && battery !== undefined && battery.available === true
    readonly property string batteryPercent: battery && battery.percent !== undefined && battery.percent !== "" ? battery.percent : "--"

    readonly property int safeSpacingSm: metrics && metrics.spacingSm !== undefined ? metrics.spacingSm : 6
    readonly property int safePillRadius: metrics && metrics.pillRadius !== undefined ? metrics.pillRadius : 999
    readonly property int safeBarSize: type && type.barSize !== undefined ? type.barSize : 11

    spacing: safeSpacingSm

    Theme.Colors { id: colors }
    Theme.Metrics { id: metrics }
    Theme.Typography { id: type }

    StatusPill {
        label: "wifi --"
        preferredWidth: 48
    }

    StatusPill {
        label: root.audioMuted ? "muted" : "vol " + root.audioVolume + (root.audioVolume === "--" ? "" : "%")
        preferredWidth: 66
    }

    StatusPill {
        visible: true
        label: "bat " + root.batteryPercent + (root.batteryPercent === "--" ? "" : "%")
        preferredWidth: 66
    }

    ClockPill {
        Layout.preferredWidth: 58
    }

    StatusPill {
        label: "dash"
        preferredWidth: 58
        dim: true

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (root.shell && root.shell.toggleDashboard)
                    root.shell.toggleDashboard();
            }
        }
    }

    component StatusPill: Rectangle {
        property string label: ""
        property int preferredWidth: 54
        property bool dim: false

        Layout.preferredWidth: preferredWidth
        Layout.preferredHeight: 28
        radius: root.safePillRadius
        color: colors.surfacePanel
        border.width: 1
        border.color: colors.border

        Text {
            anchors.centerIn: parent
            text: parent.label
            color: parent.dim ? colors.textDim : colors.textMuted
            font.family: type.uiFont
            font.pixelSize: root.safeBarSize
            font.weight: Font.Medium
        }
    }

    component ClockPill: Rectangle {
        Layout.preferredHeight: 28
        radius: root.safePillRadius
        color: colors.surfacePanel
        border.width: 1
        border.color: colors.border

        property string timeText: Qt.formatDateTime(new Date(), "HH:mm")

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: parent.timeText = Qt.formatDateTime(new Date(), "HH:mm")
        }

        Text {
            anchors.centerIn: parent
            text: parent.timeText
            color: colors.textMain
            font.family: type.uiFont
            font.pixelSize: root.safeBarSize
            font.weight: Font.DemiBold
        }
    }
}
