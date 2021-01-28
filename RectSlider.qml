import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:rOOT
    property string name:"slider"
    property int value:parseInt(slider.value)

    Row{
        anchors.fill: parent
        spacing: 10
        Text {
            text: qsTr(name)
            width: 100
            height: 30
            color: "#FFFFFF"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

        }

        Slider {
            id:slider
            width: 120
            height: 30
            from: 1
            value: 1
            to: 100

        }
        Text {
            text: parseInt(slider.value)
            width: 60
            height: 30
            color: "#FFFFFF"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
