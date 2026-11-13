import Quickshell
import QtQuick
import qs.Grid.Widgets
import Quickshell.Services.Mpris

Widget {
    rectangleWidth: 200
    rectangleHeight: 140
    startingX: 100
    startingY: 100

    property MprisPlayer spotifyPlayer: {
        for (let i = 0; i < Mpris.players.values.length; i++) {
            let p = Mpris.players.values[i];
            if (p.identity.toLowerCase().includes("spotify")) {
                return p;
            }
        }
        return null;
    }

    Item {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 100

        Row {
            anchors.fill: parent
            anchors.margins: 14
            spacing: 3

            Repeater {
                model: Cava.barLevels

                Item {
                    id: barContainer
                    width: (parent.width - (parent.spacing * (Cava.barCount - 1))) / Cava.barCount
                    height: parent.height

                    Rectangle {
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: Math.max(width, parent.height * modelData)
                        radius: width / 2
                        color: "#00F0FF"

                        Behavior on height {
                            NumberAnimation {
                                duration: 50
                                easing.type: Easing.OutQuad
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 40
        color: "transparent"

        Text {
            anchors.centerIn: parent
            text: spotifyPlayer ? `${spotifyPlayer.trackArtists} - ${spotifyPlayer.trackTitle}` : "No music playing"
            color: "#00F0FF"
        }
    }
}

