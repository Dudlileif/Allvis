import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.VirtualKeyboard 2.3
import QtQuick.VirtualKeyboard.Settings 2.2
import QtQuick.Controls.Material 2.3
//Colors: https://material.io/guidelines/style/color.html#color-color-palette
import QtWebEngine 1.5
import com.PythonGame 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 480
    title: qsTr("Allvís")
    Material.theme: Material.Light
    Material.background: Material.color(Material.Amber, Material.ShadeA700)

    property bool webViewEnabled: false

    StackView {
        id: stackView
        initialItem: "Home.qml"
        anchors.fill: parent // Fills the window
        onCurrentItemChanged: {
            toolBarText.text = stackView.currentItem.title // Updates the text on the toolbar
        }
    }
    ToolBar {
        // Toolbar at the top of the window, only visible when the stackview has more than one element
        id: toolBar
        height: 48
        width: 800
        x: 0
        y: 0
        font.pointSize: 15
        enabled: stackView.depth > 1
        visible: stackView.depth > 1
        Material.background: "black"
        ToolButton {
            // Back button on the toolbar
            id: backButton
            x: 0
            y: 0
            height: 48
            text: qsTr("◀")
            font.pointSize: 15
            enabled: parent.enabled // Active when the toolbar is
            visible: parent.visible // Visible when the toolbar is
            onClicked: {
                if (webViewEnabled
                        && stackView.currentItem.title === "Nyheter") {
                    webViewEnabled = false
                } else {
                    stackView.pop(
                                ) // Removes the element at the top of the stack, i.e. the previous page is shown
                    pGame.played = false // This is done so that an acquired score isn't shown when entering the leaderboard page without playing the game
                }
            }
        }

        Text {
            // Text that shows the title of the active page on the toolbar
            id: toolBarText
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.pointSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
        }

        Text {
            // Clock on the toolbar
            id: toolBarClock
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 13
            text: (hours + ":" + minutes + ":" + seconds)
            horizontalAlignment: Text.AlignRight
            anchors.right: parent.right
            anchors.rightMargin: backButton.width / 2
            color: "white"
            property string hours
            property string minutes
            property string seconds

            function timeChanged() {
                var date = new Date
                hours = date.getHours().toString()
                minutes = date.getMinutes().toString()
                seconds = date.getSeconds().toString()
                if (hours.length < 2) {
                    // Adds a 0 in front if the number only has one digit, e.g.: 5 -> 05
                    hours = "0" + date.getHours().toString()
                }
                if (minutes.length < 2) {
                    // Adds a 0 in front if the number only has one digit, e.g.: 5 -> 05
                    minutes = "0" + date.getMinutes().toString()
                }
                if (seconds.length < 2) {
                    // Adds a 0 in front if the number only has one digit, e.g.: 5 -> 05
                    seconds = "0" + date.getSeconds().toString()
                }
            }

            Timer {
                // Timer to update the clock every 100 ms
                interval: 100
                running: true
                repeat: true
                onTriggered: toolBarClock.timeChanged()
            }
        }
    }

    InputPanel {
        //Virtual keybaord
        id: inputPanel
        z: 1
        x: 0
        y: window.height
        width: window.width
        active: false

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    PythonGame {
        id: pGame
        property bool played
        property int score
        property string name
        property int highScore
        property string leader
        property var scoreboard: []
        property string leaderboardScores
        property string leaderboardNames
    }

    Item {
        id: jokeStorage
        property var jokeArray: ["Hvis du står nede ved sjøen, så høres det ut som du holder et havskjell mot øret", "Og så var det den ene søledammen som sa til den andre:\n– Pytt pytt.", "Vet du hva den ene tørrfisken sa til den andre?\n-Long time no sea", "Vet du hvordan man kan se om det har vært en elefant i kjøleskapet?\n- Det er fotspor i leverposteien!", "Kostholdslæreren: - Hva er et balansert måltid? \nEleven: - En hamburger i hver hånd. ", "Alle barna ventet spent på desserten unntatt Lars, han var fromasj.", "Det var en gang to bananer, en var grønn og den andre var gul. En dag gjemte den grønne seg og skremte den gule. \nDa sa den gule: ”Du er så umoden.”", "Når en nygift mann ser lykkelig ut, vet vi hvorfor, men når en som har vært gift i ti år ser lykkelig ut, lurer vi på hvorfor.", "Et eple kom seg ikke inn i en bar, fordi i døra sto det ein eplenektar", "Hva heter Kinas rikeste person? \nFull Peng-Pung", "Hvis du har 5 appelsiner i den hånden og 6 epler i den andre, hva har du da? \nEnormt store hender"]
        property int numOfJokes: jokeArray.length
        property var jokeScore: []
        function initializeScores() {
            for (var i = 0; i < numOfJokes; i++) {
                jokeScore[i] = 0
            }
        }
        function getMostFun() {
            var currentMostFun = 0
            for (var i = 0; i < numOfJokes; i++) {
                if (jokeScore[i] > jokeScore[currentMostFun]) {
                    currentMostFun = i
                }
            }
            return jokeArray[currentMostFun]
        }
        Component.onCompleted: initializeScores(
                                   ) //Signals that the QML environment is ready, and runs the function once
    }

    WebEngineProfile {
        //User profile to accomodate for screen size so that it displays websites like a tablet
        id: webProfile
        httpUserAgent: "Mozilla/5.0 (X11; Tablet; Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) QtWebEngine/5.10.1 chrome/61.0.3136.140 Safari/537.36"
    }
}
