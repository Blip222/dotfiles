import QtQuick
import Quickshell
import Quickshell.Hyprland

Item {
    id: root
    implicitWidth: displayRect.implicitWidth
    implicitHeight: displayRect.implicitHeight

    // Submap Tracker Logic
    Item {
        id: submapTracker
        property string activeSubmap: "default"

        Connections {
            target: Hyprland
            
            // Corrected to match Hyprland's native "submap" event string [1]
            function onRawEvent(event) {
                if (event.name === "submap") {
                    let submapName = event.data.trim();
                    
                    if (submapName === "") {
                        submapTracker.activeSubmap = "default";
                    } else {
                        submapTracker.activeSubmap = submapName;
                    }
                }
            }
        }
    }

    // Visual Display Component
    Rectangle {
        id: displayRect
        implicitWidth: childText.implicitWidth + 20   
        implicitHeight: childText.implicitHeight

        color: "#1a1d22"
        radius: 15 
        
        Text {
            id: childText
            anchors.centerIn: parent
            text: submapTracker.activeSubmap
            color: '#87fa89'
            font {
                family: "JetBrainsMono Nerd Font Propo"
            }
        }
    }
}
