import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Services.UPower 

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
            

            Item {
                id: batteryWidget
                implicitWidth: batteryText.implicitWidth
                implicitHeight: batteryText.implicitHeight

                property var battery: UPower.displayDevice
                property real pct: battery.percentage * 100


                function batteryColor() {
                    if (battery.state === UPowerDeviceState.Charging)
                        return "#39A2CA"
                    if (pct > 70)
                        return "#5FA85B"
                    if (pct > 50)
                        return "#D9C24A"
                    if (pct > 20)
                        return "#D98A3D"
                    return "#C0392B"
                }


                Text {
                    id: batteryText
                    text:"󰁹 " + Math.round(batteryWidget.pct) + "%"
                    color: batteryWidget.batteryColor()

                    font {
                    family: "Rubik"
                    weight: 550
                    letterSpacing: 0
                    pixelSize: 13
                }
                }
            }
            Item { Layout.preferredWidth: 16 }

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
