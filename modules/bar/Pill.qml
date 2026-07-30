// modules/bar/Pill.qml
//
// Reużywalny kontener "pigułki" — zaokrąglone tło z paddingiem,
// opakowujące dowolną zawartość. Wzorowany na stylu Rectangle już
// użytym w Workspaces.qml (radius 15, Colors.surface0).
//
// Użycie:
//   Pill {
//       Text { text: "coś" }
//   }
//
// Mechanizm: `default property Item content` + `data: [content]` to
// standardowy QML idiom na "kontener opakowujący". Dzięki `default
// property` wszystko co wpiszesz między klamrami { } komponentu Pill
// (bez podawania nazwy property) trafia automatycznie do `content`.
// Rozmiar pigułki (implicitWidth/Height) jest liczony na podstawie
// rozmiaru zawartości + paddingu, więc nie trzeba go ustawiać ręcznie
// przy każdym użyciu.

import QtQuick
import QtQuick.Layouts
import qs.config

Rectangle {
    id: root

    // Row (zamiast zwykłego Item) liczy swój implicitWidth/Height
    // automatycznie na podstawie dzieci, bez ryzyka binding loop
    // opisanego w dokumentacji Quickshella przy używaniu childrenRect.
    default property alias content: contentRow.children

    property int horizontalPadding: 10
    property int verticalPadding: 4

    implicitWidth: contentRow.implicitWidth + horizontalPadding * 2
    implicitHeight: contentRow.implicitHeight + verticalPadding * 2

    radius: implicitHeight / 2 // pełne zaokrąglenie — "pigułka", nie zaokrąglony prostokąt
    color: Colors.surface0

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: 6
    }
}
