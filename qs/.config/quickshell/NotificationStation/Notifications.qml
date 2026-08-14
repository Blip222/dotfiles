import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import "../config.js" as Config

Scope {
    id: root
    property bool centerOpen: false

    // Persistent notification history
    ListModel {
        id: history
    }

    NotificationServer {
        id: server

        actionsSupported: true
        bodySupported: true
        imageSupported: true

        onNotification: n => {
            // Ensure urgent notifications stay alive long enough to be recorded
            if (n.urgency === NotificationUrgency.Critical)
                n.timeout = 5000

            history.insert(0, {
                summary: n.summary,
                body: n.body,
                appName: n.appName,
                urgency: n.urgency,
                time: Qt.formatDateTime(new Date(), "HH:mm")
            })

            n.tracked = true
        }
    }

    IpcHandler {
        target: "notifications"
        function toggle(): void { root.centerOpen = !root.centerOpen }
        function show(): void { root.centerOpen = true }
        function hide(): void { root.centerOpen = false }
    }

    // Floating live notifications
    PanelWindow {
        anchors {
            top: true
            right: true
        }
        margins {
            top: 12
            right: 12
        }
        implicitWidth: 380
        implicitHeight: Math.max(1, column.implicitHeight)
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore

        ColumnLayout {
            id: column
            width: parent.width
            spacing: 10

            Repeater {
                model: server.trackedNotifications

                delegate: Rectangle {
                    id: card
                    required property var modelData

                    Timer {
                        running: card.modelData.urgency !== NotificationUrgency.Critical
                        interval: Config.notifications.timeout
                        onTriggered: card.modelData.dismiss()
                    }

                    Layout.fillWidth: true
                    Layout.preferredHeight: 60
                    radius: 8
                    color: Config.colors.bg
                    border.width: 2
                    border.color: modelData.urgency === NotificationUrgency.Critical
                                   ? Config.colors.red
                                   : Config.colors.purple

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        Image {
                            Layout.preferredHeight: 36
                            Layout.preferredWidth: 36
                            Layout.alignment: Qt.AlignTop
                            fillMode: Image.PreserveAspectFit

                            source: card.modelData.image && card.modelData.image !== ""
                                    ? card.modelData.image
                                    : (card.modelData.appIcon && card.modelData.appIcon !== ""
                                       ? card.modelData.appIcon
                                       : "")
                            visible: source.toString() !== ""
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            Text {
                                Layout.fillWidth: true
                                text: card.modelData.summary
                                color: Config.colors.cyan
                                font.family: Config.bar.fontFamily
                                font.pixelSize: Config.bar.fontSize
                                font.bold: true
                                elide: Text.ElideRight
                            }

                            Text {
                                Layout.fillWidth: true
                                visible: text !== ""
                                text: card.modelData.body
                                color: Config.colors.fg
                                font.family: Config.bar.fontFamily
                                font.pixelSize: Config.bar.fontSize - 1
                                wrapMode: Text.WordWrap
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: card.modelData.dismiss()
                    }
                }
            }
        }
    }

    // Notification center (history)
    PanelWindow {
        visible: root.centerOpen
        anchors {
            top: true
            right: true
        }
        margins {
            top: 12
            right: 12
        }
        implicitWidth: 380
        implicitHeight: 500   // ensures ListView always has space

        Rectangle {
            anchors.fill: parent
            radius: 10
            color: Config.colors.bg
            border.width: 2
            border.color: Config.colors.purple

            ColumnLayout {
                id: centerCol
                anchors.fill: parent
                anchors.margins: 12
                spacing: 10

                // Header
                RowLayout {
                    Layout.fillWidth: true

                    Text {
                        Layout.fillWidth: true
                        text: "Notifications"
                        color: Config.colors.cyan
                        font.family: Config.bar.fontFamily
                        font.pixelSize: Config.bar.fontSize + 2
                        font.bold: true
                    }

                    Text {
                        text: "Clear all"
                        visible: history.count > 0
                        color: Config.colors.red
                        font.family: Config.bar.fontFamily
                        font.pixelSize: Config.bar.fontSize - 1

                        MouseArea {
                            anchors.fill: parent
                            onClicked: history.clear()
                        }
                    }
                }

                // Scrollable history list
                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 8
                    clip: true
                    model: history

                    // Force delegate creation even when panel is hidden
                    cacheBuffer: 20000
                    preferredHighlightBegin: 0
                    preferredHighlightEnd: 9999

                    delegate: Rectangle {
                        width: ListView.view.width   // FIX: no more "width of null"
                        radius: 6
                        color: Config.colors.bg
                        border.width: 1
                        border.color: Config.colors.purple

                        implicitHeight: contentCol.implicitHeight + 16

                        ColumnLayout {
                            id: contentCol
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 2

                            RowLayout {
                                Layout.fillWidth: true

                                Text {
                                    Layout.fillWidth: true
                                    text: summary
                                    color: Config.colors.cyan
                                    font.family: Config.bar.fontFamily
                                    font.pixelSize: Config.bar.fontSize
                                    font.bold: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    text: time
                                    color: Config.colors.fg
                                    font.family: Config.bar.fontFamily
                                    font.pixelSize: Config.bar.fontSize - 2
                                }
                            }

                            Text {
                                Layout.fillWidth: true
                                visible: body !== ""
                                text: body
                                color: Config.colors.fg
                                font.family: Config.bar.fontFamily
                                font.pixelSize: Config.bar.fontSize - 1
                                wrapMode: Text.WordWrap
                            }

                            Text {
                                Layout.fillWidth: true
                                visible: appName !== ""
                                text: appName
                                color: Config.colors.purple
                                font.family: Config.bar.fontFamily
                                font.pixelSize: Config.bar.fontSize - 2
                                elide: Text.ElideRight
                            }
                        }
                    }
                }
            }
        }
    }
}
