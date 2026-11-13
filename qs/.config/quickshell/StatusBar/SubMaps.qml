import QtQuick
import Quickshell
import Quickshell.Hyprland

import "../config.js" as Config

Item {
    id: root
    implicitWidth: displayRect.implicitWidth
    implicitHeight: displayRect.implicitHeight
    property string textColor: Config.SubMaps.default
    property string icons: ""

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
                        root.textColor = Config.SubMaps.default
                        root.icons = ""
                    } 
                    else if(submapName === "quickshellSubMap"){
                        submapTracker.activeSubmap = "quickshell";
                        root.textColor = Config.SubMaps.quickshell
                        root.icons = ""
                    }
                    else if(submapName === "codeMenuSubMap"){
                        submapTracker.activeSubmap = "codeMenu"
                        root.textColor = Config.SubMaps.Menu
                        root.icons = ""
                    }
                    else if(submapName === "AppLauncherSubMap"){
                        submapTracker.activeSubmap = "AppLauncher"
                        root.textColor = Config.SubMaps.appLauncher
                        root.icons = "󰹯"
                    }
                    else {
                        submapTracker.activeSubmap = submapName;
                        root.textColor = Config.SubMaps.else
                    }
                }
            }
        }
    }

    // Visual Display Component
    Rectangle {
        id: displayRect
        implicitWidth: childText.implicitWidth + 20   
        implicitHeight: childText.implicitHeight + 7

        color: Config.colors.fg
        radius: 15 
        
        Text {
            id: childText
            anchors.centerIn: parent
            text: root.icons + " " + submapTracker.activeSubmap
            color: root.textColor
            font {
                family: Config.bar.fontFamily
            }
        }
    }
}
