import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

ShellRoot {
    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: 30
        color: "#0B1D2F"
        exclusionMode: ExclusionMode.Auto

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 14
            anchors.rightMargin: 14

            RowLayout {
                spacing: 7

                Repeater {
                    model: 5

                    Text {
                        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                        text: index + 1
                        color: isActive ? "#39A2CA" : "#ffffff"
                    }
                }
            }

            Item {
                Layout.fillWidth: true
            }

            Text {
                text: Qt.formatDateTime(clock.date, "hh:mm")
                color: "#ffffff"

                font {
                    family: "Rubik"
                    weight: 550
                    letterSpacing: 0
                    pixelSize: 13
                }
            }
        }

        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }
    }
}
