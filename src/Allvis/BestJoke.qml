import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

Page {
    id: bestJoke
    y: 48
    width:800
    height: 480-y
    title: qsTr("Mest populære vits")

    Text {
        id: bestJokeText
        width: 600
        text: jokeStorage.getMostFun()
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pointSize: 12
        wrapMode: Text.WordWrap
    }
}
