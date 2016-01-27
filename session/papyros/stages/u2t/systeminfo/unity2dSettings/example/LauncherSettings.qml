/* Copyright © 2011 Nokia Corporation. All rights reserved. Nokia and Nokia
Connecting People are registered trademarks of Nokia Corporation. Oracle and
Java are registered trademarks of Oracle and/or its affiliates. Other product
and company names mentioned herein may be trademarks or trade names of their
respective owners.


Subject to the conditions below, you may, without charge:

·  Use, copy, modify and/or merge copies of this software and
   associated documentation files (the Software)

·  Publish, distribute, sub-licence and/or sell new software
   derived from or incorporating the Software.



This file, unmodified, shall be included with all copies or substantial portions
of the Software that are distributed in source code form.

The Software cannot constitute the primary value of any new software derived
from or incorporating the Software.

Any person dealing with the Software shall not misrepresent the source of the
Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
Files Modifed By Joseph Mills <josephjamesmills@gmail.com>
*/

import QtQuick 1.0
import Unity2d 1.0
import "../../../dash"
import "../../../common"
import "../component/"
FocusScope{
    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"
        Rectangle {
            id: mainBackground
            width: if (unity2dConfiguration.formFactor === "tv" )
                       parent.width / 1.38
                   else
                       parent.width / 1.35
            height: parent.height
            border.color: "#09FFFFFF"
            border.width: 2
            radius: 0
            gradient: Gradient {
                GradientStop { position: 1; color: "#02000000"}
                GradientStop { position: 0; color: "#02FFFFFF"}

            }anchors{
                left: parent.left
                leftMargin: parent.width / 3.98
            }

        }

        //    Borders for options
        Column{
            id: launcherOptionsGrid
            spacing: 5
            width: mainBackground.width
            height: parent.height - 60
            anchors{
                left: mainBackground.left
                top: mainBackground.top
                topMargin: mainBackground.height / 30

            }

            Behavior on opacity {
            NumberAnimation{
            duration: 700
            easing.type: Easing.OutQuad
            }
            }
            //DecayRate
            Rectangle {
                id: decayRec
                width: parent.width
                height: parent.height / 12
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#12000000"}
                    GradientStop { position: 0.5; color: "#44808080"}
                    GradientStop { position: 1; color: "#12000000"}

                }
                x: status === Rectangle.Ready ? 0 : 1
                Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration: 500 ;easing.type: Easing.OutQuint}}
                PictureGlowButton{
                    anchors.fill: decayHelp
                    onClicked: {
                        decayHelpBkg.scale = 1
                        decayHelpBkg.opacity = 1

                        launcherOptionsGrid.opacity = 0
                        backToMenu.visible = true
//                        console.log("this is a help touch")
                    }
                }
                Image {
                    id: decayHelp
                    source: "../component/gfx/question.png"
                    height: parent.height / 1.5
                    width: parent.height /  1.5
                    smooth: true
                    anchors{
                        rightMargin: parent.height / 15
                        right: decayTxt.left
                        verticalCenter: decayTxt.verticalCenter
                    }
                }
                Text {
                    id: decayTxt
                    font.pixelSize: parent.height / 2.66
                    color: "white"
                    //leave a space at starting to make look better with out anchors
                    text: u2d.tr(" Decay rate of mouse pressure against barrier")
                    anchors{
                        verticalCenter: decayRec.verticalCenter
                        left: decayRec.left
                        leftMargin: decayRec.width / 20

                    }

                }
                Rectangle{
                    id: decayButtonRec
                    height: decayRec.height / 2.5
                    width: decayRec.width / 4
                    radius: 0
                    border.color: "#55FFFFFF"
                    border.width: 0
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#12000000"}
                        GradientStop { position: 0.5; color: "#44808080"}
                        GradientStop { position: 1; color: "#12000000"}
                    }
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 20
                        verticalCenter: decayTxt.verticalCenter
                    }
                    TextInput{
                        id: decayButton
                        font.pixelSize: parent.width / 17
                        height: decayButtonRec.height / 1.4
                        color:"white"
                        validator: IntValidator { bottom:0; top: 6000}
                        text: (launcher2dConfiguration.edgeDecayrate)
                        onAccepted:{
                            launcher2dConfiguration.edgeDecayrate = decayButton.text

                        }
                        anchors{
                            horizontalCenter: decayButtonRec.horizontalCenter

                        }
                    }

                }
            }//DecayRate

            //BarrierEdge
            Rectangle {
                id: barrierRec
                width: parent.width
                height: parent.height / 12
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#12000000"}
                    GradientStop { position: 0.5; color: "#44808080"}
                    GradientStop { position: 1; color: "#12000000"}

                }
                x: status === Rectangle.Ready ? 0 : 1
                Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration: 700 ;easing.type: Easing.OutQuint}}
                Image {
                    id: barrierHelp
                    source: "../component/gfx/question.png"
                    height: parent.height / 1.5
                    width: parent.height /  1.5
                    smooth: true
                    anchors{
                        rightMargin: parent.height / 15
                        right: barrierTxt.left
                        verticalCenter: barrierTxt.verticalCenter

                    }
                }MouseArea{
                    anchors.fill: barrierHelp
                    onClicked: {
                        barrierHelpRateBkg.opacity = 1
                        barrierHelpRateBkg.scale = 1
                        launcherOptionsGrid.opacity = 0
                        backToMenu.visible = true
                        console.log("this is a  barrierHelpRateBkg help click")
                    }
                }
                Text {
                    id: barrierTxt
                    font.pixelSize: parent.height / 2.66
                    color: "white"
                    //leave a space at starting to make look better with out anchors
                    text: u2d.tr(" Barrier edge overcome pressure")
                    anchors{
                        verticalCenter: barrierRec.verticalCenter
                        left: barrierRec.left
                        leftMargin: barrierRec.width / 20

                    }

                }
                Rectangle{
                    id: barrierButtonRec
                    height: barrierRec.height / 2.5
                    width: barrierRec.width / 4
                    radius: 0
                    border.color: "#55FFFFFF"
                    border.width: 0
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#12000000"}
                        GradientStop { position: 0.5; color: "#44808080"}
                        GradientStop { position: 1; color: "#12000000"}
                    }
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 20
                        verticalCenter: barrierTxt.verticalCenter
                    }
                    TextInput{
                        id: barrierButton
                        height: barrierButtonRec.height / 1.4
                        color:"white"
                        font.pixelSize: parent.width / 17
                        validator: IntValidator { bottom:0; top: 6000}
                        text: (launcher2dConfiguration.edgeOvercomePressure)
                        onAccepted:{
                            launcher2dConfiguration.edgeOvercomePressure = barrierButton.text

                        }
                        anchors{
                            horizontalCenter: barrierButtonRec.horizontalCenter

                        }
                    }

                }
            }//BarrierEdge

            //LauncherResponsiveness
            Rectangle {
                id: launcherResponsivenessRec
                width: parent.width
                height: parent.height / 12
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#12000000"}
                    GradientStop { position: 0.5; color: "#44808080"}
                    GradientStop { position: 1; color: "#12000000"}

                }
                x: status === Rectangle.Ready ? 0 : 1
                Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration: 900 ;easing.type: Easing.OutQuint}}
                Image {
                    id: launcherResponsivenessHelp
                    source: "../component/gfx/question.png"
                    height: parent.height / 1.5
                    width: parent.height /  1.5
                    smooth: true
                    anchors{
                        rightMargin: parent.height / 15
                        right: launcherResponsivenessTxt.left
                        verticalCenter: launcherResponsivenessTxt.verticalCenter

                    }
                }MouseArea{
                    anchors.fill: launcherResponsivenessHelp
                    onClicked: {
                        launcherHelpResponsivenessBkg.scale = 1
                        launcherHelpResponsivenessBkg.opacity = 1

                        launcherOptionsGrid.opacity = 0
                        backToMenu.visible = true
                        console.log("this is a help touch")
                    }
                }
                Text {
                    id: launcherResponsivenessTxt
                    font.pixelSize: parent.height / 2.66
                    color: "white"
                    //leave a space at starting to make look better with out anchors
                    text: u2d.tr(" Responsiveness of the Launcher")
                    anchors{
                        verticalCenter: launcherResponsivenessRec.verticalCenter
                        left: launcherResponsivenessRec.left
                        leftMargin: launcherResponsivenessRec.width / 20

                    }

                }
                Rectangle{
                    id: launcherResponsivenessButtonRec
                    height: launcherResponsivenessRec.height / 2.5
                    width: launcherResponsivenessRec.width / 4
                    radius: 0
                    border.color: "#55FFFFFF"
                    border.width: 0
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#12000000"}
                        GradientStop { position: 0.5; color: "#44808080"}
                        GradientStop { position: 1; color: "#12000000"}
                    }
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 20
                        verticalCenter: launcherResponsivenessTxt.verticalCenter
                    }
                    TextInput{
                        id: launcherResponsivenessButton
                        height: launcherResponsivenessButtonRec.height / 1.4
                        color:"white"
                        font.pixelSize: parent.width / 17
                        text: (launcher2dConfiguration.edgeResponsiveness)
                        validator: IntValidator { bottom:0; top: 5}

                        onAccepted:{
                            launcher2dConfiguration.edgeResponsiveness = launcherResponsivenessButton.text

                        }
                        anchors{
                            horizontalCenter: launcherResponsivenessButtonRec.horizontalCenter

                        }
                    }

                }
            }//LauncherResponsiveness

            //revealEdgePressure
            Rectangle {
                id: revealEdgePressureRec
                width: parent.width
                height: parent.height / 12
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#12000000"}
                    GradientStop { position: 0.5; color: "#44808080"}
                    GradientStop { position: 1; color: "#12000000"}

                }
                x: status === Rectangle.Ready ? 0 : 1
                Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration: 900 ;easing.type: Easing.OutQuint}}
                Image {
                    id:revealEdgePressureHelp
                    source: "../component/gfx/question.png"
                    height: parent.height / 1.5
                    width: parent.height /  1.5
                    smooth: true
                    anchors{
                        rightMargin: parent.height / 15
                        right: revealEdgePressureTxt.left
                        verticalCenter: revealEdgePressureTxt.verticalCenter

                    }
                }MouseArea{
                    anchors.fill:revealEdgePressureHelp
                    onClicked: {
                        revealHelpEdgePressureBkg.scale = 1
                        revealHelpEdgePressureBkg.opacity = 1
                        launcherOptionsGrid.opacity = 0
                        backToMenu.visible = true
                        console.log("this is a help touch")
                    }
                }
                Text {
                    id: revealEdgePressureTxt
                    font.pixelSize: parent.height / 2.66
                    color: "white"
                    //leave a space at starting to make look better with out anchors
                    text: u2d.tr(" Launcher reveal edge pressure")
                    anchors{
                        verticalCenter: revealEdgePressureRec.verticalCenter
                        left: revealEdgePressureRec.left
                        leftMargin: revealEdgePressureRec.width / 20

                    }

                }
                Rectangle{
                    id: revealEdgePressureButtonRec
                    height: revealEdgePressureRec.height / 2.5
                    width: revealEdgePressureRec.width / 4
                    radius: 0
                    border.color: "#55FFFFFF"
                    border.width: 0
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#12000000"}
                        GradientStop { position: 0.5; color: "#44808080"}
                        GradientStop { position: 1; color: "#12000000"}
                    }
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 20
                        verticalCenter: revealEdgePressureTxt.verticalCenter
                    }
                    TextInput{
                        id: revealEdgePressureButton
                        height: revealEdgePressureButtonRec.height / 1.4
                        color:"white"
                        font.pixelSize: parent.width / 17
                        validator: IntValidator {bottom:0 ;top: 6000}
                        text: (launcher2dConfiguration.edgeRevealPressure)
                        onAccepted:{
                            launcher2dConfiguration.edgeRevealPressure = revealEdgePressureButton.text

                        }
                        anchors{
                            horizontalCenter: revealEdgePressureButtonRec.horizontalCenter

                        }
                    }

                }
            }//revealEdgePressure

            //edgeStopVelocity
            Rectangle {
                id: edgeStopVelocityRec
                width: parent.width
                height: parent.height / 12
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#12000000"}
                    GradientStop { position: 0.5; color: "#44808080"}
                    GradientStop { position: 1; color: "#12000000"}

                }
                x: status === Rectangle.Ready ? 0 : 1
                Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration: 1100 ;easing.type: Easing.OutQuint}}
                Image {
                    id:edgeStopVelocityHelp
                    source: "../component/gfx/question.png"
                    height: parent.height / 1.5
                    width: parent.height /  1.5
                    smooth: true
                    anchors{
                        rightMargin: parent.height / 15
                        right: edgeStopVelocityTxt.left
                        verticalCenter: edgeStopVelocityTxt.verticalCenter

                    }
                }MouseArea{
                    anchors.fill:edgeStopVelocityHelp
                    onClicked: {
                        edgeHelpStopVelocityBkg.scale = 1
                        edgeHelpStopVelocityBkg.opacity = 1

                        launcherOptionsGrid.opacity = 0
                        backToMenu.visible = true
                        console.log("this is a help touch")
                    }
                }
                Text {
                    id: edgeStopVelocityTxt
                    font.pixelSize: parent.height / 2.66
                    color: "white"
                    //leave a space at starting to make look better with out anchors
                    text: u2d.tr(" Barrier edge stop velocity")
                    anchors{
                        verticalCenter: edgeStopVelocityRec.verticalCenter
                        left: edgeStopVelocityRec.left
                        leftMargin: edgeStopVelocityRec.width / 20

                    }

                }
                Rectangle{
                    id: edgeStopVelocityButtonRec
                    height: edgeStopVelocityRec.height / 2.5
                    width: edgeStopVelocityRec.width / 4
                    radius: 0
                    border.color: "#55FFFFFF"
                    border.width: 0
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#12000000"}
                        GradientStop { position: 0.5; color: "#44808080"}
                        GradientStop { position: 1; color: "#12000000"}
                    }
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 20
                        verticalCenter: edgeStopVelocityTxt.verticalCenter
                    }
                    TextInput{
                        id: edgeStopVelocityButton
                        height: edgeStopVelocityButtonRec.height / 1.4
                        color:"white"
                        font.pixelSize: parent.width / 17
                        text: (launcher2dConfiguration.edgeStopVelocity)
                        validator: IntValidator{bottom:0;top:12000}
                        onAccepted:{
                            launcher2dConfiguration.edgeStopVelocity = edgeStopVelocityButton.text

                        }
                        anchors{
                            horizontalCenter: edgeStopVelocityButtonRec.horizontalCenter

                        }
                    }

                }
            }//edgeStopVelocity

            //hideMode
            Rectangle {
                id: hideModeRec
                width: parent.width
                height: parent.height / 12
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#12000000"}
                    GradientStop { position: 0.5; color: "#44808080"}
                    GradientStop { position: 1; color: "#12000000"}

                }
                x: status === Rectangle.Ready ? 0 : 1
                Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration: 1300 ;easing.type: Easing.OutQuint}}
                Image {
                    id:hideModeHelp
                    source: "../component/gfx/question.png"
                    height: parent.height / 1.5
                    width: parent.height /  1.5
                    smooth: true
                    anchors{
                        rightMargin: parent.height / 15
                        right: hideModeTxt.left
                        verticalCenter: hideModeTxt.verticalCenter

                    }
                }MouseArea{
                    anchors.fill:hideModeHelp
                    onClicked: {
                        hideHelpModeBkg.scale = 1
                        hideHelpModeBkg.opacity = 1

                        launcherOptionsGrid.opacity = 0
                        backToMenu.visible = true
                        console.log("this is a help touch")
                    }
                }
                Text {
                    id: hideModeTxt
                    font.pixelSize: parent.height / 2.66
                    color: "white"
                    //leave a space at starting to make look better with out anchors
                    text: u2d.tr(" Hide Mode")
                    anchors{
                        verticalCenter: hideModeRec.verticalCenter
                        left: hideModeRec.left
                        leftMargin: hideModeRec.width / 20

                    }

                }
                Rectangle{
                    id: hideModeButtonRec
                    height: hideModeRec.height / 2.5
                    width: hideModeRec.width / 4
                    radius: 0
                    border.color: "#55FFFFFF"
                    border.width: 0
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#12000000"}
                        GradientStop { position: 0.5; color: "#44808080"}
                        GradientStop { position: 1; color: "#12000000"}
                    }
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 20
                        verticalCenter: hideModeTxt.verticalCenter
                    }
                    TextInput{
                        id: hideModeButton
                        height: hideModeButtonRec.height / 1.4
                        color:"white"
                        font.pixelSize: parent.width / 17
                        text: (launcher2dConfiguration.hideMode)
                        validator: IntValidator {bottom: 0 ;top: 2 }
                        onAccepted:{
                            launcher2dConfiguration.hideMode = hideModeButton.text

                        }
                        anchors{
                            horizontalCenter: hideModeButtonRec.horizontalCenter

                        }
                    }

                }
            }//hideMode


            //launcherLocation
            Rectangle {
                id: launcherLocationRec
                width: parent.width
                height: parent.height / 12
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#12000000"}
                    GradientStop { position: 0.5; color: "#44808080"}
                    GradientStop { position: 1; color: "#12000000"}

                }
                x: status === Rectangle.Ready ? 0 : 1
                Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration: 1500 ;easing.type: Easing.OutQuint}}
                Image {
                    id:launcherLocationHelp
                    source: "../component/gfx/question.png"
                    height: parent.height / 1.5
                    width: parent.height /  1.5
                    smooth: true
                    anchors{
                        rightMargin: parent.height / 15
                        right: launcherLocationTxt.left
                        verticalCenter: launcherLocationTxt.verticalCenter

                    }
                }MouseArea{
                    anchors.fill:launcherLocationHelp
                    onClicked: {
                        launcherHelpLocationBkg.scale = 1
                        launcherHelpLocationBkg.opacity = 1

                        launcherOptionsGrid.opacity = 0
                        backToMenu.visible = true
                        console.log("this is a help touch")
                    }
                }
                Text {
                    id: launcherLocationTxt
                    font.pixelSize: parent.height / 2.66
                    color: "white"
                    //leave a space at starting to make look better with out anchors
                    text: u2d.tr(" Launcher Location")
                    anchors{
                        verticalCenter: launcherLocationRec.verticalCenter
                        left: launcherLocationRec.left
                        leftMargin: launcherLocationRec.width / 20

                    }

                }
                Rectangle{
                    id: launcherLocationButtonRec
                    height: launcherLocationRec.height / 2.5
                    width: launcherLocationRec.width / 4
                    radius: 0
                    border.color: "#55FFFFFF"
                    border.width: 0
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#12000000"}
                        GradientStop { position: 0.5; color: "#44808080"}
                        GradientStop { position: 1; color: "#12000000"}
                    }
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 20
                        verticalCenter: launcherLocationTxt.verticalCenter
                    }
                    TextInput{


                        id: launcherLocationButton
                        height: launcherLocationButtonRec.height / 1.4
                        color:"white"
                        font.pixelSize: parent.width / 17
//FIXME
                         validator: RegExpValidator {regExp: /^.*\b(left|right)\b.*$/ }
                         text: (launcher2dConfiguration.launcherLocation)

                        onAccepted:{
                            launcher2dConfiguration.launcherLocation = launcherLocationButton.text

                        }
                        anchors{
                            horizontalCenter: launcherLocationButtonRec.horizontalCenter

                        }
                    }

                }
            }//launcherLocation



            //onlyOneLauncher
            Rectangle {
                id: onlyOneLauncherRec
                width: parent.width
                height: parent.height / 12
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#12000000"}
                    GradientStop { position: 0.5; color: "#44808080"}
                    GradientStop { position: 1; color: "#12000000"}

                }
                x: status === Rectangle.Ready ? 0 : 1
                Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration: 1700 ;easing.type: Easing.OutQuint}}
                Image {
                    id:onlyOneLauncherHelp
                    source: "../component/gfx/question.png"
                    height: parent.height / 1.5
                    width: parent.height /  1.5
                    smooth: true
                    anchors{
                        rightMargin: parent.height / 15
                        right: onlyOneLauncherTxt.left
                        verticalCenter: onlyOneLauncherTxt.verticalCenter

                    }
                }MouseArea{
                    anchors.fill:onlyOneLauncherHelp
                    onClicked: {
                        onlyHelpOneLauncherBkg.scale = 1
                        onlyHelpOneLauncherBkg.opacity = 1

                        launcherOptionsGrid.opacity = 0
                        backToMenu.visible = true
                        console.log("this is a help touch")
                    }
                }
                Text {
                    id: onlyOneLauncherTxt
                    font.pixelSize: parent.height / 2.66
                    color: "white"
                    //leave a space at starting to make look better with out anchors
                    text: u2d.tr(" Only One Launcher")
                    anchors{
                        verticalCenter: onlyOneLauncherRec.verticalCenter
                        left: onlyOneLauncherRec.left
                        leftMargin: onlyOneLauncherRec.width / 20

                    }

                }
                Image{
                    id:  onlyOneLauncherIMG
                    source: "../../../artwork/tick_box.png"
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 6
                        verticalCenter: onlyOneLauncherRec.verticalCenter
                    }
                    Image{
                        id:onlyOneLauncherIMGCheck
                        visible: if (launcher2dConfiguration.onlyOneLauncher === true)
                                     true
                                 else
                                     false
                        source: "../../../artwork/tick.png"
                        scale: 1.5
                        smooth: true
                        anchors{
                            right: parent.right
                            rightMargin: parent.width / 12.5
                            verticalCenter: onlyOneLauncherIMG.verticalCenter
                        }
                    }MouseArea{
                        anchors.fill: onlyOneLauncherIMG
                        onClicked: if (launcher2dConfiguration.onlyOneLauncher === true)
                                       launcher2dConfiguration.onlyOneLauncher = false
                                   else if (launcher2dConfiguration.onlyOneLauncher === false)
                                       launcher2dConfiguration.onlyOneLauncher = true
                    }
                }
            }//onlyOneLauncher


            //revealMode
            Rectangle {
                id: revealModeRec
                width: parent.width
                height: parent.height / 12
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#12000000"}
                    GradientStop { position: 0.5; color: "#44808080"}
                    GradientStop { position: 1; color: "#12000000"}

                }
                x: status === Rectangle.Ready ? 0 : 1
                Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration: 1900 ;easing.type: Easing.OutQuint}}
                Image {
                    id:revealModeHelp
                    source: "../component/gfx/question.png"
                    height: parent.height / 1.5
                    width: parent.height /  1.5
                    smooth: true
                    anchors{
                        rightMargin: parent.height / 15
                        right: revealModeTxt.left
                        verticalCenter: revealModeTxt.verticalCenter

                    }
                }MouseArea{
                    anchors.fill:revealModeHelp
                    onClicked: {
                        revealHelpModeBkg.scale = 1
                        revealHelpModeBkg.opacity = 1

                        launcherOptionsGrid.opacity = 0
                        backToMenu.visible = true
                        console.log("this is a help touch")
                    }
                }
                Text {
                    id: revealModeTxt
                    font.pixelSize: parent.height / 2.66
                    color: "white"
                    //leave a space at starting to make look better with out anchors
                    text: u2d.tr(" Reveal mode")
                    anchors{
                        verticalCenter: revealModeRec.verticalCenter
                        left: revealModeRec.left
                        leftMargin: revealModeRec.width / 20

                    }

                }
                Rectangle{
                    id: revealModeButtonRec
                    height: revealModeRec.height / 2.5
                    width: revealModeRec.width / 4
                    radius: 0
                    border.color: "#55FFFFFF"
                    border.width: 0
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#12000000"}
                        GradientStop { position: 0.5; color: "#44808080"}
                        GradientStop { position: 1; color: "#12000000"}
                    }
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 20
                        verticalCenter: revealModeTxt.verticalCenter
                    }
                    TextInput{
                        id: revealModeButton
                        height: revealModeButtonRec.height / 1.4
                        color:"white"
                        font.pixelSize: parent.width / 17
                        text: (launcher2dConfiguration.revealMode)
                        validator: IntValidator {bottom:0;top:1}
                        onAccepted:{
                            launcher2dConfiguration.revealMode = revealModeButton.text

                        }
                        anchors{
                            horizontalCenter: revealModeButtonRec.horizontalCenter

                        }
                    }

                }
            }//revealMode



            //superKeyEnabled
            Rectangle {
                id: superKeyEnabledRec
                width: parent.width
                height: parent.height / 12
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#12000000"}
                    GradientStop { position: 0.5; color: "#44808080"}
                    GradientStop { position: 1; color: "#12000000"}

                }
                x: status === Rectangle.Ready ? 0 : 1
                Behavior on x {NumberAnimation{from: 1300; to: 0 ;duration: 2100 ;easing.type: Easing.OutQuint}}
                Image {
                    id:superKeyEnabledHelp
                    source: "../component/gfx/question.png"
                    height: parent.height / 1.5
                    width: parent.height /  1.5
                    smooth: true
                    anchors{
                        rightMargin: parent.height / 15
                        right: superKeyEnabledTxt.left
                        verticalCenter: superKeyEnabledTxt.verticalCenter

                    }
                }MouseArea{
                    anchors.fill:superKeyEnabledHelp
                    onClicked: {
                        superHelpKeyEnabled.scale = 1
                        superHelpKeyEnabled.opacity = 1

                        launcherOptionsGrid.opacity = 0
                        backToMenu.visible = true
                        console.log("this is a help touch")
                    }
                }
                Text {
                    id: superKeyEnabledTxt
                    font.pixelSize: parent.height / 2.66
                    color: "white"
                    //leave a space at starting to make look better with out anchors
                    text: u2d.tr(" Super Key Enabled")
                    anchors{
                        verticalCenter: superKeyEnabledRec.verticalCenter
                        left: superKeyEnabledRec.left
                        leftMargin: superKeyEnabledRec.width / 20

                    }

                }
                Image{
                    id:  superKeyEnabledIMG
                    source: "../../../artwork/tick_box.png"
                    anchors{
                        right: parent.right
                        rightMargin: parent.width / 6
                        verticalCenter: superKeyEnabledRec.verticalCenter
                    }
                    Image{
                        id:superKeyEnabledIMGCheck
                        visible: if (launcher2dConfiguration.superKeyEnable === true)
                                     true
                                 else
                                     false
                        source: "../../../artwork/tick.png"
                        scale: 1.5
                        smooth: true
                        anchors{
                            right: parent.right
                            rightMargin: parent.width / 12.5
                            verticalCenter: superKeyEnabledIMG.verticalCenter
                        }
                    }MouseArea{
                        anchors.fill: superKeyEnabledIMG
                        onClicked: if (launcher2dConfiguration.superKeyEnable === true)
                                       launcher2dConfiguration.superKeyEnable = false
                                   else if (launcher2dConfiguration.superKeyEnable === false)
                                       launcher2dConfiguration.superKeyEnable = true
                    }
                }

            }//superKeyEnabled

        }//launcherOptionsGrid

