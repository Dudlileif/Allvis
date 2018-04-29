import QtQuick 2.10
import QtQuick.Controls 2.3

Page {
    id: info
    y: 48
    width: 800
    height: 480 - y
    title: qsTr("Informasjon")

    Text {
        id: infoText
        x: 388
        y: 209
        width: 600
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
        text: qsTr("Sjiraffen Allvís er resultatet av et innovasjonsprosjekt rettet mot Adressaparken. Prosjektet er utført av en gruppe studenter fra Elektronisk sytemdesign og innovasjon ved NTNU våren 2018 etter ønske fra Adresseavisen om å tilføre noe nytt og spennende til parken.")
        wrapMode: Text.WordWrap
        font.pointSize: 12
    }
}
