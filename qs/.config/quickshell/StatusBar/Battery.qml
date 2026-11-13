import QtQuick
import Quickshell
import Quickshell.Services.UPower

import "../config.js" as Config

Rectangle {
    id: root
    height: child.implicitHeight + 7
    width: child.implicitWidth + 30
    color: Config.colors.fg
    radius: 10

    // Fix: Explicitly bind the active display device locally to listen to property updates
    property var battery: UPower.displayDevice
    property bool charging: battery.state === UPowerDeviceState.charging
    readonly property int level: Math.round(battery.percentage * 100)

    readonly property string icon: {
        if (charging) return String.fromCodePoint(0xF0084)
        if (level >= 100) return String.fromCodePoint(0xF0079)
        if (level < 10) return String.fromCodePoint(0xF0083)
        return String.fromCodePoint(0xF007A + (Math.floor(level / 10)-1))
    }

    Row {
        id: child
        anchors.centerIn: parent
        spacing: 5

        Text {
            // Evaluates instantly because it listens directly to the local activeBattery property
            text: root.icon
            color: root.charging ? "#7ad9a8" : root.level <=15 ? Config.battery.iconLow : root.level <= 30 ? Config.battery.iconMid : Config.battery.iconOk 
            font{
                family: Config.bar.fontFamily
                // pixelSize: 14
            }
        }
        Text{
            text: root.level + "%"
            color: Config.battery.text

            font{
                family: Config.bar.fontFamily
                weight: 500
            }
        }
    }
}
