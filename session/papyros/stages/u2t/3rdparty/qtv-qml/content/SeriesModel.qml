import Qt 4.7

XmlListModel {
	id: seriesModel

	function newSearch(text) {
		console.log("Searching: " + text);
		source = "http://thetvdb.com/api/GetSeries.php?seriesname=" + text
		reload()
	}

	source: "http://thetvdb.com/api/GetSeries.php?seriesname="
	query: "/Data/Series"

	XmlRole { name: "name"; query: "SeriesName/string()" }
	XmlRole { name: "seriesid"; query: "seriesid/string()" }
	XmlRole { name: "overview"; query: "Overview/string()" }
	XmlRole { name: "banner"; query: "banner/string()" }

	onStatusChanged: {
		if (status == XmlListModel.Ready) console.log("Loaded")
		if (status == XmlListModel.Loading) console.log("Loading");
		if (status == XmlListModel.Error) console.log("Error: " + errorString);
	}
}
