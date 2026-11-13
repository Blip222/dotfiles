import Quickshell
import QtQuick
import qs.Grid.Widgets

Widget {
    rectangleWidth: 200
    rectangleHeight: 140
    startingX: 300
    startingY: 100

    Rectangle {
        property var bashVar: ""
        anchors.fill: parent
        color: "transparent"
                 
        Text {
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            height: 60
            text: bashVar
            color: "#cdd6f4" // Added color so the text is visible if the background is dark
        }

        TextInput {
            id: textInput
            anchors {
                right: parent.right
                left: parent.left
                bottom: parent.bottom
            }
            height: 70
            anchors.margins: 10
            color: "#cdd6f4"
            font.pixelSize: 14
            focus: true

            // Fixed: Changed bashVar:textInput.text to bashVar = textInput.text
            onAccepted: {
                bashVar = textInput.text; 
            }
        }
    }
}

