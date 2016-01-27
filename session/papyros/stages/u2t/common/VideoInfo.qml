import QtQuick 1.0
import "../common/utils.js" as Utils

Item {
    id: info
    property string uri
    property variant video: null
    XmlListModel {
        id:nfo
        source: (dash2dConfiguration.mythipBackend)+"/Video/GetVideoByFileName?FileName="+Utils.mythFileName(uri)
        query: "/VideoMetadataInfo"
        XmlRole { name: "title"; query: "Title/string()" }
        XmlRole { name: "id"; query: "Id/string()" }
        XmlRole { name: "Tagline"; query: "Tagline/string()" }
        XmlRole { name: "Director"; query: "Director/string()";isKey: true  }
        XmlRole { name: "studio"; query: "Studio/string()" }
        XmlRole { name: "Description"; query: "Description/string()" }
        XmlRole { name: "Inetref"; query: "Inetref/string()" }
        XmlRole { name: "Collectionref"; query: "Collectionref/string()" }
        XmlRole { name: "HomePage"; query: "HomePage/string()" }
        XmlRole { name: "ReleaseDate"; query: "ReleaseDate/string()" }
        XmlRole { name: "AddDate"; query: "AddDate/string()" }
        XmlRole { name: "UserRating"; query: "UserRating/string()" }
        XmlRole { name: "Length"; query: "Length/string()" }
        XmlRole { name: "PlayCount"; query: "PlayCount/string()" }
        XmlRole { name: "Season"; query: "Season/string()" }
        XmlRole { name: "Episode"; query: "Episode/string()" }
        XmlRole { name: "ParentalLevel"; query: "ParentalLevel/string()" }
        XmlRole { name: "Visible"; query: "Visible/string()" }
        XmlRole { name: "Watched"; query: "Watched/string()" }
        XmlRole { name: "Processed"; query: "Processed/string()" }
        XmlRole { name: "ContentType"; query: "ContentType/string()" }
        XmlRole { name: "FileName"; query: "FileName/string()" }
        XmlRole { name: "Hash"; query: "Hash/string()" }
        XmlRole { name: "HostName"; query: "HostName/string()" }
        XmlRole { name: "Coverart"; query: "Coverart/string()" }
        XmlRole { name: "Fanart"; query: "Fanart/string()" }
        XmlRole { name: "Certification"; query: "Certification/string()" }
        XmlRole { name: "screenshot"; query: "Artwork/ArtworkInfos/ArtworkInfo[4]/string()"}
        onStatusChanged: if (status == XmlListModel.Ready) {
                             if (count > 0)
                                 info.video = nfo.get(0)
                         }
                         else if (status == XmlListModel.Error)
                             console.log("Error: " + errorString)

    }
}
