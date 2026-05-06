import QtQuick
import QtQuick.Layouts
import "../theme" as Theme

Rectangle {
    id: root

    radius: metrics.cardRadius
    color: colors.surfaceCard
    border.width: 1
    border.color: colors.border
    implicitHeight: 110

    property date now: new Date()

    Theme.Colors { id: colors }
    Theme.Metrics { id: metrics }
    Theme.Typography { id: type }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.now = new Date()
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: metrics.spacingMd
        spacing: metrics.spacingXs

        Text {
            text: Qt.formatDateTime(root.now, "dddd")
            color: colors.textDim
            font.family: type.uiFont
            font.pixelSize: type.labelSize
        }

        Text {
            text: Qt.formatDateTime(root.now, "dd MMMM")
            color: colors.textMain
            font.family: type.uiFont
            font.pixelSize: type.valueSize
            font.weight: Font.DemiBold
        }

        Text {
            text: Qt.formatDateTime(root.now, "HH:mm")
            color: colors.textMuted
            font.family: type.uiFont
            font.pixelSize: 18
        }
    }
}