//        *************************
//        Back To Main Menu
//        *************************

        Image {
            visible: false
            id: backToMenu
            source: "../../../artwork/cross.png"
            anchors{
                left: parent.left
                leftMargin: parent.width / 3.98
                top: parent.top
            }
        }MouseArea{
            width: backToMenu.width
            height: backToMenu.height
        anchors.fill: backToMenu
        onClicked:{
        launcherOptionsGrid.opacity = 1
        backToMenu.visible = false

        decayHelpBkg.opacity = 0
        barrierHelpRateBkg.opacity = 0
        launcherHelpResponsivenessBkg.opacity = 0
        revealHelpEdgePressureBkg.opacity = 0
        edgeHelpStopVelocityBkg.opacity = 0
        hideHelpModeBkg.opacity = 0
        launcherHelpLocationBkg.opacity = 0
        onlyHelpOneLauncherBkg.opacity = 0
        revealHelpModeBkg.opacity = 0
        superHelpKeyEnabled.opacity = 0
        }
        }

//*******************************
//        Start Help Menus
//*******************************

        //Decay Help
        Rectangle {
            id: decayHelpBkg
            width: if (unity2dConfiguration.formFactor === "tv" )
                       parent.width / 1.38
                   else
                       parent.width / 1.35
            height: parent.height
            border.color: "#49000000"
            border.width: 20
            radius: 0
            gradient: Gradient {
                GradientStop { position: 1; color: "#99000000"}
                GradientStop { position: 0; color: "#88000000"}

            }
            anchors{
                left: parent.left
                leftMargin: parent.width / 3.98
            }
            scale: 0
            Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
            Text {
                id:decayDesription
                text: u2d.tr("The pressures against the monitor edge are continually added up, and when the sum hits a certain threshold the launcher reveals. To prevent a series of distinct gentle pushes of the pointer against the barrier from causing the launcher to reveal, we substract this parameter - the decay rate - at a steady rate")
                wrapMode: Text.WordWrap
                width: decayHelpBkg.width / 1.2
                height: decayHelpBkg.height / 1.2
                smooth: true
                font.pixelSize: parent.width / 44
                color: "white"
                anchors{
                    horizontalCenter: decayHelpBkg.horizontalCenter
                    top: decayHelpBkg.top
                    topMargin: decayHelpBkg.height /5
                }
            }Text {
                text: u2d.tr("Barrier edge overcome pressure")
                color: "white"
                font.pixelSize: parent.width / 33
                anchors{
                    bottom: decayDesription.top
                    bottomMargin: 30
                    horizontalCenter: decayDesription.horizontalCenter
                }
            }
        }//decayHelp


        //barrierHelpRate
        Rectangle {
            id: barrierHelpRateBkg
            width: if (unity2dConfiguration.formFactor === "tv" )
                       parent.width / 1.38
                   else
                       parent.width / 1.35
            height: parent.height
            border.color: "#49000000"
            border.width: 20
            radius: 0
            gradient: Gradient {
                GradientStop { position: 1; color: "#99000000"}
                GradientStop { position: 0; color: "#88000000"}

            }
            anchors{
                left: parent.left
                leftMargin: parent.width / 3.98
            }
            scale: 0
            Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
            Text {
                id:barrierHelpRateDesription
                text: u2d.tr("Minimum pressure the pointer needs to exert on the barrier for the barrier to drop.\n \n Only relevant for multi-monitor setups")
                wrapMode: Text.WordWrap
                width: barrierHelpRateBkg.width / 1.2
                height: barrierHelpRateBkg.height / 1.2
                smooth: true
                font.pixelSize: parent.width / 44
                color: "white"
                anchors{
                    horizontalCenter: barrierHelpRateBkg.horizontalCenter
                    top: barrierHelpRateBkg.top
                    topMargin: barrierHelpRateBkg.height /5
                }
            }Text {
                text: u2d.tr("Barrier edge overcome pressure")
                color: "white"
                font.pixelSize: parent.width / 33
                anchors{
                    bottom: barrierHelpRateDesription.top
                    bottomMargin: 30
                    horizontalCenter: barrierHelpRateDesription.horizontalCenter
                }
            }
        }//barrierHelpRate



        //launcherHelpResponsiveness
        Rectangle {
            id: launcherHelpResponsivenessBkg
            width: if (unity2dConfiguration.formFactor === "tv" )
                       parent.width / 1.38
                   else
                       parent.width / 1.35
            height: parent.height
            border.color: "#49000000"
            border.width: 20
            radius: 0
            gradient: Gradient {
                GradientStop { position: 1; color: "#99000000"}
                GradientStop { position: 0; color: "#88000000"}

            }
            anchors{
                left: parent.left
                leftMargin: parent.width / 3.98
            }
            scale: 0
            Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
            Text {
                id:launcherHelpResponsivenessDesription
                text: u2d.tr("How quickly the Launcher will reveal when you push the pointer against the monitor edge")
                wrapMode: Text.WordWrap
                width: launcherHelpResponsivenessBkg.width / 1.2
                height: launcherHelpResponsivenessBkg.height / 1.2
                smooth: true
                font.pixelSize: parent.width / 44
                color: "white"
                anchors{
                    horizontalCenter: launcherHelpResponsivenessBkg.horizontalCenter
                    top: launcherHelpResponsivenessBkg.top
                    topMargin: launcherHelpResponsivenessBkg.height /5
                }
            }Text {
                text: u2d.tr("Responsiveness of the Launcher")
                color: "white"
                font.pixelSize: parent.width / 33
                anchors{
                    bottom: launcherHelpResponsivenessDesription.top
                    bottomMargin: 30
                    horizontalCenter: launcherHelpResponsivenessDesription.horizontalCenter
                }
            }
        }//launcherHelpResponsiveness




        //revealHelpEdgePressure
        Rectangle {
            id: revealHelpEdgePressureBkg
            width: if (unity2dConfiguration.formFactor === "tv" )
                       parent.width / 1.38
                   else
                       parent.width / 1.35
            height: parent.height
            border.color: "#49000000"
            border.width: 20
            radius: 0
            gradient: Gradient {
                GradientStop { position: 1; color: "#99000000"}
                GradientStop { position: 0; color: "#88000000"}

            }
            anchors{
                left: parent.left
                leftMargin: parent.width / 3.98
            }
            scale: 0
            Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
            Text {
                id:revealHelpEdgePressureDesription
                text: u2d.tr("The minimum pressure to press the pointer against the monitor edge to cause the launcher to reveal")
                wrapMode: Text.WordWrap
                width: revealHelpEdgePressureBkg.width / 1.2
                height: revealHelpEdgePressureBkg.height / 1.2
                smooth: true
                font.pixelSize: parent.width / 44
                color: "white"
                anchors{
                    horizontalCenter: revealHelpEdgePressureBkg.horizontalCenter
                    top: revealHelpEdgePressureBkg.top
                    topMargin: revealHelpEdgePressureBkg.height /5
                }
            }Text {
                text: u2d.tr("Launcher reveal edge pressure")
                color: "white"
                font.pixelSize: parent.width / 33
                anchors{
                    bottom: revealHelpEdgePressureDesription.top
                    bottomMargin: 30
                    horizontalCenter: revealHelpEdgePressureDesription.horizontalCenter
                }
            }
        }//revealHelpEdgePressure


        //edgeHelpStopVelocity
        Rectangle {
            id: edgeHelpStopVelocityBkg
            width: if (unity2dConfiguration.formFactor === "tv" )
                       parent.width / 1.38
                   else
                       parent.width / 1.35
            height: parent.height
            border.color: "#49000000"
            border.width: 20
            radius: 0
            gradient: Gradient {
                GradientStop { position: 1; color: "#99000000"}
                GradientStop { position: 0; color: "#88000000"}

            }
            anchors{
                left: parent.left
                leftMargin: parent.width / 3.98
            }
            scale: 0
            Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
            Text {
                id:edgeHelpStopVelocityDesription
                text: u2d.tr("The minimum velocity the pointer needs to travel to pass through the barrier without any resistance. \n \n Only relevant for multi-monitor setups")
                wrapMode: Text.WordWrap
                width: edgeHelpStopVelocityBkg.width / 1.2
                height: edgeHelpStopVelocityBkg.height / 1.2
                smooth: true
                font.pixelSize: parent.width / 44
                color: "white"
                anchors{
                    horizontalCenter: edgeHelpStopVelocityBkg.horizontalCenter
                    top: edgeHelpStopVelocityBkg.top
                    topMargin: edgeHelpStopVelocityBkg.height /5
                }
            }Text {
                text: u2d.tr("Barrier edge stop velocity")
                color: "white"
                font.pixelSize: parent.width / 33
                anchors{
                    bottom: edgeHelpStopVelocityDesription.top
                    bottomMargin: 30
                    horizontalCenter: edgeHelpStopVelocityDesription.horizontalCenter
                }
            }
        }//edgeHelpStopVelocity


        //hideHelpMode
        Rectangle {
            id: hideHelpModeBkg
            width: if (unity2dConfiguration.formFactor === "tv" )
                       parent.width / 1.38
                   else
                       parent.width / 1.35
            height: parent.height
            border.color: "#49000000"
            border.width: 20
            radius: 0
            gradient: Gradient {
                GradientStop { position: 1; color: "#99000000"}
                GradientStop { position: 0; color: "#88000000"}

            }
            anchors{
                left: parent.left
                leftMargin: parent.width / 3.98
            }
            scale: 0
            Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
            Text {
                id:hideHelpModeDesription
                text: u2d.tr("Possible values: \n \n"
                            +"0: never hide; the launcher is always visible and windows won't overlap with it \n \n"
                            +"1: auto hide; the launcher will disappear after a short time if the user is not interacting with it \n \n"
                            +"2: intellihide; same as auto hide but the launcher will disappear if a window is placed on top of it")
                wrapMode: Text.WordWrap
                width: hideHelpModeBkg.width / 1.2
                height: hideHelpModeBkg.height / 1.2
                smooth: true
                font.pixelSize: parent.width / 44
                color: "white"
                anchors{
                    horizontalCenter: hideHelpModeBkg.horizontalCenter
                    top: hideHelpModeBkg.top
                    topMargin: hideHelpModeBkg.height /5
                }
            }Text {
                text: u2d.tr("Hide Mode")
                color: "white"
                font.pixelSize: parent.width / 33
                anchors{
                    bottom: hideHelpModeDesription.top
                    bottomMargin: 30
                    horizontalCenter: hideHelpModeDesription.horizontalCenter
                }
            }
        }//hideHelpMode


        //launcherHelpLocation
        Rectangle {
            id: launcherHelpLocationBkg
            width: if (unity2dConfiguration.formFactor === "tv" )
                       parent.width / 1.38
                   else
                       parent.width / 1.35
            height: parent.height
            border.color: "#49000000"
            border.width: 20
            radius: 0
            gradient: Gradient {
                GradientStop { position: 1; color: "#99000000"}
                GradientStop { position: 0; color: "#88000000"}

            }
            anchors{
                left: parent.left
                leftMargin: parent.width / 3.98
            }
            scale: 0
            Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
            Text {
                id:launcherHelpLocationDesription
                text: u2d.tr("Possible values: \n \n"
                             +"right: Change the location to the far right of the screen \n \n"
                             +"left: Change the to the far left of the screen\n \n"
                             +"bottom: Change the to the bottom of the screen")
                wrapMode: Text.WordWrap
                width: launcherHelpLocationBkg.width / 1.2
                height: launcherHelpLocationBkg.height / 1.2
                smooth: true
                font.pixelSize: parent.width / 44
                color: "white"
                anchors{
                    horizontalCenter: launcherHelpLocationBkg.horizontalCenter
                    top: launcherHelpLocationBkg.top
                    topMargin: launcherHelpLocationBkg.height /5
                }
            }Text {
                text: u2d.tr("Launcher Location")
                color: "white"
                font.pixelSize: parent.width / 33
                anchors{
                    bottom: launcherHelpLocationDesription.top
                    bottomMargin: 30
                    horizontalCenter: launcherHelpLocationDesription.horizontalCenter
                }
            }
        }//launcherHelpLocation



        //onlyHelpOneLauncher
        Rectangle {
            id: onlyHelpOneLauncherBkg
            width: if (unity2dConfiguration.formFactor === "tv" )
                       parent.width / 1.38
                   else
                       parent.width / 1.35
            height: parent.height
            border.color: "#49000000"
            border.width: 20
            radius: 0
            gradient: Gradient {
                GradientStop { position: 1; color: "#99000000"}
                GradientStop { position: 0; color: "#88000000"}

            }
            anchors{
                left: parent.left
                leftMargin: parent.width / 3.98
            }
            scale: 0
            Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
            Text {
                id:onlyHelpOneLauncherDesription
                text: u2d.tr("Whether in a multi-monitor setup there should be just one launcher in the primary screen or one in each.")
                wrapMode: Text.WordWrap
                width: onlyHelpOneLauncherBkg.width / 1.2
                height: onlyHelpOneLauncherBkg.height / 1.2
                smooth: true
                font.pixelSize: parent.width / 44
                color: "white"
                anchors{
                    horizontalCenter: onlyHelpOneLauncherBkg.horizontalCenter
                    top: onlyHelpOneLauncherBkg.top
                    topMargin: onlyHelpOneLauncherBkg.height /5
                }
            }Text {
                text: u2d.tr("Show Only One Launcher")
                color: "white"
                font.pixelSize: parent.width / 33
                anchors{
                    bottom: onlyHelpOneLauncherDesription.top
                    bottomMargin: 30
                    horizontalCenter: onlyHelpOneLauncherDesription.horizontalCenter
                }
            }
        }//onlyHelpOneLauncher


        //revealHelpMode
        Rectangle {
            id: revealHelpModeBkg
            width: if (unity2dConfiguration.formFactor === "tv" )
                       parent.width / 1.38
                   else
                       parent.width / 1.35
            height: parent.height
            border.color: "#49000000"
            border.width: 20
            radius: 0
            gradient: Gradient {
                GradientStop { position: 1; color: "#99000000"}
                GradientStop { position: 0; color: "#88000000"}

            }
            anchors{
                left: parent.left
                leftMargin: parent.width / 3.98
            }
            scale: 0
            Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
            Text {
                id:revealHelpModeDesription
                text: u2d.tr("Possible values: \n \n"
                            +"0: Reveal the launcher by pushing the mouse against the left side of the screen (right in RTL)  \n \n"
                            +"1: Reveal the launcher by pushing the mouse against the top-left corner of the screen (top-right in RTL)")
                wrapMode: Text.WordWrap
                width: revealHelpModeBkg.width / 1.2
                height: revealHelpModeBkg.height / 1.2
                smooth: true
                font.pixelSize: parent.width / 44
                color: "white"
                anchors{
                    horizontalCenter: revealHelpModeBkg.horizontalCenter
                    top: revealHelpModeBkg.top
                    topMargin: revealHelpModeBkg.height /5
                }
            }Text {
                text: u2d.tr("Reveal Mode")
                color: "white"
                font.pixelSize: parent.width / 33
                anchors{
                    bottom: revealHelpModeDesription.top
                    bottomMargin: 30
                    horizontalCenter: revealHelpModeDesription.horizontalCenter
                }
            }
        }//revealHelpMode


        //superHelpKeyEnabled
        Rectangle {
            id: superHelpKeyEnabled
            width: if (unity2dConfiguration.formFactor === "tv" )
                       parent.width / 1.38
                   else
                       parent.width / 1.35
            height: parent.height
            border.color: "#49000000"
            border.width: 20
            radius: 0
            gradient: Gradient {
                GradientStop { position: 1; color: "#99000000"}
                GradientStop { position: 0; color: "#88000000"}

            }
            anchors{
                left: parent.left
                leftMargin: parent.width / 3.98
            }
            scale: 0
            Behavior on scale {NumberAnimation{from: 0;to: .88; duration: 900;easing.type: Easing.OutCirc}}
            Text {
                id:superHelpKeyEnabledDesription
                text: u2d.tr("Whether or not the super (also called windows key) key is used.")
                wrapMode: Text.WordWrap
                width: superHelpKeyEnabled.width / 1.2
                height: superHelpKeyEnabled.height / 1.2
                smooth: true
                font.pixelSize: parent.width / 44
                color: "white"
                anchors{
                    horizontalCenter: superHelpKeyEnabled.horizontalCenter
                    top: superHelpKeyEnabled.top
                    topMargin: superHelpKeyEnabled.height /5
                }
            }Text {
                text: u2d.tr("Super Key Enabled")
                color: "white"
                font.pixelSize: parent.width / 33
                anchors{
                    bottom: superHelpKeyEnabledDesription.top
                    bottomMargin: 30
                    horizontalCenter: superHelpKeyEnabledDesription.horizontalCenter
                }
            }
        }//superHelpKeyEnabled


    }//BaseRectangle
}//FocusScope
