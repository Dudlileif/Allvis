import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

Page {
    id: jokes
    y: 48
    width: 800
    height: 480 - y
    title: qsTr("Vitser")

    property int jokeNum: getRandomInt(0, jokeStorage.numOfJokes)

    function getRandomInt(min, max) {
        // Function to get a random integer between min and max
        min = Math.ceil(min)
        max = Math.floor(max)
        return Math.floor(
                    Math.random(
                        ) * (max - min)) + min // min included, max excluded
    }
    function reloadJoke() {
        // Sets a new value to jokeNum
        jokeNum = getRandomInt(0, jokeStorage.numOfJokes)
    }

    Text {
        // The joke that's shown
        id: jokesText
        x: 388
        y: 89
        width: 500
        text: jokeStorage.jokeArray[jokeNum]
        horizontalAlignment: Text.AlignLeft // Automatically updated when jokeNum changes
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 12
        wrapMode: Text.WordWrap
    }

    RoundButton {
        id: jokesFunnyButton
        x: 152
        y: 192
        width: 110
        height: 110
        anchors.verticalCenterOffset: 124
        anchors.verticalCenter: parent.verticalCenter
        onClicked: {
            jokeStorage.jokeScore[jokeNum]++ // Increase reputation of the current joke
            reloadJoke() // Loads a new joke
        }
        Image {
            // Image shown over the button
            id: jokesFunnyButtonImage
            anchors.fill: parent
            smooth: true
            source: "Images/ROFL.png"
        }
    }

    RoundButton {
        id: jokesBoringButton
        x: 352
        y: 192
        width: 110
        height: 110
        anchors.verticalCenterOffset: 124
        anchors.verticalCenter: parent.verticalCenter
        onClicked: {
            jokeStorage.jokeScore[jokeNum] -= 0.5 // Decreases reputation of the current joke
            reloadJoke() // Loads a new joke
        }
        Image {
            // Image shown over the button
            id: jokesBoringButtonImage
            anchors.fill: parent
            smooth: true
            source: "Images/Sleeping.png"
        }
    }

    RoundButton {
        id: jokesBestJokeButton
        x: 552
        y: 192
        width: 120
        height: 120
        text: qsTr("Mest populære vits")
        antialiasing: true
        scale: 1
        anchors.verticalCenterOffset: 124
        anchors.verticalCenter: parent.verticalCenter
        Material.background: "black"
        onClicked: stackView.push(
                       "BestJoke.qml") // Pushes the "Beste vits" page to the StackView
        contentItem: Text {
            id: jokesBestJokeButtonText
            text: parent.text
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
