import Quickshell
import QtQuick
import QtQuick.Layouts
import "../theme" as Theme

PanelWindow {
    id: root

    property var shell
    property var hypr
    property var system
    property var audio
    property var battery

    anchors {
        top: true
        left: true
        right: true
    }

    margins {
        top: metrics.barMargin
        left: metrics.barMargin
        right: metrics.barMargin
    }

    implicitHeight: metrics.barHeight
    exclusiveZone: 0
    focusable: false

    Theme.Colors { id: colors }
    Theme.Metrics { id: metrics }
    Theme.Typography { id: type }

    Item {
        anchors.fill: parent

        RowLayout {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: metrics.spacingSm

            Rectangle {
                Layout.preferredWidth: 46
                Layout.preferredHeight: 28
                radius: metrics.pillRadius
                color: colors.surfacePanel
                border.width: 1
                border.color: colors.border

                Text {
                    anchors.centerIn: parent
                    text: "run"
                    color: colors.textMuted
                    font.family: type.uiFont
                    font.pixelSize: type.barSize
                    font.weight: Font.Medium
                }
            }

            Rectangle {
                Layout.preferredHeight: 28
                Layout.preferredWidth: 174
                radius: metrics.pillRadius
                color: Qt.rgba(11 / 255, 17 / 255, 16 / 255, 0.78)
                border.width: 1
                border.color: colors.border

                Workspaces {
                    anchors.centerIn: parent
                    hypr: root.hypr
                }
            }
        }

        ActiveWindow {
            anchors.centerIn: parent
            hypr: root.hypr
        }

        StatusCluster {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            shell: root.shell
            audio: root.audio
            battery: root.battery
        }
    }
}
