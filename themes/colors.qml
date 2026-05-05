pragma Singleton
import QtQuick

QtObject {
    readonly property color base00: "#0B1110"
    readonly property color base01: "#101716"
    readonly property color base02: "#17201E"
    readonly property color base03: "#202B28"

    readonly property color surface00: Qt.rgba(11 / 255, 17 / 255, 16 / 255, 0.72)
    readonly property color surface01: Qt.rgba(16 / 255, 23 / 255, 22 / 255, 0.78)
    readonly property color surface02: Qt.rgba(23 / 255, 32 / 255, 30 / 255, 0.84)

    readonly property color text00: "#D7DFDA"
    readonly property color text01: "#AEBDB6"
    readonly property color text02: "#7D8D86"

    readonly property color sage00: "#314844"
    readonly property color sage01: "#42635D"
    readonly property color sage02: "#6F9189"
    readonly property color sage03: "#A7B9B1"

    readonly property color amber00: "#B7925F"
    readonly property color amber01: "#E6C48F"

    readonly property color danger: "#C87469"
    readonly property color warning: "#D1A15F"
    readonly property color success: "#8AAA7F"
    readonly property color info: "#7FA6A0"

    readonly property color border: Qt.rgba(167 / 255, 185 / 255, 177 / 255, 0.14)
    readonly property color borderStrong: Qt.rgba(167 / 255, 185 / 255, 177 / 255, 0.30)
    readonly property color shadow: Qt.rgba(0, 0, 0, 0.55)
}
