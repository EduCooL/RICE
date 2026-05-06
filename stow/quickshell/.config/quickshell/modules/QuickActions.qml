import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../theme" as Theme

Rectangle {
    id: root

    radius: metrics.cardRadius
    color: colors.surfaceCard
    border.width: 1
    border.color: colors.border
    implicitHeight: 92

    Theme.Colors { id: colors }
    Theme.Metrics { id: metrics }
    Theme.Typography { id: type }

    Process { id: lockProc; command: ["hyprlock"] }
    Process { id: reloadProc; command: ["sh", "-c", "$HOME/.config/hypr/scripts/reload.sh"] }
    Process { id: powerProc; command: ["sh", "-c", "$HOME/.config/hypr/scripts/power-menu.sh"] }

    RowLayout {
        anchors.fill: parent
        anchors.margins: metrics.spacingMd
        spacing: metrics.spacingSm

        ActionButton {
            label: "Lock"
            onClicked: lockProc.startDetached()
        }

        ActionButton {
            label: "Reload"
            onClicked: reloadProc.startDetached()
        }

        ActionButton {
            label: "Power"
            accent: true
            onClicked: powerProc.startDetached()
        }
    }

    component ActionButton: Rectangle {
        signal clicked()

        property string label: ""
        property bool accent: false

        Layout.fillWidth: true
        Layout.preferredHeight: 42
        radius: metrics.controlRadius
        color: accent ? Qt.rgba(183 / 255, 146 / 255, 95 / 255, 0.16) : Qt.rgba(23 / 255, 32 / 255, 30 / 255, 0.82)
        border.width: 1
        border.color: accent ? Qt.rgba(183 / 255, 146 / 255, 95 / 255, 0.30) : colors.border

        Text {
            anchors.centerIn: parent
            text: parent.label
            color: parent.accent ? colors.amber : colors.textMuted
            font.family: type.uiFont
            font.pixelSize: type.labelSize
            font.weight: Font.Medium
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: parent.clicked()
        }
    }
}
