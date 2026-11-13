import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import "../config.js" as Config

Scope{
    
    id: root

    property var list: []
    property var locationList: []
    property bool visibility: false
    property string out:""

    property int selected: 0

    Process{
        id: setList
        running: false
        command: ["/bin/bash", "-c", "cat ~/.config/quickshell/MenuStation/Data/code.txt"]
        stdout: StdioCollector{
            onStreamFinished: {
                root.list = this.text.trim().split("\n")
                running = false
            }
        }
    }

    Process{
        id: setLocationList
        running: false
        command: ["/bin/bash", "-c", "cat ~/.config/quickshell/MenuStation/Data/codeLocation.txt"]
        stdout: StdioCollector{
            onStreamFinished: {
                root.locationList = this.text.trim().split("\n")
                running = false
            }
        }
    }

    Process {
        id: setCode
        running: false
        command: ["/bin/bash", "-c", "codeSwitcher " + root.locationList[root.selected]]
        stdout: StdioCollector {
            onStreamFinished: {
                running = false
            }
        }
    }

    IpcHandler{
        target: "codeMenu"
        function toggle(): void {
            setList.running = true
            setLocationList.running = true
            root.visibility = !root.visibility
        }

        function select(): void {setCode.running = true}
        function up(): void {
            if ((root.selected - 1) < 0) {
                root.selected = root.list.length - 1
            } else {
                root.selected -= 1
            }
        }
        
        function down(): void {
            if ((root.selected + 1) > (root.list.length - 1)) {
                root.selected = 0
            } else {
                root.selected += 1
            }
        }

    }

    PanelWindow{
        visible: visibility
        implicitWidth: 360
        color: Config.codeMenu.backGround 
        anchors{
            left: true
            top: true
            bottom: true
        }
        
        Rectangle{
            color: Config.codeMenu.forGround
            anchors.fill: parent
            anchors.margins: 4
            radius: 10
            
            ColumnLayout{
                anchors.fill: parent
                Layout.fillWidth: true
                Layout.fillHeight: true
                // spacing: 10
                
                Repeater{
                    model: root.list

                    Rectangle{
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.margins: 10 
                        color: Config.colors.bg
                        border.color: index === root.selected ? Config.colors.blue:"transparent"
                        border.width: 1
                        radius: 10
                        
                        Text{
                            text:modelData
                            color: Config.colors.text
                            anchors.centerIn: parent
                            font.pixelSize: 15
                            font.family: Config.fontFamily
                        }
                    }
                }
            }
        }

    }
}
