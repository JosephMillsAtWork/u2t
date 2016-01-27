// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

XmlListModel {
    id: timethatstarts
    source: "http://192.168.1.21:6544/Guide/GetProgramGuide?StartTime=2012-10-03T19:00:00&EndTime=2014-10-03T20:00:00.xml"
    query: "/ProgramGuide/Channels"
    XmlRole { name: "starttime";query: "ChannelInfo[1]/Programs/Program[1]/StartTime/string()" }
    XmlRole{name: "endtime";query: "ChannelInfo[1]/Programs/Program[1]/EndTime/string()"}
    XmlRole{name: "Title";query: "ChannelInfo[1]/Programs/Program[1]/Title/string()"}
    XmlRole{name: "endtime";query: "ChannelInfo[1]/Programs/Program[1]/EndTime/string()"}


    onStatusChanged: {
        if (status == XmlListModel.Ready) console.log("Loaded")
        if (status == XmlListModel.Loading) console.log("Loading");
        if (status == XmlListModel.Error) console.log("Error: " + errorString);
    }
}
