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
        if (level < 20)
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
