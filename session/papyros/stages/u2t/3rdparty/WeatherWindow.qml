/** This file is part of Qt Media Hub**

Copyright (c) 2012 Nokia Corporation and/or its subsidiary(-ies).*
All rights reserved.

Contact:  Nokia Corporation qmh-development@qt-project.org

You may use this file under the terms of the BSD license
as follows:

Redistribution and use in source and binary forms, with or
without modification, are permitted provided that the following
conditions are met:
* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

* Neither the name of Nokia Corporation and its Subsidiary(-ies)
nor the names of its contributors may be used to endorse or promote
products derived from this software without specific prior
written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. **/

import QtQuick 1.1
import "../common/"
import "../player"
import "../sidebar"
import "../dash"
Window {
    id: root

//    focalWidget: forecastPanel

    anchors.fill: parent

    function fahrenheit2celsius(f) {
        return ((f-32)*5/9.0).toFixed(0);
    }

    function showCast(name) {
        runtime.skin.settings.weatherCity = name;
        weather.opacity=1.0;
    }
    function edgeEvent(event) {
            if (unity2dConfiguration.formFactor == "tv"
                && (event.key == Qt.Key_F3 || event.key == Qt.Key_MediaPlay)
                && declarativeView.activeLens != ""
                && !previewer.active) {
                    if (!sidebar.activeFocus) {
                        sidebar.forceActiveFocus()
                    } else {
                        sidebar.focus = false
                        dash.forceActiveFocus()
                    }
                    event.accepted = true
            }
        }
    function fullWeekDay(name) {
        var map = {
            "Mon" : qsTr("MONDAY"),
            "Tue" : qsTr("TUESDAY"),
            "Wed" : qsTr("WEDNESDAY"),
            "Thu" : qsTr("THURSDAY"),
            "Fri" : qsTr("FRIDAY"),
            "Sat" : qsTr("SATURDAY"),
            "Sun" : qsTr("SUNDAY"),
    };
        if (typeof map[name] != "undefined")
            return map[name];
        else
            return "";
    }

    function mapToFile(name) {
        if (typeof name != "undefined") {
            var map = {
                "chance_of_rain" : "Rain.qml",
                "sunny" : "Sunny.qml",
                "mostly_sunny" : "MostlySunny.qml",
                "partly_cloudy" : "PartlyCloudy.qml",
                "mostly_cloudy" : "MostlyCloudy.qml",
                "chance_of_storm" : "Storm.qml",
                "showers" : "Rain.qml",
                "rain" : "Rain.qml",
                "chance_of_snow" : "UnknownForecast.qml",
                "cloudy" : "MostlyCloudy.qml",
                "mist" : "Mist.qml",
                "storm" : "Storm.qml",
                "thunderstorm" : "Thunderstorm.qml",
                "chance_of_tstorm" : "Thunderstorm.qml",
                "sleet" : "UnknownForecast.qml",
                "snow" : "UnknownForecast.qml",
                "icy" : "UnknownForecast.qml",
                "dust" : "UnknownForecast.qml",
                "fog" : "Fog.qml",
                "smoke" : "UnknownForecast.qml",
                "haze" : "Haze.qml",
                "flurries" : "UnknownForecast.qml"
            }

            var tmp = "UnknownForecast.qml";
            var slice = name.substring(name.lastIndexOf("/")+1,name.lastIndexOf("."));

            if (map[slice])
                tmp = map[slice]

            return "weather/forecasts/"+tmp;
        }
       return "weather/forecasts/UnknownForecast.qml";
    }

    function stripLast5(string) {
        return (string.substr(0, string.length-5))
    }

    function loadForecastQml() {
        if (weatherMeasurements.count > 0) {
            forecastLoader.source = ""
            forecastLoader.source = mapToFile(weatherMeasurements.get(0).icon)
        }
    }

//fake lens slidebar
//    Sidebar{
//        id: sidebar
//        source: "common/WeatherSlidebar.qml"
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom
//        width: 550 + borderWidth
//        x: sidebarVisibility.shown ? parent.width - width : parent.width

//        Behavior on x { NumberAnimation { duration: 125 } }

//        Keys.onPressed: {
//            if (event.key == Qt.Key_Escape || event.key == Qt.Key_Backspace) {
//                event.accepted = true
//                focus = false
//                root.forceActiveFocus()

//            }
//        }
//    }
    Sidebar{
source: "common/WeatherSlidebar.qml"
    }



//    Column {
//        id: column
//        spacing: lensSidebar.spacing

//        anchors.top: parent.top
//        anchors.left: parent.left; anchors.right: parent.right
//        anchors.topMargin: spacing
//        anchors.bottomMargin: spacing

//        Item {
//            anchors.left: parent.left; anchors.right: parent.right
//            anchors.leftMargin: Units.tvPx(10)
//            height: title.paintedHeight + Units.tvPx(35)
//            TextCustom {
//                id: title
//                anchors.fill: parent
//                anchors.bottomMargin: Units.tvPx(20)
//                color: "white"
//                fontSize: "large"
//                font.weight: Font.DemiBold
//                verticalAlignment: Text.AlignBottom
//                text: "Show me"
//            }
//        }

//        ListView {
//            id: filters
//            anchors.left: parent.left; anchors.right: parent.right
//            height: childrenRect.height

//            focus: true
//            onActiveFocusChanged: {
//                // Reset the focus to the first component
//                if (!activeFocus) {
//                    currentIndex = 0
//                }
//            }

//            model: lens.filters
//            delegate: SidebarFilterLoader {
//                width: ListView.view.width
//                lens: filterPane.lens
//                filterModel: filter
//                isFirst: index == 0
//                container: lensSidebar.container
//                containerYOffset: column.y + filters.y + y
//                spacing: lensSidebar.spacing
//            }
//        }
//    }
//}

////Makle Into background Pic
//            Image {
//                id: banner
//                source: "common/artwork/HomeBlade.png"
//                anchors.bottomMargin: 10
//            }

//           WeatherListView{
//                id: listView
//                anchors { top: banner.bottom; bottom: parent.bottom; left: parent.left; right: parent.right }

////                scrollbar: false
//                focus: true
//                model: cityList

//                delegate: Item {
//                    id: delegateItem
//                    width: listView.width
//                    height: thistext.height + 8
//                    Image {
//                        anchors.fill: parent;
//                        source:  "common/artwork/" + (delegateItem.ListView.isCurrentItem ? "MenuItemFO.png" : "MenuItemNF.png");
//                    }
//                    Text {
//                        id: thistext
//                        anchors.verticalCenter: parent.verticalCenter
//                        color: "white"
//                        text: name
//                    }
//                    MouseArea {
//                        anchors.fill: parent;
//                        hoverEnabled: true
//                        onEntered:
//                            delegateItem.ListView.view.currentIndex = index
//                        onClicked:
//                            showCast(name)
//                    }
//                    Keys.onEnterPressed: {
//                        showCast(name)
//                        event.accepted = true
//                    }
//                }
//            }


//Center Pivtures
    Row {
        id: weather
        anchors.fill: parent

        Panel {
            anchors.left: parent.left
            anchors.leftMargin: -60
            width: parent.width*0.70
            height: parent.height

            Loader {
                id: forecastLoader
                anchors.fill: parent

                onLoaded: {
                    var tmp = weatherMeasurements.get(0);
                    var info = forecastInformation.get(0);
                    item.cityName = "Rochester New York"
                    forecastLoader.item.present()

                    if (typeof info != "undefined" && typeof info.current_date_time != "undefined") {
                        var date_time = info.current_date_time;
                        var slice = date_time.substring(date_time.indexOf(" ")+1,date_time.indexOf(":"));
                        item.isDay = slice > 18 || slice < 6 ? false : true;
                    } else {
                        item.isDay = true;
                    }

                    if (typeof tmp != "undefined") {
                        item.currentTemperature = typeof tmp.temp_c != "undefined" ? tmp.temp_c : "";
                        item.currentHumidity = typeof tmp.humidity != "undefined" ? tmp.humidity : "";
                        item.currentWindCondition = typeof tmp.wind_condition != "undefined" ? tmp.wind_condition : "";
                    }
                }
            }


            MouseArea {
                anchors.fill: parent
                onPressed: { forecastLoader.item.state = "" }
                onReleased: { forecastLoader.item.state = "final" }
            }
        }









        //Soon to be buttons next 5 days forcast
        Panel {
            id: forecastPanel
            width: parent.width*0.44
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 500
            Column {
                id: column1
                anchors.centerIn: parent
                width: parent.width
                height: childrenRect.height

                Text {
                    color: "#ffffff"
                    text: qsTr("Your Weather")
                    anchors.top: parent.top
                    anchors.topMargin: 35
                    anchors.left: parent.left
                    anchors.leftMargin: 40
                    smooth: true
//                    anchors.horizontalCenter: parent.horizontalCenter
                    style: Text.Raised
                    font.bold: true
                    font.pointSize: 44
                    styleColor: "#551797"
//                    font.pixelSize: 22//parent.width/11
                }

                Item {
                    width: parent.width
                    height: 50
                }

                ListView {
                    id: forecastListView
                    //Need to find out why implicitHeight
                    //does not use item.height*itemCount
                    property real contentHeightHack: 120*count
                    height: Math.min(contentHeightHack, forecastPanel.height/1.3)
                    width: parent.width
                    clip: true
                    model: weatherForecast
                    interactive: contentHeightHack > height

                    delegate: Item {
                        height: 120
                        width: forecastPanel.width

                        Rectangle {
                            id: sep
                            width: parent.width
                            height: 4
                            radius: 2
                            color: "#40FFFFFF"
                            anchors.topMargin: 5
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            id: dayofweek
                               font.pointSize: 24
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: sep.bottom; anchors.topMargin: 8
                            text: weatherForecast.count > 0 && weatherForecast.get(index)
                                  && typeof weatherForecast.get(index).day_of_week != "undefined"
                                  ? fullWeekDay(weatherForecast.get(index).day_of_week)
                                  : ""
                        }

                        Item {
                            id: forecastTextInfo
                            anchors.top: dayofweek.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: childrenRect.height; width: childrenRect.width
                            Text {
                                id: hightemptext
                                smooth: true
                                color: "red"
                                text: qsTr("High: ")
                            }
                            Text {
                                id: hightempvalue
                                anchors.left: hightemptext.right
                                font.weight: Font.Normal
                                text: weatherForecast.count > 0
                                      && weatherForecast.get(index)
                                      && typeof weatherForecast.get(index).high_f != "undefined"
                                      ? root.fahrenheit2celsius(weatherForecast.get(index).high_f) + " °C"
                                      : ""
                            }
                            Text {
                                id: lowtemptext
                                anchors.left: hightempvalue.right; anchors.leftMargin: 25
                                smooth: true
                                color: "grey"
                                text: qsTr("Low: ")
                            }
                            Text {
                                anchors.left: lowtemptext.right;
                                font.weight: Font.Normal
                                text: weatherForecast.count > 0 && weatherForecast.get(index) && typeof weatherForecast.get(index).low_f != "undefined"  ? root.fahrenheit2celsius(weatherForecast.get(index).low_f)  + " °C" : ""
                            }
                            Text {
                                id: condition
                                anchors.top: hightemptext.bottom
                                font.weight: Font.Normal
                                text: weatherForecast.count > 0 && weatherForecast.get(index) && typeof weatherForecast.get(index).condition != "undefined" ? weatherForecast.get(index).condition : ""
                            }
                        }
                    }
                }
            }
        }


        Behavior on opacity { PropertyAnimation { duration: 500 } }
    }

    XmlListModel {
        id: forecastInformation
        source: "http://www.google.com/ig/api?weather=" + "Rochester New York"
        query: "/xml_api_reply/weather/forecast_information"

        //forecast information
        XmlRole { name: "city"; query: "city/@data/string()" }
        XmlRole { name: "forecast_date"; query: "forecast_date/@data/string()" }
        XmlRole { name: "current_date_time"; query: "current_date_time/@data/string()" }
    }

    XmlListModel {
        id: weatherMeasurements
        source: "http://www.google.com/ig/api?weather=" + "Rochester New York"
        query: "/xml_api_reply/weather/current_conditions"

        onCountChanged: if (count > 0) root.loadForecastQml()

        //current condition
        XmlRole { name: "condition"; query: "condition/@data/string()" }
        XmlRole { name: "temp_c"; query: "temp_c/@data/string()" }
        XmlRole { name: "humidity"; query: "humidity/@data/string()" }
        XmlRole { name: "icon"; query: "icon/@data/string()" }
        XmlRole { name: "wind_condition"; query: "wind_condition/@data/string()" }

    }

    XmlListModel {
        id: weatherForecast
        source: "http://www.google.com/ig/api?weather=" + "Rochester New York"
        query: "/xml_api_reply/weather/forecast_conditions"

        XmlRole { name: "day_of_week"; query: "day_of_week/@data/string()" }
        XmlRole { name: "low_f"; query: "low/@data/string()" }
        XmlRole { name: "high_f"; query: "high/@data/string()" }
        XmlRole { name: "icon"; query: "icon/@data/string()" }
        XmlRole { name: "condition"; query: "condition/@data/string()" }

    }
}
