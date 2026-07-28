// modules/bar/Battery.qml

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
            family: "Maple Mono NF"
            weight: 650
            letterSpacing: 0
            pixelSize: 13
        }
    }
}
