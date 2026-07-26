// modules/bar/Clock.qml
//
// SystemClock musi zostać W TYM SAMYM pliku co Text, który go używa,
// bo `clock.date` odwołuje się do niego po id — trzymamy je razem jak
// w oryginale, tylko w osobnym pliku od reszty paska.
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
