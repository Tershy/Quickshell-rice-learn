// modules/bar/Battery.qml
//
// To samo co miałeś w shell.qml, tylko:
// 1. wyjęte do osobnego pliku
// 2. kolory podmienione na Colors.green/yellow/orange/red zamiast
//    surowych hexów — wybrałeś wersję z palety po porównaniu obu

import QtQuick
import Quickshell.Services.UPower
import qs.config

Item {
    id: root
    implicitWidth: batteryText.implicitWidth
    implicitHeight: batteryText.implicitHeight

    property var battery: UPower.displayDevice
    property real pct: battery.percentage * 100

    function batteryColor() {
        if (battery.state === UPowerDeviceState.Charging)
            return Colors.sky;
        if (pct > 70)
            return Colors.green;
        if (pct > 50)
            return Colors.yellow;
        if (pct > 20)
            return Colors.orange;
        return Colors.red;
    }

    Text {
        id: batteryText
        text: "󰁹 " + Math.round(root.pct) + "%"
        color: root.batteryColor()

        font {
            family: "Rubik"
            weight: 550
            letterSpacing: 0
            pixelSize: 13
        }
    }
}
