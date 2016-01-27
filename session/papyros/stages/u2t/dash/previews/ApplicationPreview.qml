import QtQuick 1.0
import Unity2d 1.0
import QtWebKit 1.0
import "../../3rdparty/softwarefake"
import "../../common"
import "../../common/units.js" as Units
import "../../common/utils.js" as Utils
import "../../common/jsonpath.js" as JSONParser
import "../../dash/"
//mimetype = name/uri
//uri == mimetype
//name = uri
VideoPreview {
    id: preview
    buttons: buttons
    Rectangle{
        id: root
        width: parent.width
        height: parent.height
        color:"transparent"
        
        Rectangle {
            id: mainBackground
            width: if (unity2dConfiguration.formFactor === "tv" )
                       parent.width / 1.38
                   else
                       parent.width / 1.2
            height: parent.height / 1.2
            border.color: "#55FFFFFF"
            border.width: 1
            gradient: Gradient {
                GradientStop { position: 0; color: "#42FFFFFF"}
                GradientStop { position: 0.5; color: "#66808080"}
                GradientStop { position: 1; color: "#42FFFFFF"}
                
            }
            anchors{
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            Row{
                id:mainRow
                width: parent.width / 1.20
                height:  parent.height
                spacing: parent.width / 15
                anchors{
                    left: parent.left
                    leftMargin: recLeft.width / 20
                    top: parent.top
                    topMargin: parent.height / 20
                }
                Rectangle{
                    id: recLeft
                    width: mainBackground.width / 2.3
                    height: mainBackground.height / 1.1
                    opacity: .77
                    border.color: "#55FFFFFF"
                    border.width: 1
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#42FFFFFF"}
                        GradientStop { position: 0.5; color: "#66808080"}
                        GradientStop { position: 1; color: "#42FFFFFF"}
                        
                    }
                    Image {
                        id: loadingIMG
                        source: "/usr/share/unity/5/launcher_bfb.png"
                        sourceSize.height: 48
                        sourceSize.width: 48
                        rotation: desktopScreenshot.status === Image.Loading ? 1 : 0
                        Behavior on rotation {NumberAnimation{from:0;to:720; duration: 1200 ; loops:Animation.Infinite }}
                        opacity: desktopScreenshot.status !== Image.Ready && desktopScreenshot.status !== Image.Error ? 1 : 0
                        anchors{
                            centerIn:  recLeft
                        }
                    }
                    Image {
                        id: desktopScreenshot
                        width: recLeft.width
                        height: recLeft.height / 1.4
                        smooth: true
                        source: if (status === Image.Error)
                                    "http://screenshots.ubuntu.com/screenshot/"+Utils.removeExt((Utils.uriToNameApps(uri)))
                                else
                                    "http://screenshots.ubuntu.com/screenshot/"+name.toLowerCase(name)
                        
                        scale: if (status === Image.Ready)
                                   1
                               else
                                   0
                        
                        Behavior on scale{NumberAnimation{from: 0;to: 1;duration: 1200;easing.type:Easing.OutQuint }}
                        anchors{
                            verticalCenter: parent.verticalCenter
                        }
                        
                    }
                    GlowButton{
                        id:  buttonOpenGlow
                        text: u2d.tr("Upload Screenshot")
                        width: recRight.width - 20
                        height: recRight.height / 10
                        x:10
                        y:desktopScreenshot.status === Image.Error ? recRight.height /2  : 50
                        Behavior on y {NumberAnimation{duration: 1200; easing.type: Easing.OutBounce}}
                        opacity: desktopScreenshot.status === Image.Error ? 1 : 0
                        Behavior on opacity {NumberAnimation{duration:  1000 ; easing.type: Easing.OutQuad}}
                        onClicked:{
                            Qt.openUrlExternally("http://screenshots.ubuntu.com/upload")
                            hidePreview()
                            shellManager.dashActive = false
                        }
                    }
                    Text {
                        id: notFoundTxt
                        color: "white"
                        width: recRight.width
                        opacity: desktopScreenshot.status === Image.Error ? 1 : 0
                        Behavior on opacity {NumberAnimation{duration:  1200 ; easing.type: Easing.OutQuad}}
                        text: u2d.tr("We are sorry but there is not screen shot avilable for that app \n Whould you like to upload One ?")
                        elide: Text.ElideMiddle
                        wrapMode: Text.WordWrap
                        anchors{
                            bottom: buttonOpenGlow.top
                            bottomMargin: 20
                        }
                    }
                    
                }
                
                
                Rectangle{
                    id: recRight
                    width: mainBackground.width / 2.3
                    height: mainBackground.height / 1.1
                    opacity: .77
                    border.color: "#55FFFFFF"
                    border.width: 1
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#42FFFFFF"}
                        GradientStop { position: 0.5; color: "#66808080"}
                        GradientStop { position: 1; color: "#42FFFFFF"}
                        
                    }
                    
                    
                    
                    Image{
                        id: defaultAppImg
                        source:status === Image.Error ? iconHint :status === Image.Error ? icon : "image://icons/"+iconHint;
                        sourceSize.width: width
                        sourceSize.height: height
                        smooth: true
                        asynchronous: true
                        scale: status == Image.Ready ? 1 : 0
                        Behavior on scale { NumberAnimation {property: "scale";from: .8;to:1;duration: 1200;easing.type: Easing.OutBounce}}
                        width: parent.height / 4
                        height: parent.height / 5
                        anchors{
                            left: recRight.left
                            leftMargin:  parent.height / 60
                            top: parent.top
                            topMargin: parent.height / 60
                        }
                    }
                    Text {
                        id: nameOfItem
                        color: "white"
                        height: defaultAppImg.height
                        anchors{
                            right: parent.right
                            top: parent.top
                            left: defaultAppImg.right
                        }
                    }
                    Marquee {
                        id:marqueeText
                        anchors.fill: nameOfItem
                        padding: 2
                        color: "transparent"
                        opacity: .95
                        textColor: "white"
                        fontSize: parent.width / 12
                        text: name
                    }
                    
                    Rectangle{
                        id: flickCommentRec
                        height:  parent.height / 4
                        width: parent.width / 1.09
                        color:"transparent"
                        anchors{
                            left: parent.left
                            leftMargin: parent.width / 20
                            topMargin: parent.height / 20
                            top: marqueeText.bottom
                        }
                        Text {
                            id: commentTxt
                            text: comment
                            font.pixelSize: 24
                            color: "white"
                            wrapMode: Text.WordWrap
                            width: parent.width
                        }
                    }
                    Image {
                        id:rightClick
                        source: "../../artwork/right_arrow_timeline.png"
                        width: parent.width / 12
                        height: parent.height / 20
                        anchors{
                            left: reviewCol.right
                            verticalCenter: reviewCol.verticalCenter
                        }
                    }MouseArea {
                        anchors.fill:rightClick;
                        onClicked: {
                            reviewTwo.opacity = 0
                            reviewOne.opacity = 1
                            reviewThree = opacity = 0
                        } }
                    Rectangle{
                        id:reviewCol
                        width: recRight.width
                        height: recRight.height / 1.7
                        opacity: .77
                        
                        border.color: "#55FFFFFF"
                        border.width: 1
                        gradient: Gradient {
                            GradientStop { position: 0; color: "#42FFFFFF"}
                            GradientStop { position: 0.5; color: "#66808080"}
                            GradientStop { position: 1; color: "#42FFFFFF"}
                            
                        }
                        anchors{
                            bottom:parent.bottom
                            left: parent.left
                        }
                    }
                    Image {
                        id:leftClick
                        source: "../../artwork/left_arrow_timeline.png"
                        width: parent.width / 12
                        height: parent.height / 20
                        anchors{
                            right: reviewCol.left
                            verticalCenter: reviewCol.verticalCenter
                        }
                    }
                    MouseArea {
                        anchors.fill:leftClick;
                        onClicked: {
                            reviewTwo.opacity = 1
                            reviewOne.opacity = 0
                            reviewThree = opacity = 0
                        }
                    }
                    Rectangle{
                        id: reviewOne
                        width: recRight.width
                        height:reviewCol.height //3;
                        opacity: .77
                        Behavior on opacity {NumberAnimation{duration: 900 ; easing.type: Easing.OutSine}}
                        border.color: "#55FFFFFF"
                        border.width: 1
                        gradient: Gradient {
                            GradientStop { position: 0; color: "#42FFFFFF"}
                            GradientStop { position: 0.5; color: "#66808080"}
                            GradientStop { position: 1; color: "#42FFFFFF"}
                            
                        }
                        anchors{
                            top: reviewCol.top
                        }
                        ListView{
                            JSONListModel {
                                id: rev1
                                source: "https://reviews.ubuntu.com/reviews/api/1.0/reviews/filter/en/ubuntu/precise/any/"+Utils.removeExt((Utils.uriToNameApps(uri)))+"/"
                                query: "$.[[1]"
                            }
                            model: rev1.model
                            section.delegate: sectionDelegate
                            section.property: "reviewer_username"
                            section.criteria: ViewSection.FirstCharacter
                            delegate: Component {
                                Text{
                                    font.pixelSize:  parent.width / 18
                                    color: "white"
                                    text:"<b>Summary:</b> \n" +Utils.splitInto( model.summary,45).join('<br>')
                                    anchors{
                                        top:parent.top
                                        left:parent.left
                                    }
                                    Text{
                                        font.pixelSize:  12
                                        color: "white"
                                        //FIXME HACKEY
                                        text:"<b>Review:</b>" + '\n' + Utils.splitInto( model.review_text, 60).join('<br>')
                                        anchors{
                                            top:parent.bottom
                                            topMargin: parent.width / 18
                                        }
                                        Text{
                                            font.pixelSize:  12
                                            color: "white"
                                            text: "--  "+  model.reviewer_displayname
                                            anchors{
                                                top:parent.bottom
                                                right:  parent.right
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    //////////
                    Rectangle{
                        id: reviewTwo
                        height:reviewCol.height
                        width: recRight.width
                        opacity: 0
                        Behavior on opacity {NumberAnimation{duration: 900 ; easing.type: Easing.OutSine}}
                        border.color: "#55FFFFFF"
                        border.width: 1
                        gradient: Gradient {
                            GradientStop { position: 0; color: "#42FFFFFF"}
                            GradientStop { position: 0.5; color: "#66808080"}
                            GradientStop { position: 1; color: "#42FFFFFF"}
                        }
                        anchors{
                            bottom:parent.bottom
                            left: parent.left
                        }
                        
                        ListView{
                            JSONListModel {
                                id: rev2
                                source: "https://reviews.ubuntu.com/reviews/api/1.0/reviews/filter/en/ubuntu/precise/any/"+Utils.removeExt((Utils.uriToNameApps(uri)))+"/"
                                query: "$.[[2]"
                            }
                            model: rev2.model
                            section.delegate: sectionDelegate
                            section.property: "reviewer_username"
                            section.criteria: ViewSection.FirstCharacter
                            delegate: Component {
                                Text{
                                    font.pixelSize:  parent.width / 18
                                    color: "white"
                                    text:" <b>Summary:</b> \n" +  Utils.splitInto( model.summary , 45).join('<br>')
                                    anchors{
                                        top:parent.top
                                        left:parent.left
                                    }
                                    Text{
                                        font.pixelSize:  12
                                        color: "white"
                                        text:" <b>Review:</b>" + '\n' + Utils.splitInto( model.review_text, 60).join('<br>')
                                        anchors{
                                            top:parent.bottom
                                            topMargin: parent.width / 18
                                        }
                                        Text{
                                            font.pixelSize:  12
                                            color: "white"
                                            text: "--  "+  model.reviewer_displayname
                                            anchors{
                                                top:parent.bottom
                                                right:  parent.right
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Rectangle{
                        id: reviewThree
                        height:reviewCol.height /3
                        width: recRight.width
                        opacity: 0
                        Behavior on opacity {NumberAnimation{duration: 900 ; easing.type: Easing.OutSine}}
                        border.color: "#55FFFFFF"
                        border.width: 1
                        gradient: Gradient {
                            GradientStop { position: 0; color: "#42FFFFFF"}
                            GradientStop { position: 0.5; color: "#66808080"}
                            GradientStop { position: 1; color: "#42FFFFFF"}
                            
                        }
                        anchors{
                            top: reviewTwo.bottom
                        }
                        ListView{
                            JSONListModel {
                                id: rev3
                                source: "https://reviews.ubuntu.com/reviews/api/1.0/reviews/filter/en/ubuntu/precise/any/"+Utils.removeExt((Utils.uriToNameApps(uri)))+"/"
                                query: "$.[[*]"
                            }
                            model: rev3.model
                            section.delegate: sectionDelegate
                            section.property: "reviewer_username"
                            section.criteria: ViewSection.FirstCharacter
                            delegate: Component {
                                Text{
                                    font.pixelSize:  parent.width / 18
                                    color: "white"
                                    text:"<b>Summary:</b> \n" + Utils.splitInto(model.summary,45).join('<br>')
                                    
                                    anchors{
                                        top:parent.top
                                        left:parent.left
                                    }
                                    
                                    Text{
                                        font.pixelSize:  12
                                        color: "white"
                                        text:"<b>Review:</b>" + '\n' + Utils.splitInto( model.review_text, 60).join('<br>')
                                        anchors{
                                            top:parent.bottom
                                            topMargin: parent.width / 18
                                        }
                                        Text{
                                            font.pixelSize:  12
                                            color: "white"
                                            text: "--  "+  model.reviewer_username
                                            anchors{
                                                top:parent.bottom
                                                right:  parent.right
                                                
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
