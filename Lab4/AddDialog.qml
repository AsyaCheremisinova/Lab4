import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window
{
    id: root
    modality: Qt.ApplicationModal
    title: qsTr("Добавить кота")
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 300
    maximumHeight: 300
    //property var combomodel : getBreeds()

    onVisibleChanged:
    {
      if (visible)
      {
          textName.text = ""
          textOwner.text = ""
          textAge.value = 0
          textBreed.currentIndex = "0"
      }
    }

    GridLayout
    {
        anchors
        {
            left: parent.left;
            top: parent.top;
            right: parent.right;
            bottom: buttonCancel.top;
            margins: 10
        }
        columns: 2

        Label
        {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Имя: ")
        }
        TextField
        {
            id: textName
            Layout.fillWidth: true
        }

        Label
        {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Владелец: ")
        }
        TextField
        {
            id: textOwner
            Layout.fillWidth: true
        }

        Label
        {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Полных лет: ")
        }
        SpinBox
        {
            id: textAge
            Layout.fillWidth: true
            value: 0;
        }

        Label
        {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Порода: ")
        }
        ComboBox
        {
            id: textBreed
            Layout.fillWidth: true
            //model: combomodel
            model: ["Абиссинская", "Шартрез", "Сибирская", "Сфинкс", "Сиамская"]
        }
    }

    Button
    {
        visible: {textName.length > 0 && textOwner.length > 0 && textBreed.currentIndex != -1}
        anchors { right: buttonCancel.left; verticalCenter: buttonCancel.verticalCenter; rightMargin: 10 }
        text: qsTr("Добавить")
        width: 100
        onClicked:
        {
            root.hide()
            add(textName.text, textOwner.text, textAge.value, textBreed.currentText)
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
}
