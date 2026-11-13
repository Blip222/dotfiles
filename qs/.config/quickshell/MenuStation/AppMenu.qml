import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "../config.js" as Config

Scope {
    id: root
    
    property bool visibility: false
    property int selected: 0
    property var list: []
    property string selectName:""
    property string exe:""

    IpcHandler{
        target: "apps"
        function toggle(): void{
            visibility = !visibility
        }
        function startApps(): void{
            setList.running = true
        }
        function left(): void{
            if((selected -1) < 0){
                selected = list.length() -1
            }
            else{
                selected = selected - 1
            }    
        }

        function right(): void{
            if((selected + 1) > list.length -1){
                selected = 0
            }
            else{
                selected = selected + 1
            }
        }
        function down(): void{
            if((selected + 3) > list.length -1){
                selected = 2
            }
            else{
                selected = selected + 3
            }
        }
        function up(): void{
            if((selected -3) < 0){
                selected = list.length -3
            }
            else{
                selected = selected - 3
            }
        }
        function select(): void{
            selectName = list[selected]
            findAppExe.running = true
        }
    }

function check(index): bool {
    // Determine the start index of the current page (e.g., 0, 15, 30...)
    var pageStart = Math.floor(selected / 15) * 15;
    
    // Check if the item index belongs to this 15-item block
    return (index >= pageStart && index < (pageStart + 15));
}

    
    Process{
        id: setList
        running: false
        command: ["/bin/bash", "-c", "appSearch && cat ~/.config/quickshell/MenuStation/Data/appStuff/appNames.txt"]
        stdout: StdioCollector{
            onStreamFinished: {
                root.list = this.text.trim().split("\n")
                setList.running = false
            }
        }
    }

    Process{
        id: findAppExe
        running: false
        command: ["/bin/bash", "-c", "appLaunch " + selectName]
        stdout: StdioCollector{
            onStreamFinished: {
                console.log(this.text)
                root.exe = this.text
                runApp.running = true
                findAppExe.running = false
            }
        }
    }
    Process{
        id: runApp
        running: false
        command: ["/bin/bash", "-c", root.exe + " & disown"]
        stdout: StdioCollector{
            onStreamFinished: {
                runApp.running = false
            }
        }
    }
    
    PanelWindow{
        visible: visibility
        color: "transparent"
        implicitWidth: 640
        implicitHeight: 565

        Rectangle {
            anchors.fill: parent
            color: Config.appLauncher.backGround
            radius: 12

            GridLayout{
                id: grid
                columns: 3 // Maximum number of columns
                rows: 5    // Managed automatically or defined
                rowSpacing: 10
                columnSpacing: 10
                uniformCellHeights: true 
                uniformCellWidths:true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Repeater{
                    model: root.list

                    Rectangle{
                        visible: root.check(index)
                        implicitWidth:200
                        implicitHeight:100
                        color:index === selected ?Config.appLauncher.highlight : Config.appLauncher.grid
                        radius:12
                        Text{
                            anchors.centerIn: parent
                            text: modelData
                            color:Config.appLauncher.text
                        }
                    }
                }
            }
        }
    }
}
