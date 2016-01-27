import QtQuick 1.1
import Unity2d 1.0
import "../../../../../dash"
import "../../../../../common"
import "../../../../../systeminfo"

FocusScope{

    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"

        Text{
            id: stickyEdgeName
            height: 28
            color: "white"
            font.pixelSize: stickyEdge.height / 12
            text: u2d.tr("Use Sticky Edge's")
            anchors{
                horizontalCenter: stickyEdge.horizontalCenter
                top:stickyEdge.top
            }
        }
        Rectangle {
            id: stickyEdge
            width: parent.width / 2.33
            height: parent.height / 2.22
            radius: 0
            opacity: status === Rectangle.Ready ? .88 : 0.0
            Behavior on opacity {
                NumberAnimation {
                    property: "opacity";
                    from: 0.0
                    to: .88
                    duration: 1100;
                    easing.type: Easing.InOutQuad
                }
            }
            border.color: "#34FFFFFF"
            border.width: 1
            smooth: true
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#10FFFFFF"; }
                GradientStop { position: 1.0; color: "#20dd4814"; }
                GradientStop { position: 1.0; color: "#25000000"; }

            }
            Text{
                id:stickyEdgeDescription
                text: u2d.tr("Change whether the edges in a multi-monitor setup should be sticky or not \(Edges with autohide launchers are always sticky\).")
                font.pixelSize: parent.height / 19
                color: "white"
                width: stickyEdge.width - 12
                height: stickyEdge.height
                wrapMode: Text.WordWrap
                anchors{
                    top:stickyEdge.top
                    topMargin: stickyEdge.height / 10
                    left:stickyEdge.left
                    leftMargin: 8
                }
            }
        }
        Row{
            height: parent.height / 2.33
            width: parent.width / 2.66
            spacing: parent.width / 12.66
            anchors{
                bottom: parent.bottom
                bottomMargin: stickyEdgeDescription.height / 1.11
                left:parent.left
                leftMargin: stickyEdgeDescription.width / 8.33
            }
            Rectangle {
                id: stickyEdgeYESRec

                width: parent.width / 2.99 //.33
                height: parent.height / 2.33
                radius: 0
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#29FFFFFF"}
                    GradientStop { position: 0.5; color: "#10000000"}
                    GradientStop{position: 1; color: "#22FFFFFF"}
                } MouseArea {
                    id: stickyEdgeYESMouse
                    anchors.fill: stickyEdgeYESRec
                    onClicked: unity2dConfiguration.stickyEdges = "true"
                }
                Text{
                    text:u2d.tr("Yes")
                    color: "white"
                    opacity: if((unity2dConfiguration.stickyEdges) === true)
                                 1
                             else
                                 .28
                    anchors{
                        verticalCenter: stickyEdgeYESMouse.verticalCenter
                        horizontalCenter: stickyEdgeYESMouse.horizontalCenter
                    }
                }//Text
            } //Rectangle

            Rectangle {
                id: stickyEdgeNORec
                width: parent.width / 2.99
                height: parent.height / 2.33
                radius: 0
                border.color: "#55FFFFFF"
                border.width: 1
                gradient: Gradient {
                    GradientStop { position: 0; color: "#29FFFFFF"}
                    GradientStop { position: 0.5; color: "#10000000"}
                    GradientStop{position: 1; color: "#22FFFFFF"}
                }
                MouseArea{
                    id: stickyEdgeNoMouse
                    anchors.fill: stickyEdgeNORec
                    onClicked: unity2dConfiguration.stickyEdges = "false"
                }
                Text {
                    id: fsdfg
                    text: u2d.tr("No")
                    color: "white"
                    opacity: if ((unity2dConfiguration.stickyEdges) ===  false)
                                 1
                             else
                                 .28
                    anchors{
                        horizontalCenter: stickyEdgeNoMouse.horizontalCenter
                        verticalCenter: stickyEdgeNoMouse.verticalCenter
                    }
                }
            } //Rectangle
        }//Row
    }//rootangle
}//scope

