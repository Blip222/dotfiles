//Bar.qml
import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }
      color: "#000000"
      implicitHeight: 25
      
      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        spacing: 8

        ClockWidget{}
        
        Workspaces{}
        
        SubMaps{}
        // Spacer item to push the status items to the right
        Item {
          Layout.fillWidth: true
        }

        // Standard Row handles internal component layout without breaking RowLayout parent constraints
        Row {
          spacing: 5
          Layout.alignment: Qt.AlignVCenter

          Audio {}        
          WiFi {}       
          Battery {}
        }
      }
    }
  }
}
