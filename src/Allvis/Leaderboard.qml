import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3

Page {
    id: leaderboard
    y: 48
    width: 800
    height: 480 - y
    title: qsTr("Poengtavle")

    property alias leaderboardGameScoreText: leaderboardGameScoreText

    Text {
        id: leaderboardGameScoreText
        x: 387
        y: 70
        text: qsTr("Din poengsum: " + pGame.score + " poeng! ")
        anchors.horizontalCenterOffset: 0
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 12
        visible: pGame.played // Acquired score only shown if the game has been played
    }

    Item {
        width: leaderboardTableScores.width + leaderboardTableNames.width
        anchors.bottom: leaderboardGameScoreText.bottom
        anchors.bottomMargin: -10
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            id: leaderboardTableScores
            text: pGame.leaderboardScores
            horizontalAlignment: Text.AlignLeft
            font.pointSize: 12
        }
        Text {
            id: leaderboardTableNames
            x: leaderboardTableScores.width + 10
            text: pGame.leaderboardNames
            horizontalAlignment: Text.AlignLeft
            font.pointSize: 12
        }
    }
}
