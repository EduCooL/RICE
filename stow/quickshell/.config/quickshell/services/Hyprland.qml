import QtQuick
import Quickshell.Hyprland as Hypr

QtObject {
    id: service

    readonly property int activeWorkspace: Hypr.Hyprland.focusedWorkspace ? Hypr.Hyprland.focusedWorkspace.id : 1
    readonly property string activeTitle: {
        const top = Hypr.Hyprland.activeToplevel;
        if (!top)
            return "quiet workspace";

        const title = top.title || top.appId || "";
        return title.length > 0 ? title : "quiet workspace";
    }

    function switchWorkspace(workspaceId: int): void {
        Hypr.Hyprland.dispatch("workspace " + workspaceId);
    }
}
