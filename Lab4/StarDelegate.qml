import QtQuick 6.0
import QtQuick.Window 6.0
import QtQuick.Controls 6.0 // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 6.0

Rectangle {
    id: starItem
    readonly property color evenBackgroundColor: "#ffe8fd"  // цвет для четных пунктов списка
    readonly property color oddBackgroundColor: "#fccff8"   // цвет для нечетных пунктов списка
    readonly property color selectedBackgroundColor: "#fa9bf0"  // цвет выделенного элемента списка
    readonly property color onclickedBackgroundColor: "#f078e4"

    property bool isCurrent: starItem.ListView.view.currentIndex === index   // назначено свойство isCurrent истинно для текущего (выделенного) элемента списка
    property bool selected: starItemMouseArea.containsMouse || isCurrent // назначено свойство "быть выделенным",
    //которому присвоено значение "при наведении мыши,
    //или совпадении текущего индекса модели"

    property variant starData: model // свойство для доступа к данным конкретной звезды

    width: parent ? parent.width : starList.width
    height: 120

    // состояние текущего элемента (Rectangle)
    states: [
        State {
            when: selected
            // как реагировать, если состояние стало selected
            PropertyChanges { target: starItem;  // для какого элемента должно назначаться свойство при этом состоянии (selected)
                color: isCurrent ? onclickedBackgroundColor : selectedBackgroundColor  /* какое свойство целевого объекта (Rectangle)
               // color: isCurrent ? palette.highlight : selectedBackgroundColor  /* какое свойство целевого объекта (Rectangle)
                                                                                                  и какое значение присвоить*/
            }
        },
        State {
            when: !selected
            PropertyChanges { target: starItem;  color: isCurrent ? palette.highlight : index % 2 == 0 ? evenBackgroundColor : oddBackgroundColor }
        }
    ]

    MouseArea {
        id: starItemMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            starItem.ListView.view.currentIndex = index
            starItem.forceActiveFocus()
        }
    }
    Item {
        id: itemOfStars
        width: parent.width
        height: 120
        Column{
            id: t2
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 240
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: t1
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Название звезды:"
                color: "firebrick"
                font.pointSize: 12
            }
            Text {
                id: textName
                anchors.horizontalCenter: parent.horizontalCenter
                text: nameOfStar
                color: "purple"
                font.pointSize: 18
                font.bold: true
            }
        }
        Column{
            id: t3
            anchors.left: t2.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {

                text: "Созвездие:"
                color: "firebrick"
                font.pointSize: 12
            }
            Text {
                id: constellation
                text: constellationOfStar
                color: "purple"
                font.pointSize: 12
            }
        }
        Column{
            anchors.left: t3.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 500
            Text {

                text: "Видимая звездная величина:"
                color: "firebrick"
                font.pointSize: 10
            }
            Text {
                id: apparentMagnitude
                color: "purple"
                text: apparentMagnitudeOfStar
                font.pointSize: 10
            }
            Text {
                text: "Расстояние от Земли:"
                color: "firebrick"
                font.pointSize: 10
            }
            Text {
                id: distance
                color: "purple"
                text: distanceOfStar
                font.pointSize: 10
            }
            Text {
                text: "Координаты на небосклоне:"
                color: "firebrick"
                font.pointSize: 10
            }
            Text {
                id: coordinates
                color: "purple"
                text: coordinatesOfStar
                font.pointSize: 10
            }
        }

    }
}
