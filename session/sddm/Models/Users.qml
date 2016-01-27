import QtQuick 2.0
// used to Change Users
Rectangle{
    id:changeUsers
    width: parent.width / 2
    height: parent.height / 2
    radius: 1
    border{
        width: 1
        color: "white"
    }

   // anchors.left: loginBox.left
   // anchors.top: loginBox.top
    ListView {
        anchors.centerIn: parent
        spacing: 2
        anchors.fill: parent
        model: userModel
        delegate:
            Rectangle{
            width: changeUsers.width - 5
            height: 20
            radius: 5
            color: changeUsers.color
            border{
                color: "white"
                width: 1
            }
            Image {
                id: usersIcon
                source: icon
                height: parent.height
                width: height
                anchors.left: parent.left
                anchors.leftMargin: 2
            }
            Text {
                id: userToLoginIn
                text: realName || name
                color: "white"
                font.pixelSize: parent.height- 2
                //font.bold: currentUser.fullName === text ?  true : false
                anchors.left: usersIcon.right
                anchors.leftMargin:  4
            }
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    uToLogin = index
                    selectedUser = name
                    changeUsers.visible = false
                }
            }
        }
    }
}
