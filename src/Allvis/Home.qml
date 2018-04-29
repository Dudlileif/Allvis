import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.0

Page {
    id: home
    width: 800
    height: 480

    title: qsTr("Home")

    property int menuFontSize: 9
    property string menuButtonsTextColor: "White"
    property string menuButtonsBackgroundColor: "Black" //Use var instead of string if using Material colors

    RoundButton {
        id: menuGameButton
        x: 340
        y: 30
        width: 120
        height: 120
        text: qsTr("Spill")
        font.bold: true
        font.pointSize: menuFontSize
        onClicked: stackView.push("Game.qml")
        Material.background: menuButtonsBackgroundColor
        contentItem: Text {
            id: menuGameButtonText
            text: parent.text
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: menuButtonsTextColor
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    RoundButton {
        id: menuNewsButton
        x: 252
        y: 301
        width: 120
        height: 120
        text: qsTr("Nyheter")
        font.bold: true
        font.pointSize: menuFontSize
        onClicked: stackView.push("News.qml")
        Material.background: menuButtonsBackgroundColor
        contentItem: Text {
            id: menuNewsButtonText
            text: parent.text
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: menuButtonsTextColor
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    RoundButton {
        id: menuWeatherButton
        x: 197
        y: 134
        width: 120
        height: 120
        text: qsTr("Været")
        font.bold: true
        font.pointSize: menuFontSize
        onClicked: stackView.push("Weather.qml")
        Material.background: menuButtonsBackgroundColor
        contentItem: Text {
            id: menuWeatherButtonText
            text: parent.text
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: menuButtonsTextColor
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    RoundButton {
        id: menuPollButton
        x: 428
        y: 302
        width: 120
        height: 120
        text: qsTr("Vinn\npremier")
        font.bold: true
        font.pointSize: menuFontSize
        onClicked: stackView.push("Poll.qml")
        Material.background: menuButtonsBackgroundColor
        contentItem: Text {
            id: menuPollButtonText
            text: parent.text
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: menuButtonsTextColor
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    RoundButton {
        id: menuJokesButton
        x: 483
        y: 134
        width: 120
        height: 120
        text: qsTr("Vitser")
        font.bold: true
        font.pointSize: menuFontSize
        onClicked: stackView.push("Jokes.qml")
        Material.background: menuButtonsBackgroundColor
        contentItem: Text {
            id: menuJokesButtonText
            text: parent.text
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: menuButtonsTextColor
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    RoundButton {
        id: menuAdressaButton
        width: 120
        height: 120
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        transformOrigin: Item.TopLeft
        Material.background: menuButtonsBackgroundColor
        onClicked: stackView.push("Info.qml")
        Image {
            id: menuAdressaButtonImage
            width: 100
            height: 100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "Images/AdressaIconWhite.png"
        }
    }
}
