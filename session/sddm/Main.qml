import QtQuick 2.3
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Controls 1.4

import U2T.Hardware 1.0
import U2T.Sound 1.0
import U2T.GSettings 1.0
import U2T.System 1.0

import SddmComponents 2.0
import org.kde.kcoreaddons 1.0 as KCoreAddons

// the background color and root Item
Rectangle {
    id: root
    anchors.fill: parent
    color: lightDMSettings.blackgroundColor
    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true
    // Signletons
    GSettings{ id: lightDMSettings; schema.id: "com.ihearqt.U2T.lightsddm" }
    GSettings{ id: u2tSettings; schema.id: "com.ihearqt.U2T" }
    GSettings{ id: acc; schema.id: "org.gnome.desktop.a11y.applications" }

    KCoreAddons.KUser { id: currentUser }
    HardwareEngine { id: hardware }
    Sound { id: sound }
    Component.onCompleted: {
        sound.setMaster(75);
        loginText.focus = true
    }


    Connections {
        target: sddm
        onLoginFailed: {
            tryingToLogin = false
            loginFailed = true
            loginFailedText.text = "Login Failed Try Again "
        }
    }

    property bool loginFailed: false
    property bool tryingToLogin:  false
    property int selectedUser: userModel.lastIndex
    property string theLastUser: uModel.lastUser

    property int selectedSession: sessionModel.lastIndex

    property string uToLogin
    property bool screenReader: false
    property var now: new Date()
    property string iconName: sound.muted ? "av/volume_off" : sound.master <= 33 ? "av/volume_mute": sound.master >= 67 ? "av/volume_up" : "av/volume_down"

    // The Init Screen that is used to Log in.
    Rectangle {
        id: primaryScreen
        anchors.fill: parent
        color: root.color
        visible: tryingToLogin === true ?  false : true
        Image{
            anchors.fill: parent
            source: u2tSettings.Image
            visible: lightDMSettings.useImage
        }
        Text{
            text: currentUser.os
            font.pixelSize: 32
            color: "white"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 22
            anchors.left: parent.left
            anchors.leftMargin: 22
        }
        // the top pannel
        Rectangle{
            id:topPanel
            width: parent.width
            height: 24
            color: "#3e3e3e"
            anchors.top: parent.top
            IndicatorRow{
                //height: 25 // parent.height
                anchors.right: parent.right
                //   anchors.verticalCenter: parent.verticalCenter
            }

        }


        //TheDots
        Grid{
            width: parent.width
            height: parent.height
            visible: lightDMSettings.showDots
            anchors.top: topPanel.bottom
            anchors.topMargin: 5
            columnSpacing: 48
            rowSpacing: 48
            rows: 90
            columns: 90
            Repeater{
                model: 90*90
                delegate: Rectangle{
                    color: "white"
                    width: 5
                    height: 5
                    radius: 20
                }
            }
        }
        Session{
            id: changeSession
            visible:  width === 0 ? false : true
            color: root.color
            width: 0 //loginBox.width
            height:  loginBox.height
            anchors.left: loginBox.right
            anchors.top: loginBox.top
            Behavior on width{
                SequentialAnimation{
                    NumberAnimation{duration: 1000; easing.type: Easing.OutQuart}
                    NumberAnimation {target: changeSession; property: "height"; duration: 1200; easing.type: Easing.OutQuad }

                }
            }
        }


        // the Login part
        Rectangle{
            id:loginBox
            width: parent.width / 3
            height: parent.height / 6
            color: Qt.darker(root.color ,2)
            radius:5
            border{
                color: "white"
                width: 1
            }
            anchors{
                left: parent.left
                leftMargin: 50
                verticalCenter: parent.verticalCenter
            }
            Users{
                id: setUser
                visible: false
                color: Qt.darker(root.color,2)
            }
            // sessions Models



            Row{
                id: nameAndSessionButton
                width: parent.width - 10
                height: parent.height / 2.1
                spacing: 12
                Rectangle{
                    width: parent.width - changeSessionImage.width
                    height: parent.height
                    color: "transparent"
//                    Column {
//                        anchors.fill: parent
                        Text {
                            id: userName
                            text: "Joseph" //userModel.lastUser
                            color: "white"
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.top: parent.top
                            anchors.topMargin: 10
                            font.pixelSize: 22
                        }
                        Text{
                            id: loginFailedText
                            anchors.top: userName.bottom
                            color:"red"
                        }
//                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            setUser.visible = true
                        }
                    }
                }
                Image{
                    id: changeSessionImage
                    width: height
                    height: parent.height
                    //make Util for checking name of current DE
                    source: "image://theme/start-here"

                    MouseArea{
                        anchors.fill: changeSessionImage
                        onClicked: {
                            if(changeSession.width > 0 ){
                                console.log("should shut")
                                changeSession.width = 0
                                changeSession.visible = false
                            }else if (changeSession.width === 0  ){
                                changeSession.width = loginBox.width
                                changeSession.visible = true

                            }
                        }
                    }
                }
            }



            PasswordBox {
                id: loginText
                width: parent.width; height: 30
                font.pixelSize: 14
                tooltipBG: "lightgrey"
                KeyNavigation.backtab: name; KeyNavigation.tab: session
                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        sddm.login(name.text, password.text, session.index)
                        event.accepted = true
                    }
                }

//            TextField{
//                id: loginText
//                width: parent.width - 10
//                anchors.bottom: parent.bottom
//                anchors.bottomMargin:10
//                anchors.horizontalCenter: parent.horizontalCenter
//                placeholderText: "Password"
//                echoMode: TextInput.Password
//                focus: true
//                onTextChanged: loginFailedText.text = ""
//                onAccepted: {
//                    timer.start()
//                }

//            }

        }
    }// main Item




    // after the person Logged in the checking

    Rectangle{
        id: afterThought
        anchors.fill: parent
        color: root.color
        visible: tryingToLogin === true ? true : false
        Image{
            anchors.fill: parent
            source: lightDMSettings.image
            visible: lightDMSettings.useImage
        }

        Text {
            id: label
            anchors.centerIn: parent
            text: "Signing in..."
            color: "white"
            font.pixelSize:  28
            opacity: tryingToLogin === true ? 1 : 0
            Behavior on opacity {
                NumberAnimation { }
            }
        }
    }



    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: now = new Date()
    }
    Timer {
        id: timer
        interval: 500
        onTriggered:{
            tryingToLogin = true
            sddm.login( userName.text, loginText.text, selectedSession)
        }
    }


}
}
