import QtQuick
import QtQuick.Layouts
import "../theme" as Theme

Rectangle {
    id: root

    property var hypr

    implicitWidth: 260
    implicitHeight: 28
    radius: metrics.pillRadius
    color: Qt.rgba(11 / 255, 17 / 255, 16 / 255, 0.72)
    border.width: 1
    border.color: colors.border

    Theme.Colors { id: colors }
    Theme.Metrics { id: metrics }
    Theme.Typography { id: type }

    Text {
        anchors.centerIn: parent
        width: parent.width - 24
        text: root.hypr.activeTitle || "quiet workspace"
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        color: colors.textDim
        font.family: type.uiFont
        font.pixelSize: type.barSize
        font.weight: Font.Medium
    }
}
