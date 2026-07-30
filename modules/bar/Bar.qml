// modules/bar/Bar.qml

import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.modules.bar

PanelWindow {
    id: bar

    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 30
    color: "transparent" // bar sam w sobie jest niewidzialny — widać tylko pigułki
    exclusionMode: ExclusionMode.Auto

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 14
        anchors.rightMargin: 14

        Workspaces {}

        Item {
            Layout.fillWidth: true
        }

        Pill {
            Battery {}
        }

        Item {
            Layout.preferredWidth: 16
        }

        Pill {
            Clock {}
        }

        Item {
            Layout.preferredWidth: 16
        }

        Pill {
            id: powerPill

            PowerMenuButton {
                id: powerButton
                onClicked: {
                    // powerButton.x byłby lokalny względem Pill (rodzica),
                    // nie względem bar — mapToItem przelicza współrzędne
                    // z układu jednego Item na układ innego, niezależnie
                    // od tego jak głęboko jest zagnieżdżony.
                    const pos = powerPill.mapToItem(bar.contentItem, 0, 0);
                    powerMenu.anchor.window = bar;
                    powerMenu.anchor.rect.x = pos.x;
                    powerMenu.anchor.rect.y = bar.implicitHeight;
                    powerMenu.visible = !powerMenu.visible;
                }
            }
        }

        PowerMenu {
            id: powerMenu
        }
    }
}
