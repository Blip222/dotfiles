import QtQuick
import Quickshell


    Rectangle {
        required property int rectangleWidth
        required property int rectangleHeight
        required property int startingX
        required property int startingY

        id: widgetItem
                    
        // Initial screen position
        x: startingX
        y: startingY
                    
        width: rectangleWidth 
        height: rectangleHeight
        color: "#80000000" // semi-transparent background
        radius: 12
                    

                    
        MouseArea {
            id: dragArea
            anchors.fill: parent

            // 1. Core Fix: Explicitly link the dragging action to the Rectangle
            drag.target: widgetItem

            // Optional: Keeps the widget constrained inside your monitor boundaries
            drag.minimumX: 0
            drag.maximumX: parent.parent.width - widgetItem.width
            drag.minimumY: 0
            drag.maximumY: parent.parent.height - widgetItem.height
        }

        // 2. Behaviors: These activate beautifully as soon as dragArea.drag.active becomes false
        Behavior on x { id: animX; enabled: !dragArea.drag.active; NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
        Behavior on y { id: animY; enabled: !dragArea.drag.active; NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }    
    }

