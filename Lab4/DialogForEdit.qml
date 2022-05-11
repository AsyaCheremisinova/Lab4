import QtQuick 6.0
import QtQuick.Window 6.0
import QtQuick.Controls 6.0 // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 6.0


Window {
    id: root
    modality: Qt.ApplicationModal  // окно объявляется модальным
    title: qsTr("Редактирование информации о звезде")
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 200
    maximumHeight: 200

    property int currentIndex: -1

    GridLayout {
        anchors { left: parent.left; top: parent.top; right: parent.right; bottom: buttonCancel.top; margins: 10 }
        columns: 2


            Label {
                Layout.alignment: Qt.AlignRight  // выравнивание по правой стороне
                text: qsTr("Название звезды:")
            }
            TextField {
                id: textName
                Layout.fillWidth: true
                placeholderText: qsTr("Введите название")
            }
            Label {
                Layout.alignment: Qt.AlignRight
                text: qsTr("Название созвездия:")
            }
            TextField {
                id: constellation1
                Layout.fillWidth: true
                placeholderText: qsTr("Введите название созвездия")
            }
            Label {
                Layout.alignment: Qt.AlignRight
                text: qsTr("Видимая звездная величина:")
            }
            TextField {
                id: apparentMagnitude1
                Layout.fillWidth: true
                placeholderText: qsTr("Введите видимую звездную величину")
            }
            Label {
                Layout.alignment: Qt.AlignRight
                text: qsTr("Расстояние от Земли:")
            }
            TextField {
                id: distance1
                Layout.fillWidth: true
                placeholderText: qsTr("Введите расстояние от Земли:")
            }
            Label {
                Layout.alignment: Qt.AlignRight
                text: qsTr("Координаты на небосклоне:")
            }
            TextField {
                id: coordinates1
                Layout.fillWidth: true
                placeholderText: qsTr("Введите координаты")
            }


    Button {
        visible: {root.currentIndex>=0}
        anchors { right: buttonCancel.left; verticalCenter: buttonCancel.verticalCenter; rightMargin: 5; bottomMargin: 5 }
        text: qsTr("Применить")
        width: 100
        onClicked: {
            root.hide()
            edit(textName.text, constellation1.text, apparentMagnitude1.text, distance1.text, coordinates1.text,starList.currentIndex)
        }
    }
    Button {
        id: buttonCancel
        anchors { right: parent.right; bottom: parent.bottom; rightMargin: 5; bottomMargin: 5 }
        text: qsTr("Отменить")
        width: 100
        onClicked: {
             root.hide()
        }
    }
}
    function execute(name, constellation, apparentMagnitude,distance, coordinates, index)
    {
        textName.text = name
        constellation1.text = constellation
        apparentMagnitude1.text = apparentMagnitude
        distance1.text = distance
        coordinates1.text = coordinates
        root.currentIndex = index

        root.show()
    }

}
