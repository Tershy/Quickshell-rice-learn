// modules/bar/Workspaces.qml

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.config

RowLayout {
    spacing: 7

    Repeater {
        model: 10

        Rectangle {
            id: wsButton
            required property int index

            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

            implicitWidth: label.implicitWidth + 10
            implicitHeight: 24
            radius: 12

            color: isActive ? Colors.surface0 : (ws ? Colors.surface0 : "transparent")

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }
            Text {
                id: label
                anchors.centerIn: parent
                // 
                //text: wsButton.index + 1
                text: ""
                color: wsButton.isActive ? Colors.sky : (wsButton ? Colors.text : Colors.surface0)

                font {
                    family: "Maple Mono NF"
                    pixelSize: 14
                    weight: 500
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (parent.index + 1) + "})")
            }
        }
    }
}
