import QtQuick
import QtQuick.Layouts
import "../theme" as Theme

RowLayout {
    id: root

    property var hypr

    spacing: metrics.spacingXs

    Theme.Colors { id: colors }
    Theme.Metrics { id: metrics }
    Theme.Typography { id: type }

    Repeater {
        model: [1, 2, 3, 4, 5, 6]

        Rectangle {
            required property int modelData

            Layout.preferredWidth: modelData === root.hypr.activeWorkspace ? 28 : 22
            Layout.preferredHeight: 22
            radius: metrics.pillRadius
            color: modelData === root.hypr.activeWorkspace ? colors.sageActive : "transparent"
            border.width: modelData === root.hypr.activeWorkspace ? 1 : 0
            border.color: colors.border

            Text {
                anchors.centerIn: parent
                text: parent.modelData
                color: parent.modelData === root.hypr.activeWorkspace ? colors.textMain : colors.textDim
                font.family: type.uiFont
                font.pixelSize: type.barSize
                font.weight: parent.modelData === root.hypr.activeWorkspace ? Font.DemiBold : Font.Medium
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.hypr.switchWorkspace(parent.modelData)
            }
        }
    }
}
