import QtQuick
import QtQuick.Layouts
import "../theme" as Theme

Rectangle {
    id: root

    property var system

    radius: metrics.cardRadius
    color: colors.surfaceCard
    border.width: 1
    border.color: colors.border
    implicitHeight: 118

    Theme.Colors { id: colors }
    Theme.Metrics { id: metrics }
    Theme.Typography { id: type }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: metrics.spacingMd
        spacing: metrics.spacingSm

        Text {
            text: "Arch Linux"
            color: colors.textMain
            font.family: type.uiFont
            font.pixelSize: type.titleSize
            font.weight: Font.DemiBold
        }

        Text {
            text: root.system.hostname + " / " + root.system.kernel
            color: colors.textMuted
            font.family: type.uiFont
            font.pixelSize: type.labelSize
            elide: Text.ElideRight
            Layout.fillWidth: true
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            color: colors.border
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: metrics.spacingMd

            MetricText {
                label: "cpu"
                value: "todo"
            }

            MetricText {
                label: "ram"
                value: "todo"
            }

            MetricText {
                label: "uptime"
                value: root.system.uptime
                Layout.fillWidth: true
            }
        }
    }

    component MetricText: ColumnLayout {
        property string label: ""
        property string value: ""

        spacing: 2

        Text {
            text: parent.label
            color: colors.textDim
            font.family: type.uiFont
            font.pixelSize: 10
        }

        Text {
            text: parent.value
            color: colors.textMuted
            font.family: type.uiFont
            font.pixelSize: 11
            elide: Text.ElideRight
        }
    }
}
