import QtQuick
import Quickshell
import Quickshell.Services.UPower

Rectangle {
    id: batteryWidget
    height: child.implicitHeight + 10
    width: child.implicitWidth + 30
    color: "#000000"
    radius: 10

    // Fix: Explicitly bind the active display device locally to listen to property updates
    property UPowerDevice activeBattery: UPower.displayDevice
    property bool runningOnBattery: UPower.onBattery
    Row {
        id: child
        anchors.centerIn: parent
        spacing: 5

        Text {
            // Evaluates instantly because it listens directly to the local activeBattery property
            text: !runningOnBattery ? "⚡" : "🔋"
            color: "#FFFF00"
        }

        Text {
            // Displays percentage dynamically
            text: activeBattery ? Math.round(activeBattery.percentage * 100) + "%" : "0%"
            color: "#FFFF00"
        }
    }
}
