import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Grid.Widgets.Sound
import qs.Grid.Widgets.BashVar

ShellRoot {
    Variants {
        model: Quickshell.screens
        
        PanelWindow {
            required property var modelData
            screen: modelData
            
            // Set window flags to behave like a background layer
            color: "transparent"
            WlrLayershell.layer: WlrLayer.Bottom
            anchors {
                top: true
                left: true
                right: true
                bottom: true
            }

            // Canvas container allowing free dragging movement across the screen
            Item {
                anchors.fill: parent
                opacity: 0.9
                SoundWidget{}
                ValueWidget{}
            } 
        }
    }
}

