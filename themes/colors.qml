pragma Singleton
import QtQuick

QtObject {
    readonly property color base00: "#0E1312"
    readonly property color base01: "#151A19"
    readonly property color base02: "#1E2322"
    readonly property color base03: "#2A302F"

    readonly property color text00: "#D8E1DC"
    readonly property color text01: "#A7B9B1"
    readonly property color text02: "#73837D"

    readonly property color teal00: "#394F4B"
    readonly property color teal01: "#516F66"
    readonly property color teal02: "#6E8D88"
    readonly property color teal03: "#A7B9B1"

    readonly property color amber00: "#B89A6A"
    readonly property color amber01: "#E6C99A"

    readonly property color danger: "#D1786C"
    readonly property color warning: "#D8A657"
    readonly property color success: "#8BAE8B"
    readonly property color info: "#7FA6A0"

    readonly property color border: Qt.rgba(167 / 255, 185 / 255, 177 / 255, 0.18)
    readonly property color borderActive: Qt.rgba(167 / 255, 185 / 255, 177 / 255, 0.42)
    readonly property color shadow: Qt.rgba(0, 0, 0, 0.45)
}
