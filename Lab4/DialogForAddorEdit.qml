import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window
{
    id: root
    modality: Qt.ApplicationModal
    title: qsTr("Звезды")
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 300
    maximumHeight: 300

    property bool isEdit: false
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
            id: constellation
            Layout.fillWidth: true
            placeholderText: qsTr("Введите название созвездия")
        }
//        ComboBox {
//            id: constellation
//            Layout.alignment: Qt.AlignRight
//            model: ListModel{
//                id: mm
//                ListElement {text:"Андромеда"}
//                ListElement {text:"Близнецы"}
//                ListElement {text:"Большая Медведица"}
//                ListElement {text:"Большой Пёс"}
//                ListElement {text:"Весы"}
//                ListElement {text:"Водолей"}
//                ListElement {text:"Возничий"}

//            }

//        }
//        Label {
//            Layout.alignment: Qt.AlignRight
//            text: qsTr("Видимая звездная величина:")
//        }
//        TextField {
//            id: constellation
//            Layout.fillWidth: true
//            placeholderText: qsTr("Введите название созвездия")
//        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Видимая звездная величина:")
        }
        TextField {
            id: apparentMagnitude
            Layout.fillWidth: true
            placeholderText: qsTr("Введите видимую звездную величину")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Расстояние от Земли:")
        }
        TextField {
            id: distance
            Layout.fillWidth: true
            placeholderText: qsTr("Введите расстояние от Земли:")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Координаты на небосклоне:")
        }
        TextField {
            id: coordinates
            Layout.fillWidth: true
            placeholderText: qsTr("Введите координаты")
        }
    }
    Button
    {
        anchors { right: buttonCancel.left; verticalCenter: buttonCancel.verticalCenter; rightMargin: 10 }
        text: qsTr("Подтвердить")
        width: 100
        onClicked:
        {
            root.hide()
            if (currentIndex < 0)
            {
                add(textName.text, /*constellation.currentText,*/constellation.text, apparentMagnitude.text, distance.text, coordinates.text)
            }
            else
            {
                edit(textName.text, /*constellation.currentText,*/constellation.text, apparentMagnitude.text, distance.text, coordinates.text)
            }
        }
    }
    Button
    {
        id: buttonCancel
        anchors { right: parent.right; bottom: parent.bottom; rightMargin: 10; bottomMargin: 10 }
        text: qsTr("Отмена")
        width: 100
        onClicked:
        {
             root.hide()
        }
    }

    function execute(name, owner, age, breed, index)
    {
        textName.text = name
        textOwner.text = owner
        textAge.value = age
        textBreed.currentIndex = textBreed.model.indexOf(breed)
        root.currentIndex = index

        root.show()
    }
}
