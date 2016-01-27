import QtQuick 2.0

Rectangle {
    width: iconImg.width * 4
    height: iconImg.height
    color: "transparent"
    radius: 5
    border{
        color: "white"
        width: 1
    }

    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked:{
            if(mouse.button === Qt.RightButton){
//                console.log("right Button")

                previewsShown(exec ,mimeType ,genericName ,comments ,icon)


            }else if(mouse.button ===  Qt.LeftButton){
                // check for arguments
                var te = tryExec
                var e = exec
                var t = e.toString()
                if (te.length > 0){
                    console.log(te.length )

                }else{
                if(e.indexOf(' ') >= 0 ){
                    console.log(" There is a Argument " + e.length)
                    //FIXME check for spaces first
                    var ar = e.substring(e.indexOf(" ")+1)
                    var app = e.substring(0,e.indexOf(" "))

                    var arrm = ar.replace("%U","")
                    var rmSpace = arrm.replace(" ",",")

                    var arg = rmSpace.split(",")

                    appRunner.workingDirectory = homePath;

                    if (arg[0] === "%U"){
                        console.log("Fuck")
                    }


                    appRunner.program = ""
                    appRunner.program = app
                    appRunner.arguments = arg
                    console.log(app + " ARGS " + arg   )


                }else {
                    console.log("There is no arguments with this applications "+ e)
                    // only app name
                    appRunner.program = ""
                    appRunner.program = exec
                }

                appRunner.start()
            }
        }
    }
}
    Image {
        id: iconImg
        source: "image://theme/" + icon
        width: 48
        height: 48
        onStatusChanged:{
            if(status === Image.Error)
                source = "image://theme/unknown"
        }
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 1
        }
        fillMode: Image.PreserveAspectFit
        asynchronous: true
        Behavior on opacity {NumberAnimation {duration: 200; easing.type: Easing.InOutQuad}}
    }

    Item {
        id: labels
        anchors{
            top: iconImg.top
            bottom: iconImg.bottom
            left: iconImg.right
            leftMargin: 3
            right: parent.right
        }

        Text {
            id: firstLine
            text: name
            color:"white"
            elide: Text.ElideMiddle
            font.pixelSize: 18 // "small"
            anchors{
                left: parent.left
                right: parent.right
                top: parent.top
            }
            height: paintedHeight
        }

        Text {
            id: secondLine
            text: comment
            color: "white" //button.state == "pressed" ? "#888888" : "#cccccc"
            font.pixelSize: 12
            height: parent.height - firstLine.paintedHeight
            anchors{
                left: parent.left
                right: parent.right
                top: firstLine.bottom
            }
            clip: true
            wrapMode: Text.Wrap
            verticalAlignment: Text.AlignTop
        }
    }
}
