import QtQuick 2.10
import QtQuick.Controls 2.3
import QtWebEngine 1.5

Page {
    id: weather
    y: 48
    width: 800
    height: 480 - y

    title: qsTr("Været")

    WebEngineView {
        profile: webProfile
        y: 48
        width: 800
        height: 480 - y
        url: "https://www.yr.no/nb/oversikt/dag/1-211102/Norge/Tr%C3%B8ndelag/Trondheim/Trondheim"
    }
}
