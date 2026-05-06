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
    property bool dashboardOpen: false

    visible: dashboardOpen
    focusable: true
    exclusiveZone: 0
    implicitWidth: metrics.panelWidth
    implicitHeight: 650

    anchors {
        top: true
        right: true
    }

    margins {
        top: metrics.dashboardTopMargin
        right: metrics.barMargin
    }

    Theme.Colors { id: colors }
    Theme.Metrics { id: metrics }
    Theme.Typography { id: type }

    Rectangle {
        anchors.fill: parent
        radius: metrics.panelRadius
        color: colors.surfacePanel
        border.width: 1
        border.color: colors.border

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: metrics.spacingLg
            spacing: metrics.spacingMd

            RowLayout {
                Layout.fillWidth: true

                Text {
                    text: "Dashboard"
                    color: colors.textMain
                    font.family: type.uiFont
                    font.pixelSize: type.titleSize
                    font.weight: Font.DemiBold
                    Layout.fillWidth: true
                }

                Text {
                    text: "Stage 3"
                    color: colors.textDim
                    font.family: type.uiFont
                    font.pixelSize: type.labelSize
                }
            }

            SystemCard {
                Layout.fillWidth: true
                system: root.system
            }

            ClockCard {
                Layout.fillWidth: true
            }

            QuickActions {
                Layout.fillWidth: true
            }

            StatusCard {
                Layout.fillWidth: true
                audio: root.audio
                battery: root.battery
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }

    component StatusCard: Rectangle {
        property var audio
        property var battery

        implicitHeight: 126
        radius: metrics.cardRadius
        color: colors.surfaceCard
        border.width: 1
        border.color: colors.border

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: metrics.spacingMd
            spacing: metrics.spacingSm

            Text {
                text: "Status"
                color: colors.textMain
                font.family: type.uiFont
                font.pixelSize: type.titleSize
                font.weight: Font.DemiBold
            }

            Text {
                text: "volume  " + (parent.parent.audio.muted ? "muted" : parent.parent.audio.volume + "%")
                color: colors.textMuted
                font.family: type.uiFont
                font.pixelSize: type.labelSize
            }

            Text {
                text: parent.parent.battery.available ? "battery " + parent.parent.battery.percent + "% " + parent.parent.battery.state : "battery unavailable"
                color: colors.textMuted
                font.family: type.uiFont
                font.pixelSize: type.labelSize
            }

            Text {
                text: "network placeholder"
                color: colors.textDim
                font.family: type.uiFont
                font.pixelSize: type.labelSize
            }
        }
    }
}
