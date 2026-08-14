import QtQuick

Rectangle {
    width: childText.implicitWidth + 20   // Added 20px for left/right padding
    height: childText.implicitHeight + 6 // Added 10px for top/bottom padding

    color: "#1a1d22"
     radius: 15 
    Text {
        anchors.centerIn: parent
        id: childText
        text: Time.time
        color: "#87CEFA"
        font{
            family:"JetBrainsMono Nerd Font Propo"
        }
        }
}