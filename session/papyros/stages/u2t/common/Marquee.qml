import QtQuick 1.1
import "../common"
import "../dash/filters/sidebar"
import "../common/units.js" as Units
import "../common/utils.js" as Utils

Rectangle{
    width: parent.width
    height: marqueeText.height + padding
    clip: true

    // text to be displayed by the Marquee
    property string text

    // top/bottom text padding
    property int padding : 10

    // the font size used by the Marquee
    property int fontSize : 44

    // the scrolling animation interval
    property int interval : 100

    // the text color
    property color textColor: "white"


    Text {
        anchors.verticalCenter: parent.verticalCenter
        //anchors.left: parent.left
        //x: Units.tvPx(30)
        id: marqueeText
        font.pointSize: fontSize
        color: textColor
        text: parent.text
        x:parent.width -Units.tvPx(1020)
    }

    Timer {
        interval: parent.interval
        onTriggered: moveMarquee()
        running: true
        repeat: true
    }

    function moveMarquee()
    {
        if(marqueeText.x + marqueeText.width < 0)
        {
            marqueeText.x = marqueeText.parent.width;
        }
        marqueeText.x -= 10;
    }
}
