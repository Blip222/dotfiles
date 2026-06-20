import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Rectangle {
    id: volumeWidget
    height: child.implicitHeight + 9
    width: child.implicitWidth + 30
    color: "#000000"
    radius: 10


    // Bind the default audio output device locally to catch live changes
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    property PwNode defaultSink: Pipewire.defaultAudioSink

    Row {
        id: child
        anchors.centerIn: parent
        spacing: 5

        Text {
            // Displays mute state or standard speaker icon
            text: defaultSink && defaultSink.audio && defaultSink.audio.muted ? "" : ""
            color: '#ffa200'
            font.family:"JetBrainsMono Nerd Font Propo"
        }

        Text {
            // Safely parses volume fraction (0.0 to 1.0) into a clean percentage
            text: defaultSink && defaultSink.audio ? Math.round(defaultSink.audio.volume * 100) + "%" : "0%"
            color: "#ffa200"
            font.family:"JetBrainsMono Nerd Font Propo"
        }
    }
}
