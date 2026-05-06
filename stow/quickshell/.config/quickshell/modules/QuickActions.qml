import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../theme" as Theme

Rectangle {
    id: root

    readonly property int safeCardRadius: metrics && metrics.cardRadius !== undefined ? metrics.cardRadius : 14
    readonly property int safeControlRadius: metrics && metrics.controlRadius !== undefined ? metrics.controlRadius : 10
    readonly property int safeSpacingSm: metrics && metrics.spacingSm !== undefined ? metrics.spacingSm : 6
    readonly property int safeSpacingMd: metrics && metrics.spacingMd !== undefined ? metrics.spacingMd : 10
    readonly property int safeLabelSize: type && type.labelSize !== undefined ? type.labelSize : 12

    radius: safeCardRadius
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
        anchors.margins: root.safeSpacingMd
        spacing: root.safeSpacingSm

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
        radius: root.safeControlRadius
        color: accent ? Qt.rgba(183 / 255, 146 / 255, 95 / 255, 0.16) : Qt.rgba(23 / 255, 32 / 255, 30 / 255, 0.82)
        border.width: 1
        border.color: accent ? Qt.rgba(183 / 255, 146 / 255, 95 / 255, 0.30) : colors.border

        Text {
            anchors.centerIn: parent
            text: parent.label
            color: parent.accent ? colors.amber : colors.textMuted
            font.family: type.uiFont
            font.pixelSize: root.safeLabelSize
            font.weight: Font.Medium
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: parent.clicked()
        }
    }
}
