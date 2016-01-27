import QtQuick 1.0
//import  QtQuick 2.0
XmlListModel {
	id: serieModel
	function load(seriesId) {
		console.log("Loading " + seriesId)
		source = "http://thetvdb.com/api/040BCD04E3D1E109/series/" + seriesId + "/all/en.xml"
	}
	source: ''
	query: "/Data/Series"
	XmlRole { name: "seriesid"; query: "id/string()" }
	XmlRole { name: "title"; query: "SeriesName/string()" }
	XmlRole { name: "banner"; query: "banner/string()" }
	XmlRole { name: "fanart"; query: "fanart/string()" }
	XmlRole { name: "poster"; query: "poster/string()" }
    XmlRole { name: "thumb"; query: "thumb[1]/string()"}
	XmlRole { name: "status"; query: "Status/string()" }
	XmlRole { name: "runtime"; query: "Runtime/string()" }
	XmlRole { name: "rating"; query: "Rating/string()" }
	XmlRole { name: "network"; query: "Network/string()" }
	XmlRole { name: "firstaired"; query: "FirstAired/string()" }
}
