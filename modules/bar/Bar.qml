// modules/bar/Bar.qml
//
// To jest dokładnie ten sam PanelWindow co miałeś w shell.qml, tylko:
// - workspace pills, battery, i zegar są teraz osobnymi komponentami
//   (Workspaces, Battery, Clock) zamiast kodu wpisanego bezpośrednio tutaj
// - kolor tła paska idzie z Colors.base zamiast "#0B1D2F"
//
// Zauważ: NIE importujemy osobno Workspaces/Battery/Clock — importujemy
// cały moduł `qs.modules.bar`, a QML samo znajduje pliki po nazwie
// (skoro nazwa pliku = nazwa typu). To ta sama zasada co przy Colors.

import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.modules.bar

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 30
    color: Colors.base
    exclusionMode: ExclusionMode.Auto

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 14
        anchors.rightMargin: 14

        Workspaces {}

        Item {
            Layout.fillWidth: true
        }

        Battery {}

        Item {
            Layout.preferredWidth: 16
        }

        Clock {}
    }
}
