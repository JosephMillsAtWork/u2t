import Qt 4.7
import"../../../common/utils.js" as Utils
import "../../../common"

Item {
    id: serie

    property string name: ''
    property string overview: ''
    property string banner: ''
    property string seriesid: ''
    //    property string thumb: ''
    property int rating: -1

    function loadDetails(seriesid, name, overview, banner, thumb) {
        serie.seriesid = seriesid
        serie.name = name
        serie.overview = overview
        serie.banner = banner
        //       serie.thumb = thumb
        rating = -1

        serieModel.load(seriesid)
    }

    XmlListModel {
        id: serieModel

        function load(seriesId) {
            console.log("Loading " + seriesId)
            source = "http://thetvdb.com/api/040BCD04E3D1E109/series/" + seriesId + "/all/en.xml"
            reload();
        }

        source: ''
        query: "/Data/Series"
        XmlRole { name: "seriesid"; query: "id/string()" }
        XmlRole { name: "title"; query: "SeriesName/string()" }
        XmlRole { name: "banner"; query: "banner/string()" }
        XmlRole { name: "fanart"; query: "fanart/string()" }
        XmlRole { name: "poster"; query: "poster/string()" }
        XmlRole { name: "thumb"; query:"thumb[1]/string()"}
        XmlRole { name: "status"; query: "Status/string()" }
        XmlRole { name: "runtime"; query: "Runtime/string()" }
        XmlRole { name: "rating"; query: "Rating/string()" }
        XmlRole { name: "network"; query: "Network/string()" }
        XmlRole { name: "firstaired"; query: "FirstAired/string()" }
        XmlRole { name: "actors"; query: "Actors/string()" }
        onStatusChanged: {
            if (status == XmlListModel.Ready) {
                if (get(0) !== undefined) {
                    console.log("Serie detailes loaded");
                    var tmp = get(0).rating;
                    if (tmp !== "") rating = tmp;
                    console.log("Rating: " + rating);
                }
            } else if (status == XmlListModel.Error) {
                console.log("Error: " + errorString);
            }
        }
    }

    Image {
        id: bannerImg
        width: parent.width
        height: parent.height / 10
        source: "http://thetvdb.com/banners/" + serie.banner
        anchors{
            top: parent.top
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
    }

//    ProgresBar {
//        id: progresBar
//        visible: bannerImg.status == Image.Loading ? true : false
//        width: parent.width * 0.3; height: 10
//        anchors {bottom: parent.bottom; right: parent.right}
//        value: bannerImg.progress
//    }

    //Seasons and Cast
    Row{
        width: parent.width
        height: parent.height
        spacing: 1
        anchors{
        top: bannerImg.bottom
        }
    //Bottom Picture make into Marquee
    Rectangle {
        id: bottompictures
        visible: fan0.status === Image.Error ? false : true
        color: "#33CCCCCC"
        width: parent.width /  4; height: parent.width /  2
        Image {
            id: fan0
            source: "http://thetvdb.com/banners/posters/"+ seriesid +"-1.jpg"
            anchors.fill: bottompictures
        }
    }

    Rectangle {
        id: bottompictures1
        visible: fan1.status === Image.Error ? false : true
        width: parent.width /  4; height: parent.width /  2
        color: "#33CCCCCC"
        Image {
            id: fan1
            source: "http://thetvdb.com/banners/posters/"+ seriesid +"-2.jpg"
            anchors.fill: bottompictures1
        }
    }

    Rectangle {
        id: bottompictures2
        visible: fan2.status === Image.Error ? false : true
        color: "#33CCCCCC"
        width: parent.width /  4; height: parent.width / 2
        Image {
            id: fan2
            source: "http://thetvdb.com/banners/posters/"+ seriesid +"-3.jpg"
            anchors.fill: bottompictures2
        }
    }
    Rectangle {
        id: bottompictures3
        visible: fan3.status === Image.Error ? false : true
        color: "#33CCCCCC"
        width: parent.width / 4; height: parent.width / 2
        Image {
            id: fan3
            source: "http://thetvdb.com/banners/posters/"+ seriesid +"-4.jpg"
            anchors.fill: bottompictures3
        }
    }

}
    Rectangle {
        id: seasoncast
        visible: true
        color: "#88000000"
        width: parent.width / 3 ; height: parent.height / 1.2
        radius: 4
        border.width: 2
        border.color: "#33CCCCCC"
        anchors{
            top:parent.top
            topMargin: parent.height / 8.4
            right:parent.right
            rightMargin: 20
        }
        Flickable{
            interactive: true
            height:  seasoncast.height
            width: seasoncast.width
            contentHeight: seasoncasttxt.height
            contentWidth: seasoncasttxt.width
            Rectangle{
                id:seasoncasttxt
                visible: false
                anchors.fill:  seasoncast
                width: seasoncast.width; height: seasoncast.height - 30
                color: "#88000000"
}
                Text {
            color: "white"
            font.pixelSize: 22
            height: seasoncasttxt.height
            text: serie.overview
            wrapMode: Text.Wrap
            anchors{
                fill: seasoncasttxt
                margins: 20

            }
        }
    }
}
}
