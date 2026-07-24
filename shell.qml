import Quickshell
import QtQuick
import QtQuick.Layouts

ShellRoot {
    PanelWindow{
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: 30
        color: "#0B1D2F"

        RowLayout{
            anchors.fill: parent
            anchors.leftMargin: 14
            anchors.rightMargin: 14

            Text{
                text: "workspaces:"
                color: "#ffffff"

                font{
                    family: "Rubik"
                    weight: 550
                    letterSpacing:0
                    pixelSize: 13
                }
            }

            Item {
                Layout.fillWidth: true
            }
            Text {
                text: Qt.formatDateTime(clock.date, "hh:mm")
                color: '#ffffff'

                font{
                    family: "Rubik"
                    weight: 550
                    letterSpacing:0
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