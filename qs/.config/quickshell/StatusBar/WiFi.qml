import QtQuick
import Quickshell
import Quickshell.Networking

import "../config.js" as Config

Rectangle {
    id: root
    height: child.implicitHeight + 5
    width: child.implicitWidth + 20
    color: Config.colors.fg
    radius: 10

    // Storage fields for real-time string values
    property var wifiDevice: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
    property var active: wifiDevice ? wifiDevice.networks.values.find(n => n.connected) : null

    readonly property real signal: active ? active.signalStrangth : 0

    readonly property string icon: {
        if(!Networking.wifiEnabled) return String.fromCodePoint(0xF05AA)
        if(!active) return String.fromCodePoint(0xF092D)

        let tier = signal >= 0.75 ? 4
                 : signal >= 0.50 ? 3
                 : signal >= 0.25 ? 2
                 : 1
        
        return String.fromCodePoint(0xF091F + (tier -1) * 3)
    }



    Row {
        id: child
        anchors.centerIn: parent
        spacing: 5

        Text {
            // Displays your contextual signal icon
            text: root.icon
            color: Networking.wifiEnabled ? Config.wifi.iconOk : Config.wifi.iconDis
            font{
                family: Config.bar.fontFamily
                pixelSize: 13
            }
        }

        Text {
            // Displays your SSID appended with the live parsed network strength factor
            text: {
                if(!Networking.wifiEnabled) return "Offline"
                if(!root.active) return "Disconected"

                return root.active.name
            }
            color: Config.wifi.text
            font{
                family: Config.bar.fontFamily
                weight: 500
            }
        }
    }
}
