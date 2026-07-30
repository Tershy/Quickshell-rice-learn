// modules/bar/Battery.qml

// import QtQuick
// import Quickshell.Services.UPower
// import qs.config

// Item {
//     id: root
//     implicitWidth: batteryText.implicitWidth
//     implicitHeight: batteryText.implicitHeight

//     property var battery: UPower.displayDevice
//     property real pct: battery.percentage * 100

//     function batteryColor() {
//         if (battery.state === UPowerDeviceState.Charging)
//             return Colors.sky;
//         if (pct > 70)
//             return Colors.green;
//         if (pct > 50)
//             return Colors.yellow;
//         if (pct > 20)
//             return Colors.orange;
//         return Colors.red;
//     }

//     Text {
//         id: batteryText
//         text: "󰁹 " + Math.round(root.pct) + "%"
//         color: root.batteryColor()

//         font {
//             family: "Maple Mono NF"
//             weight: 650
//             letterSpacing: 0
//             pixelSize: 13
//         }
//     }
// }

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import qs.config

RowLayout {
    id: root
    spacing: 6

    property var battery: UPower.displayDevice
    property bool charging: battery.state === UPowerDeviceState.Charging
    readonly property int level: Math.round(battery.percentage * 100)

    readonly property string icon: {
        if (charging)
            return String.fromCodePoint(0xF0084);
        if (level >= 100)
            return String.fromCodePoint(0xF0079);
        if (level < 10)
            return String.fromCodePoint(0xF0083);

        return String.fromCodePoint(0xF007A + (Math.floor(level / 10) - 1));
    }

    Text {
        text: root.icon
        color: root.charging ? Colors.sky : root.level <= 15 ? Colors.red : root.level <= 30 ? Colors.orange : Colors.green
        font {
            family: "Maple Mono NF"
            pixelSize: 14
        }
    }
    Text {
        text: root.level + " %"
        color: Colors.text

        font {
            family: "Maple Mono NF"
            weight: 650
        }
    }
}
