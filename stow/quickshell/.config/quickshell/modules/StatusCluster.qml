import QtQuick
import QtQuick.Layouts
import "../theme" as Theme

RowLayout {
    id: root

    property var shell
    property var audio
    property var battery

    spacing: metrics.spacingSm

    Theme.Colors { id: colors }
    Theme.Metrics { id: metrics }
    Theme.Typography { id: type }

    StatusPill {
        label: "wifi"
        preferredWidth: 48
    }

    StatusPill {
        label: root.audio.muted ? "muted" : "vol " + root.audio.volume + "%"
        preferredWidth: 66
    }

    StatusPill {
        visible: root.battery.available
        label: "bat " + root.battery.percent + "%"
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
            onClicked: root.shell.toggleDashboard()
        }
    }

    component StatusPill: Rectangle {
        property string label: ""
        property int preferredWidth: 54
        property bool dim: false

        Layout.preferredWidth: preferredWidth
        Layout.preferredHeight: 28
        radius: metrics.pillRadius
        color: colors.surfacePanel
        border.width: 1
        border.color: colors.border

        Text {
            anchors.centerIn: parent
            text: parent.label
            color: parent.dim ? colors.textDim : colors.textMuted
            font.family: type.uiFont
            font.pixelSize: type.barSize
            font.weight: Font.Medium
        }
    }

    component ClockPill: Rectangle {
        Layout.preferredHeight: 28
        radius: metrics.pillRadius
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
            font.pixelSize: type.barSize
            font.weight: Font.DemiBold
        }
    }
}
