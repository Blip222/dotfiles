import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import "../config.js" as Config

Scope {
    id: root

    property bool visibility: false
    property bool image: false
    property var menuList: []
    property var selected: 2
    property string selectedImage: ""

    function visibilityCheck(indexNumber): bool { 
    return root.visibility && 
        Math.abs(indexNumber - root.selected) <= 2
    }
    
    Process {
        id: wallpaperProcess
        running: false
        command: ["/bin/bash", "-c", "quickshellWallSet"]
        stdout: StdioCollector {
            
            onStreamFinished: {root.menuList = this.text.split(",")
                console.log(root.menuList)
                root.selectedImage = ""
                running = false
            }
            
        }
    }
    Process {
        id: setBackground
        running: false
        command: ["/bin/bash", "-c", "awww img " + selectedImage + " --transition-type='center' --transition-step=1 --transition-fps='60'"]
        stdout: StdioCollector {
            onStreamFinished: {
                running = false
            }
        }
    }



    IpcHandler {
        target: "menu"

        // General visibility controls
        function toggle(): void { root.visibility = !root.visibility }
        function show(): void { root.visibility = true }
        function hide(): void { root.visibility = false }

        // Load menu items from comma‑delimited string
        function setMenuList(str: string): void {
            root.menuList = str.split(",")
        }

        // Move selection left
        function left(): void {
            if ((root.selected - 1) < 0) {
                root.selected = root.menuList.length - 1
            } else {
                root.selected -= 1
            }
        }

        // Move selection right
        function right(): void {
            if ((root.selected + 1) > (root.menuList.length - 1)) {
                root.selected = 0
            } else {
                root.selected += 1
            }
        }

        // Toggle between text mode and image mode
        function toggleImage(): void {
            root.image = !root.image
            if(root.image){
            wallpaperProcess.running = true;
            }
        }

        function startBackground(): void{
            selectedImage = "/home/blip/wallpaper/" + menuList[root.selected]
            setBackground.running = true
        }
    }

    PanelWindow {
        anchors {
            left: true
            right: true
        }

        implicitHeight: 380
        visible: root.visibility
        exclusionMode: ExclusionMode.Ignore
        color: "black"

        RowLayout {
            anchors.fill: parent
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Repeater {
                model: root.menuList

                Rectangle {
                    visible: visibilityCheck(index)
                    color: Config.colors.bg
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.color: index === root.selected ? "blue" : "transparent"

                    // transform: Shear {
                    //     xFactor: -0.2
                    // }

                    Image {
                        visible: root.image
                        source: "file:///home/blip/wallpaper/" + modelData
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectCrop
                        
                    }

                    Text {
                        visible: !root.image
                        anchors.centerIn: parent
                        text: modelData
                        color: "white"
                        font.family: "JetBrainsMono Nerd Font Propo"
                        font.pixelSize: 24
                    }
                }
            }
        }
    }
}
