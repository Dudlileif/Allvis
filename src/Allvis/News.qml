import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import QtQml 2.3
import QtWebEngine 1.5

Page {
    id: news
    y: 48
    width: 800
    height: 480 - y
    property alias webView: webView

    title: qsTr("Nyheter")

    property var newsArray

    function reload() {
        // Function to reload the elements in the list from the json-feed
        var req = new XMLHttpRequest()
        req.open("GET",
                 "https://www.adressa.no/?widgetName=polarisFeeds&widgetId=10608015&getXmlFeed=true")
        req.onreadystatechange = function () {
            var status = req.readyState
            if (status === XMLHttpRequest.DONE) {
                var objectArray = JSON.parse(req.responseText)
                if (objectArray.errors !== undefined) {
                    console.log("Error fetching news: " + objectArray.errors[0].message)
                } else {
                    newsArray = objectArray.items
                    for (var key in newsArray) {
                        if (!newsArray[key].category.includes("Pluss")) {
                            // Filters out "Pluss" articles
                            newsListModel.append({
                                                     title: newsArray[key].title,
                                                     description: newsArray[key].description,
                                                     link: newsArray[key].link,
                                                     category: newsArray[key].category,
                                                     imagelink: newsArray[key].image
                                                 })
                        }
                    }
                }
            }
        }
        req.send()
    }

    Component.onCompleted: reload()

    ListModel {
        id: newsListModel
    }

    Component {
        id: newsDelegate
        Item {
            id: newsDelegateItem
            width: 780
            height: newsImage.height
            Component.onCompleted: {
                if (newsImage.height > newsDesc.height + newsTitle.height) {
                    newsDelegateItem.height = newsImage.height
                } else {
                    newsDelegateItem.height = newsDesc.y + newsDesc.height
                }
            }
            property int newsDelegateHeight
            Image {
                id: newsImage
                anchors.verticalCenter: parent.verticalCenter
                source: imagelink
            }
            Text {
                id: newsTitle
                x: if (newsImage.width) {
                       newsImage.width + 30
                   } else {
                       280 + 30
                   }
                width: parent.width - x
                text: title
                font.bold: true
                wrapMode: Text.WordWrap
            }
            Text {
                id: newsDesc
                text: description
                y: newsTitle.height + 10
                x: newsTitle.x
                width: parent.width - x
                wrapMode: Text.WordWrap
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    webView.url = link
                    webViewEnabled = true
                }
            }
        }
    }

    ListView {
        id: newsListView
        x: 0
        y: 48
        width: 800
        height: 432
        model: newsListModel
        delegate: newsDelegate
        spacing: 25
        Component.onCompleted: {
            newsListView.update()
        }
    }

    WebEngineView {
        id: webView
        anchors.fill: newsListView
        visible: webViewEnabled
        enabled: webViewEnabled
        profile: webProfile
    }
}
