import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell

import "../config.js" as Config

RowLayout{
    anchors.margins: 8 
    spacing: 0

    Repeater {
        model: 10
        id:workspaceIcons
        Rectangle{
        color: Config.workSpaces.backGround
        width: childText.implicitWidth +11
        height: childText.implicitHeight+4
        border.color:  Config.workSpaces.border //"#5900ffff"
        border.width: 1
        // radius: 15
        
        property var ws: Hyprland.workspaces.values.find(w => w.id === (index + 1))
        property bool isActive: Hyprland.focusedWorkspace?.id === (index +1)
        
            Text{
                id: childText
                anchors.centerIn: parent
                
                text: index + 1
                //00FFA0
                color: isActive ? Config.workSpaces.active : (ws ? Config.workSpaces.something : Config.workSpaces.nonActive)
                font { pixelSize: 14; 
                        bold: true;
                        family: Config.bar.fontFamily}
            }
            Rectangle {
                width: 18
                height: 3
                color: parent.isActive ? Config.workSpaces.active : "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                }
            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch('hl.dsp.focus({ workspace = ' + (index +1) +'})' )
            }
            
        }
    }// Item { Layout.fillWidth: true}
}
