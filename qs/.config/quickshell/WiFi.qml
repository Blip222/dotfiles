import QtQuick
import Quickshell
import Quickshell.Io

Rectangle {
    id: wifiWidget
    height: child.implicitHeight + 2
    width: child.implicitWidth + 20
    color: "#000000"
    radius: 10

    // Storage fields for real-time string values
    property string wifiName: "Offline"
    property string wifiBars: "  "
    property string wifiStrength: ""

    Process {
        id: wifiLoader
        // Command extracts: actively-used flag, SSID name, Nerd-Font equivalent bars text, and raw 0-100 score
        command: ["nmcli", "-t", "-f", "IN-USE,SSID,BARS,SIGNAL", "dev", "wifi"]
        running: true
        
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: (line) => {
                // If a line begins with an asterisk '*', it marks your currently active network profile
                if (line.startsWith("*")) {
                    // Split out the tabular values separated by colons (e.g. "*:HomeWiFi:▂▄▆ :82")
                    let parts = line.split(":");
                    if (parts.length >= 4) {
                        wifiWidget.wifiName = parts[1];
                        wifiWidget.wifiStrength = " (" + parts[3] + "%)";
                        
                        // Map the live text density back to clean Nerd Font icons dynamically
                        let rawStrength = parseInt(parts[3]);
                        if (rawStrength > 75) wifiWidget.wifiBars = "  ";
                        else if (rawStrength > 40) wifiWidget.wifiBars = "  ";
                        else wifiWidget.wifiBars = "  ";
                    }
                }
            }
        }
    }

    // Refresh configurations every 5 seconds
    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            wifiLoader.running = false;
            wifiLoader.running = true;
        }
    }

    Row {
        id: child
        anchors.centerIn: parent
        spacing: 5

        Text {
            // Displays your contextual signal icon
            text: wifiWidget.wifiName !== "Offline" && wifiWidget.wifiName !== "" ? wifiWidget.wifiBars : "  "
            color: '#9704bc'
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
        }

        Text {
            // Displays your SSID appended with the live parsed network strength factor
            text: wifiWidget.wifiName !== "" ? wifiWidget.wifiName + wifiWidget.wifiStrength : "Offline"
            color: "#9704bc"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
        }
    }
}
