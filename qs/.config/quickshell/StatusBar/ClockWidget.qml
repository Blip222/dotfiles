import QtQuick

import "../config.js" as Config

Rectangle {
    width: childText.implicitWidth + 20   // Added 20px for left/right padding
    height: childText.implicitHeight + 6 // Added 10px for top/bottom padding

    color: Config.colors.fg
     radius: 15 
    Text {
        anchors.centerIn: parent
        id: childText
        text: Time.time
        color: Config.clock.text
        font{
            family: Config.bar.fontFamily
        }
        }
}