import QtQuick 1.0
import Qt.labs.particles 1.0
Rectangle  {
    color: "transparent"
    anchors.fill: parent
    property alias spreadcount: color2.count
//Particles {
//    id: color1
//         width: parent.width
//         height: 30
//         source: "dots/silverdot.png"
//         lifeSpan: 5000
//         count: 50
//         angle: 70
//         angleDeviation: 36
//         velocity: 30
//         velocityDeviation: 10
//         ParticleMotionWander {
//             xvariance: 30
//             pace: 100
//         }
//     }
//    Repeater{
//        model: 4
     Particles {
         id: color2
         y: 300
         x: 120
         width: 1
         height: 1
         source: "dots/orangeDot.png"
         lifeSpan: 5000
         count: 200
         angle: 270
         angleDeviation: 45
         velocity: 50
         velocityDeviation: 30
         ParticleMotionGravity {
             yattractor: 2000
             xattractor: 0
             acceleration: 40
         }
     }

     Particles {
         id: color3
         y: 300
         x: 120
         width: 1
         height: 1
         source: "dots/silverdot.png"
         lifeSpan: 5000
         count: 200
         angle: 270
         angleDeviation: 45
         velocity: 50
         velocityDeviation: 30
         ParticleMotionGravity {
             yattractor: 1000
             xattractor: 0
             acceleration: 50
         }
     }
 }

