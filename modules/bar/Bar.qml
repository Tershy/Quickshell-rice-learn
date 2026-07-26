// modules/bar/Bar.qml

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
