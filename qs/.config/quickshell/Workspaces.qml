import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell

RowLayout{

    // anchors.fill: parent
    anchors.margins: 8 

    Repeater {
        model: 10

        Rectangle{
        color: '#212121'
        width: childText.implicitWidth + 40   // Added 20px for left/right padding
        height: childText.implicitHeight // Added 10px for top/bottom padding
        radius: 15
        
        property var ws: Hyprland.workspaces.values.find(w => w.id === (index + 1))
        property bool isActive: Hyprland.focusedWorkspace?.id === (index +1)
        
            Text{
                id: childText
                anchors.centerIn: parent
                
                text: index + 1
                color: isActive ? "#00FFA0" : (ws ? "#7f0aff" : "#444b6a")
                font { pixelSize: 14; bold: true }
            }
            Rectangle {
                width: 20
                height: 3
                color: parent.isActive ? "#00FFA0" : "transparent"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                }
            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch('hl.dsp.focus({ workspace = ' + (index +1) +'})' )
            }
            
        }
    }
    // Item { Layout.fillWidth: true}
}
