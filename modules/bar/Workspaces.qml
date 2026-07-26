// modules/bar/Workspaces.qml

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.config

RowLayout {
    spacing: 7

    Repeater {
        model: 10

        Text {
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
            text: "  "
            color: isActive ? Colors.sky : Colors.text
        }
    }
}
