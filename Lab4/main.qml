import QtQuick 6.0
import QtQuick.Window 6.0
import QtQuick.Controls 6.0 // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 6.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Звёзды")


    // объявляется системная палитра
    SystemPalette {
          id: palette;
          colorGroup: SystemPalette.Active
       }

    Rectangle{
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: btnAdd.top
        anchors.bottomMargin: 8
        border.color: "gray"

    ScrollView {
        anchors.fill: parent

        ListView {
            id: starList
            anchors.fill: parent
            model: starModel // назначение модели, данные которой отображаются списком
            delegate: StarDelegate{}
            clip: true //
            activeFocusOnTab: true  // реагирование на перемещение между элементами ввода с помощью Tab
            focus: true  // элемент может получить фокус
        }
    }
   }

    Label{
        id:label1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 9
        anchors.rightMargin: 10
        anchors.leftMargin: 1
        anchors.right:textt.left
        text: "Введите видимую
звездную величину:"

    }
    TextField{
        id:textt
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.rightMargin: 8
        anchors.right:label.left
        width: 70
        validator: IntValidator {bottom: 0; top:100000;}
    }
    Label{
        id:label
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 13
        anchors.rightMargin: 8
        anchors.right:btnAdd.left
        width: 100

        text: "Результат:  "+ find(textt.text)

    }
//    Button {
//        id: btnFind
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 8
//        anchors.rightMargin: 8
//        anchors.right:btnAdd.left
//        text: "Проверить"
//        width: 100

//        onClicked: find(textt.text)
//    }

    Button {
        id: btnAdd
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.rightMargin: 8
        anchors.right:btnEdit.left
        text: "Добавить"
        width: 100

        onClicked: windowAdd.show()
    }

    Button {
        id: btnEdit
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: btnDel.left
        anchors.rightMargin: 8
        text: "Редактировать"
        width: 100

        onClicked: {
            var name = starList.currentItem.starData.nameOfStar
            var constellation = starList.currentItem.starData.constellationOfStar
            var apparentMagnitude = starList.currentItem.starData.apparentMagnitudeOfStar
            var distance = starList.currentItem.starData.distanceOfStar
            var coordinates = starList.currentItem.starData.coordinatesOfStar
            windowEdit.execute(name, constellation, apparentMagnitude, distance, coordinates, starList.currentIndex)
        }
    }

    Button {
        id: btnDel
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right:parent.right
        anchors.rightMargin: 8
        text: "Удалить"
        width: 100
        enabled: starList.currentIndex >= 0
        onClicked: del(starList.currentIndex)
    }

    DialogForAdd {
        id: windowAdd
    }
    DialogForEdit{
        id: windowEdit
    }
}
