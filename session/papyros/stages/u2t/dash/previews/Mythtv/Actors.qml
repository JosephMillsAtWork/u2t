import QtQuick 1.0
import "../../../common"
import "../../../common/utils.js" as Utils
import "../../../common/units.js" as Units
import "../../previews"

FocusScope{
    id:actorsmain
    VideoPreview{
    }
    Item {
        id: startingtxt
        height: Units.tvPx(1200)
        width: Units.tvPx(501)
        BorderImage {
            id : bordersreal
            source: "../../../dash/artwork/search_background_clear.png"
            width: 930; height: 780
            anchors.centerIn: borders
            border.left: 25; border.top: 25
            border.right: 25; border.bottom: 25
            opacity: 1
        }
        BorderImage {
            id : borders
            source: "../../../artwork/search_background.png"
            width: 930; height: 780
            anchors.centerIn: txtbackground
            border.left: 25; border.top: 25
            border.right: 25; border.bottom: 25
            //   opacity: .72
        }

        PreviewImageBox {
            id: txtbackground
            anchors.top: parent.top
            anchors.topMargin: Units.tvPx(100)
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(70)
            //        property variant height
            width:Units.tvPx(899)
            height:Units.tvPx(766)
            color: "Transparent"
            opacity: .95
            clip: true
        }
        // Back to the start
        Loader{
            id:loaderto
            source: "../VideoPreview.qml"
        }
        ///Start the actor boxs
        //1
        Image {
            id:actorpicture2
            anchors.top: parent.top
            anchors.topMargin: Units.tvPx(110)
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(70)
            width: 200
            height: 350
            opacity: 1
            property string baseText:"%1"
            source: (nfo.isMovie) ? "" : uri.substring(0, uri.lastIndexOf("Season"))+".actors/"+baseText.arg((nfo.video.actor1.split(" ").join("_")))+".tbn"

            PictureGlowButton{
                id:actor1
                //           clip: true
                text: "Testing"
                anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter// + Units.tvPx(5)
                anchors.horizontalCenter: parent.horizontalCenter // + Units.tvPx(10)
                onClicked: actorpicture2.state == "" ? actorpicture2.state = "actorglow1" : actorpicture2.state = ""
           }
        }
                states: [
                    State {
                        name: "actorglow1"
                        PropertyChanges {
                            target: actorpicture2
                            scale: 4
                        }
                        PropertyChanges {
                            target: actorpicture2
                            width: actorpicture2.width / 2
                            height: actorpicture2.height / 2
                        }
                    }
                ]
                transitions: [
                    Transition {
                        SequentialAnimation{
                            NumberAnimation {properties: "width,height";duration: 800000}
                            NumberAnimation {property: "scale"}
                        }
                    }
                ]



        //2
        Image {
            id:actorpicture3
            anchors.top: parent.top
            anchors.topMargin: Units.tvPx(110)
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(300)
            property string baseText:"%1"
            source: (nfo.isMovie) ? "" : uri.substring(0, uri.lastIndexOf("Season"))+".actors/"+baseText.arg((nfo.video.actor2.split(" ").join("_")))+".tbn"
            width: 200; height: 350
            opacity: 1
            states: [
                State {
                    name: "actorglow2"
                    PropertyChanges {
                        target: actorpicture3
                        scale: 4
                    }
                    PropertyChanges {
                        target: actorpicture3
                        width: actorpicture3.width /2
                        height: actorpicture3.height /2
                    }
                }
            ]
            PictureGlowButton{
                anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: actorpicture3.state == "" ? actorpicture3.state = "actorglow2" : actorpicture3.state = ""

                transitions: [
                    Transition {
                        SequentialAnimation{
                            NumberAnimation {properties: "width,height";duration: 800000}
                            NumberAnimation {property: "scale"}
                        }
                    }
                ]
            }
        }
        //3
        Image {
            id:actorpicture4
            anchors.top: parent.top
            anchors.topMargin: Units.tvPx(110)
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(530)
            property string baseText:"%1"
            source: (nfo.isMovie) ? "" : uri.substring(0, uri.lastIndexOf("Season"))+".actors/"+baseText.arg((nfo.video.actor3.split(" ").join("_")))+".tbn"
            width: 200; height: 350
            opacity: 1
            states: [
                State {
                    name: "actorglow3"
                    PropertyChanges {
                        target: actorpicture4
                        scale: 4
                    }
                    PropertyChanges {
                        target: actorpicture4
                        width: actorpicture4.width /2
                        height: actorpicture4.height /2

                    }

                }
            ]
            PictureGlowButton{
                anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: actorpicture4.state == "" ? actorpicture4.state = "actorglow3" : actorpicture4.state = ""

                transitions: [
                    Transition {
                        SequentialAnimation{
                            NumberAnimation {properties: "width,height";duration: 800000}
                            NumberAnimation {property: "scale"}
                        }
                    }
                ]
            }
        }
        //4
        Image {
            id:actorpicture5
            anchors.top: parent.top
            anchors.topMargin: Units.tvPx(110)
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(760)

            property string baseText:"%1"
            source: (nfo.isMovie) ? "" : uri.substring(0, uri.lastIndexOf("Season"))+".actors/"+baseText.arg((nfo.video.actor4.split(" ").join("_")))+".tbn"
            width: 200; height: 350
            opacity: 1
            states: [
                State {
                    name: "actorglow4"
                    PropertyChanges {
                        target: actorpicture5
                        scale: 4
                    }
                    PropertyChanges {
                        target: actorpicture5
                        width: actorpicture5.width /2
                        height: actorpicture5.height /2

                    }

                }
            ]
            PictureGlowButton{
                anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: actorpicture5.state == "" ? actorpicture5.state = "actorglow4" : actorpicture5.state = ""

                transitions: [
                    Transition {
                        SequentialAnimation{
                            NumberAnimation {properties: "width,height";duration: 800000}
                            NumberAnimation {property: "scale"}
                        }
                    }
                ]
            }
        }

        //5
        Flipable{
            id: container
                        property bool fliped: true
            property int xAxis: 0
            property int yAxis: 0
            property int angle: 0
            width: 200
            height: 350
            Image {
                id:actorpicture6
                anchors.top: parent.top
                anchors.topMargin: Units.tvPx(500)
                anchors.left: parent.left
                anchors.leftMargin: Units.tvPx(70)
                property string baseText:"%1"
                source: (nfo.isMovie) ? "" : uri.substring(0, uri.lastIndexOf("Season"))+".actors/"+baseText.arg((nfo.video.actor5.split(" ").join("_")))+".tbn"
                width: 200
                height: 350
                opacity: 1

                PictureGlowButton{
    //                    focus: true
                    anchors.fill: container
                    onClicked: container.fliped = !container.fliped
            }

        }
            transform: Rotation{
                id: rotation; origin.x: container.width / 2 ; origin.y: container.height / 2
                axis.x: container.xAxis; axis.y: container.yAxis; axis.z: 0
               }

                   states: State {
                        name: "actorglow5"; when: container.fliped
                        PropertyChanges {
                            target: rotation; angle:container.angle
                        }
                    }
                    transitions: [
                        Transition {
                            ParallelAnimation{
                                NumberAnimation{ target:rotation;property:"angle";duration: 800 }
                                SequentialAnimation{
                                    NumberAnimation{ target: container;property: "scale"; to: .80; duration: 800 }
                                    NumberAnimation{ target: container;property: "scale"; to: 1.0; duration: 800}

                                }
                            }
                        }
                    ]

}


        //6
        Image {
            id:actorpicture7
            anchors.top: parent.top
            anchors.topMargin: Units.tvPx(500)
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(300)
            width: 200
            height: 350
            property string baseText:"%1"
            source: (nfo.isMovie) ? "" : uri.substring(0, uri.lastIndexOf("Season"))+".actors/"+baseText.arg((nfo.video.actor6.split(" ").join("_")))+".tbn"
            opacity: 1
            states: [
                State {
                    name: "actorglow6"
                    PropertyChanges {
                        target: actorpicture7
                        scale: 4
                    }
                    PropertyChanges {
                        target: actorpicture7
                        width: actorpicture7.width / 2
                        height: actorpicture7.height / 2
                    }
                }
            ]
            PictureGlowButton{
                anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: actorpicture7.state == "" ? actorpicture7.state = "actorglow6" : actorpicture7.state = ""

                transitions: [
                    Transition {
                        SequentialAnimation{
                            NumberAnimation {properties: "width,height";duration: 800000}
                            NumberAnimation {property: "scale"}
                        }
                    }
                ]
            }
        }
        //7
        Image {
            id:actorpicture8
            anchors.top: parent.top
            anchors.topMargin: Units.tvPx(500)
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(530)

            property string baseText:"%1"
            source: (nfo.isMovie) ? "" : uri.substring(0, uri.lastIndexOf("Season"))+".actors/"+baseText.arg((nfo.video.actor7.split(" ").join("_")))+".tbn"
            width: 200; height: 350
            opacity: 1
            states: [
                State {
                    name: "actorglow7"
                    PropertyChanges {
                        target: actorpicture8
                        scale: 4
                    }
                    PropertyChanges {
                        target: actorpicture8
                        width: actorpicture8.width /2
                        height: actorpicture8.height /2
                    }
                }
            ]
            PictureGlowButton{
                anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: actorpicture8.state == "" ? actorpicture8.state = "actorglow7" : actorpicture8.state = ""

                transitions: [
                    Transition {
                        SequentialAnimation{
                            NumberAnimation {properties: "width,height";duration: 800000}
                            NumberAnimation {property: "scale"}
                        }
                    }
                ]
            }
        }
        //8
        Image {
            id:actorpicture9
            anchors.top: parent.top
            anchors.topMargin: Units.tvPx(500)
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(760)

            property string baseText:"%1"
            source: (nfo.isMovie) ? "" : uri.substring(0, uri.lastIndexOf("Season"))+".actors/"+baseText.arg((nfo.video.actor8.split(" ").join("_")))+".tbn"
            width: 200; height: 350
            opacity: 1
            states: [
                State {
                    name: "actorglow8"
                    PropertyChanges {
                        target: actorpicture9
                        scale: 4
                    }
                    PropertyChanges {
                        target: actorpicture9
                        width: actorpicture9.width /2
                        height: actorpicture9.height /2
                    }
                }
            ]
            PictureGlowButton{
                anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: actorpicture9.state == "" ? actorpicture9.state = "actorglow8" : actorpicture9.state = ""

                transitions: [
                    Transition {
                        SequentialAnimation{
                            NumberAnimation {properties: "width,height";duration: 800000}
                            NumberAnimation {property: "scale"}
                        }
                    }
                ]
            }
        }

        GlowButton{
            id: buttonBack
            focus: true
            text: "Back"
            anchors.top: parent.top
            anchors.topMargin: Units.tvPx(880)
            anchors.left: parent.left
            anchors.leftMargin: Units.tvPx(280)
//            KeyNavigation.left: fakebutton
            onClicked:{
                loaderto.visible = true;
                //loaderto.source = "../VideoPreview.qml";
                actorsmain.visible = false;
                extratextandinfo.visible  = true;
                extratextandinfo.visible  = true;
                previewImageDropShadow.visible  = true;
                buttonIngh.visible  = true;
                buttonIngh1.visible  = true;
                buttonIngh2.visible  = true;
                buttonIngh3.visible  = true;
                buttonIngh4.visible  = true;
                buttonBuy.visible  = true;
                buttonPlay.visible  = true;
                buttonRent.visible  = true;
                fanArtButton.visible  = true;
                previewImage.visible  = true;
                previewImage1.visible  = true;
                previewImageDropShadow.visible  = true;
                previewImageDropShadow1.visible  = true;

            }
        }
    }
}
