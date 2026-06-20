//Bar.qml
import Quickshell
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
      color: "transparent"
      //color: "#000000"
      implicitHeight: 30
      
      RowLayout{
        // anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        spacing: 8
        ClockWidget {
          // anchors.centerIn: parent
        
        }
        Workspaces{
          // anchors.left: parent.left
        }
        Battery{

        }
        Audio {

        }
        WiFi{

        }
      }
    }
  }
}
 