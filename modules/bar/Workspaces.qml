// modules/bar/Workspaces.qml
//
// Dokładnie ten sam kod co w Twoim obecnym shell.qml — tylko wyjęty do
// osobnego pliku. Zachowanie się NIE zmienia, zmienia się tylko to,
// gdzie ten kod fizycznie leży.

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
