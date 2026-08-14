import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Rectangle {
    id: root
    height: child.implicitHeight + 6
    width: child.implicitWidth + 30
    color: '#1a1d22'
    radius: 10

    property var sink: Pipewire.defaultAudioSink

    readonly property bool ready: sink && sink.ready
    readonly property bool muted: ready && sink.audio.muted
    readonly property int vol: ready ? Math.round(sink.audio.volume * 100) : 0 
    
    readonly property string icon: {
        if(!ready) return String.fromCodePoint(0xF0581)
        if(muted) return ""

        if(vol === 0) return String.fromCodePoint(0xF0581)
        if(vol < 34) return String.fromCodePoint(0xF057F)
        if(vol < 67) return String.fromCodePoint(0xF0580)
        
        return String.fromCodePoint(0xF057E)
    }

    Row {
        id: child
        anchors.centerIn: parent
        spacing: 5

        Text {
            // Displays mute state or standard speaker icon
            text: root.icon
            color: '#ffa200'
            font{
                family:"JetBrainsMono Nerd Font Propo"
                pixelSize:12
            }
        }

        Text {
            text: {
                if (!root.ready) return "-"
                if (root.muted) return "Muted"
                return root.vol + "%"
                }
            color: root.muted ? "#FF5048" :"#ffa200"
            font {
                family:"JetBrainsMono Nerd Font Propo"
                weight: 500
                }
        }
    }
    PwObjectTracker{
        objects: [root.sink]
    }
}
