import QtQuick
import QtQuick.Layouts
import "../theme" as Theme

RowLayout {
    id: root

    property var hypr: null
    readonly property int activeWorkspaceId: hypr && hypr.activeWorkspace !== undefined ? hypr.activeWorkspace : 1

    spacing: metrics.spacingXs

    Theme.Colors { id: colors }
    Theme.Metrics { id: metrics }
    Theme.Typography { id: type }

    Repeater {
        model: [1, 2, 3, 4, 5, 6]

        Rectangle {
            required property int modelData

            readonly property bool isActive: modelData === root.activeWorkspaceId

            Layout.preferredWidth: isActive ? 28 : 22
            Layout.preferredHeight: 22
            radius: metrics.pillRadius
            color: isActive ? colors.sageActive : "transparent"
            border.width: isActive ? 1 : 0
            border.color: colors.border

            Text {
                anchors.centerIn: parent
                text: parent.modelData
                color: parent.isActive ? colors.textMain : colors.textDim
                font.family: type.uiFont
                font.pixelSize: type.barSize
                font.weight: parent.isActive ? Font.DemiBold : Font.Medium
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (root.hypr && root.hypr.switchWorkspace)
                        root.hypr.switchWorkspace(parent.modelData);
                }
            }
        }
    }
}
