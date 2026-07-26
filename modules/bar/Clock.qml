// modules/bar/Clock.qml

import Quickshell
import QtQuick
import qs.config

Text {
    text: Qt.formatDateTime(clock.date, "hh:mm")
    color: Colors.text

    font {
        family: "Rubik"
        weight: 550
        letterSpacing: 0
        pixelSize: 13
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
