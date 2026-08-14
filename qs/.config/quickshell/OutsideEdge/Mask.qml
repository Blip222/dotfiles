// x11border.qml — standalone desktop border for X11 / bspwm
// Run: quickshell -p x11border.qml
pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Effects
import Quickshell

ShellRoot {

    PanelWindow {
        id: win

        anchors{
            top: true
            left: true
            right: true
            bottom: true 
        }  
        // implicitHeight: 
        color:  "transparent"
        mask:   Region{}

        Rectangle {
            anchors.fill: parent
            // anchors.topMargin:  //Properties.marginCover
            color:"#000000"        //Theme.borderColor

            layer.enabled: true
            layer.effect: MultiEffect {
                maskSource:       innerMask
                maskEnabled:      true
                maskInverted:     true
                maskThresholdMin: 0.5
                maskSpreadAtMin:  1.0
            }
        }

        Item {
            id: innerMask
            anchors.fill: parent
            layer.enabled: true
            visible: false

            Rectangle {
                anchors.fill:         parent
                anchors.topMargin:    0//Properties.topOffset
                anchors.leftMargin:   5//Properties.borderThickness
                anchors.rightMargin:  5//Properties.borderThickness
                anchors.bottomMargin: 5//Properties.borderThickness
                radius:               5//Properties.cornerRadius
            }
        }
    }
}