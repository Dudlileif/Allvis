import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import QtQuick.VirtualKeyboard 2.3
import QtGraphicalEffects 1.0

Page {
    id: game
    y: 48
    width: 800
    height: 480 - y
    title: qsTr("Spill")

    // Variables that are used by some of the elements below
    property int gameFontSize: 12
    property string arrowActiveColor
    property string colorRed: Material.color(Material.Red, Material.Shade500)
    property string arrowColor: colorRed
    property string backgroundColor: Material.color(Material.Amber,
                                                    Material.ShadeA700)

    function play_game() {
        if (gameNameTextInput.text === "wipe") {
            // Clears the saved game data
            pGame.name = ""
            pGame.score = 0
            pGame.leader = ""
            pGame.highScore = 0
            pGame.leaderboardScores = ""
            pGame.leaderboardNames = ""
            pGame.scoreboard = []
        } else {
            pGame.score = pGame.run_game(
                        ) // Runs the game, see pythongame.cpp and game.py
            pGame.name = gameNameTextInput.text
            pGame.scoreboard.push({
                                      score: pGame.score,
                                      name: pGame.name
                                  })
            pGame.scoreboard.sort(function (a, b) {
                return a.score - b.score
            })
            pGame.highScore = pGame.scoreboard[pGame.scoreboard.length - 1].score
            pGame.leader = pGame.scoreboard[pGame.scoreboard.length - 1].name
            for (var i = 1; i <= pGame.scoreboard.length; i++) {
                // Updates the leaderboard of the game, with the up to 10 best scores
                if (i === 1) {
                    pGame.leaderboardScores = ("Poeng")
                    pGame.leaderboardNames = ("Navn")
                }
                if (i < 11) {
                    pGame.leaderboardScores
                            += ("\n" + pGame.scoreboard[pGame.scoreboard.length - i].score)
                    pGame.leaderboardNames
                            += ("\n" + pGame.scoreboard[pGame.scoreboard.length - i].name)
                }
            }
            stackView.push("Leaderboard.qml")
        }
    }

    Button {
        id: gameButton
        width: 200
        height: 100
        text: "Start Spillet"
        anchors.verticalCenterOffset: 141
        anchors.horizontalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        enabled: (gameNameTextInput.text !== ""
                  && gameNameTextInput.text !== "Trykk her for å skrive navnet ditt")
        onClicked: {
            text = "Starter spillet..."
            gameButtonProgressBar.visible = true
            pGame.played = true
            if (gameNameTextInput.text === "Blink") {
                arrowColor = Material.color(Material.Green, Material.Shade500)
            }
            arrowActiveColor = arrowColor
            arrowActiveColor = backgroundColor
            delay.restart()
            gameLoadProgress.restart()
            enabled = false
        }

        ProgressBar {
            id: gameButtonProgressBar
            width: 200
            height: 88
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            value: 0
            visible: false
            contentItem: Rectangle {
                radius: 3
                width: parent.visualPosition * parent.width
                height: parent.height
                color: colorRed
            }
            background: Rectangle {
                color: "transparent"
            }

            NumberAnimation {
                id: gameLoadProgress
                property: "value"
                target: gameButtonProgressBar
                from: 0
                to: 1
                running: false
                duration: 5000
            }
        }
        Timer {
            id: delay
            interval: 5000
            onTriggered: {
                play_game()
                gameButtonProgressBar.visible = false
                gameButton.text = "Start spillet"
                gameButton.enabled = true
                colorRed = Material.color(Material.Red, Material.Shade500)
            }
        }
    }

    Text {
        id: gameHighScoreText
        x: 227
        y: 179
        text: qsTr("Rekord: " + pGame.highScore + " " + pGame.leader)
        anchors.horizontalCenterOffset: 0
        anchors.verticalCenterOffset: 69
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: gameFontSize
        visible: pGame.highScore
    }

    Text {
        id: gameInfoText
        x: 272
        y: 209
        width: 400
        height: 15
        text: qsTr("Sjiraffen Allvís er syk og holder på å miste flekkene sine. Det er din oppgave å trykke på flekkene som lyser rødt, slik at flekkene ikke faller av.")
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: -239
        anchors.verticalCenter: gameButton.verticalCenter
        wrapMode: Text.WordWrap
        font.pointSize: 12
    }

    Image {
        id: giraffeImage
        x: 18
        y: 87
        width: 214
        height: 258
        source: "Images/Giraffe.png"
    }
    Item {
        id: arrowItem
        x: 519
        y: 166
        width: 250
        height: 250
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: gameButton.verticalCenter
        visible: pGame.played
        Image {
            id: arrowImage
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "Images/RightPointingArrow.svg"
        }
        ColorOverlay {
            // Color overlay on the arrow to make it blink
            source: arrowImage
            color: arrowActiveColor
            anchors.fill: parent
            Behavior on color {
                SequentialAnimation {
                    loops: Animation.Infinite
                    ColorAnimation {
                        from: backgroundColor
                        to: arrowColor
                        duration: 300
                    }
                    ColorAnimation {
                        from: arrowColor
                        to: backgroundColor
                        duration: 300
                    }
                }
            }
        }
    }

    TextInput {
        id: gameNameTextInput
        x: 360
        y: 84
        width: 432
        height: 20
        text: qsTr("Trykk her for å skrive navnet ditt")
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: gameFontSize
        onEditingFinished: {
            inputPanel.active = false
            if (text === "") {
                text = qsTr("Trykk her for å skrive navnet ditt")
            }
        }

        MouseArea {
            id: gameNameTextInputMouseArea
            anchors.bottomMargin: -6
            anchors.topMargin: -25
            anchors.fill: parent
            onClicked: {
                inputPanel.active = true
                parent.forceActiveFocus()
                parent.clear()
            }
        }
        MouseArea {
            id: gameNameTextInputLeave
            height: inputPanel.y
            width: game.width
            anchors.horizontalCenter: parent.horizontalCenter
            enabled: inputPanel.active === true
            onClicked: inputPanel.active = false
        }
    }

    Button {
        // Button that pushes the leaderboard on the StackView
        id: gameLeaderboardButton
        x: 651
        y: 72
        text: qsTr("Topp 10")
        onClicked: stackView.push("Leaderboard.qml")
    }
}
