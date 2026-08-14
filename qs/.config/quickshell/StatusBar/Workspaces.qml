import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell

RowLayout{
  // anchors.fill: parent
    anchors.margins: 8 
    spacing: 0

    Repeater {
        // spacing: 0
        model: 10
        id:workspaceIcons
        Rectangle{
        color: "black"//'#212121'
        width: childText.implicitWidth +11
        height: childText.implicitHeight+4
        border.color: '#5900ffff'
        border.width: 1
        // radius: 15
        
        property var ws: Hyprland.workspaces.values.find(w => w.id === (index + 1))
        property bool isActive: Hyprland.focusedWorkspace?.id === (index +1)
        
            Text{
                id: childText
                anchors.centerIn: parent
                
                text: index + 1
                //00FFA0
                color: isActive ? '#00ffff' : (ws ? "#7f0aff" : "#abb2bf")
                font { pixelSize: 14; 
                        bold: true;
                        family:"JetBrainsMono Nerd Font Propo" }
            }
            Rectangle {
                width: 18
                height: 3
                color: parent.isActive ? "#00ffff" : "transparent"
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
