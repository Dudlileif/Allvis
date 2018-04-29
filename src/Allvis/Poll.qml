import QtQuick 2.10
import QtQuick.Controls 2.3
import QtWebEngine 1.5

Page {
    id: poll
    y: 48
    width: 800
    height: 480 - y

    title: qsTr("Spørreundersøkelse")

    WebEngineView {
        profile: webProfile
        y: 48
        width: 800
        height: 480 - y
        url: "https://goo.gl/forms/An2C1sVhSRQEVODz1"
    }
}
