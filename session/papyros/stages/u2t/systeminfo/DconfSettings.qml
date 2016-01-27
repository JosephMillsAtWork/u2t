import Qt 4.7
//import Unity2d 1.0
import "../dash"
import "../common"
import  "../common/units.js" as Units
import  "../common/utils.js" as Utils
import Qt.labs.particles 1.0
import "unity2dSettings/example"
Rectangle {
    id: rectangle1
    color: "transparent"
    Rectangle {
        id: background
        width: parent.width / 4
        height: parent.height
        anchors{
            left:parent.left
            top: parent.top
            bottom: parent.bottom
        }
        gradient: Gradient {
            GradientStop { position: 0; color: "#88000000"; }
            GradientStop { position: .5; color: "#99808080"; }
            GradientStop { position: 1; color: "#70000000"; }

        }
        smooth: true
        opacity:  0.56
        border.color: "#28ffffff"
        border.width: Units.tvPx(2)
//        Particles {
//            opacity: .22
//            width: 1
//            height: 1
//            source: "qmltemplates/TabBarNavigation/component/gfx/oneDot.png"
//            lifeSpan: 3500
//            count: 250
//            angle: 270
//            angleDeviation: 45
//            velocity: 50
//            velocityDeviation: 30
//            anchors{
//                bottom:parent.bottom
//                horizontalCenter: parent.horizontalCenter
//            }
//    }
//        Particles {
//            opacity: .22
//            width: 1
//            height: 1
//            source: "qmltemplates/TabBarNavigation/component/gfx/oneDot.png"
//            lifeSpan: 5000
//            count: 250
//            angle: 270
//            rotation: 180
//            angleDeviation: 45
//            velocity: 50
//            velocityDeviation: 30
//            anchors{
//                top:parent.top
//                horizontalCenter: parent.horizontalCenter
//            }
//    }
}

    TabBarNavigation{
    anchors{
        left: background.left
        top: background.top
    }
}
}
