import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import U2T.Accessibility.ScreenReader 1.0
import U2T.Components 1.0

Window {
    visible: true
    width:Screen.width / 2
    height:  (speakButton.height+15) * 7 + textarea.height
    color: palette.mid
    title: "Qt Text To Speech"

    SystemPalette{id: palette}
    ListModel{id:enginesModels}
    ListModel{id: langModel}
    ListModel{id:voiceModel}


    TextToSpeech{
        id: tts
        rate: rateSlider.value
        pitch: pitchSlider.value
        text: textarea.text

        onStateChanged:{
            console.log(state)
        }
        Component.onCompleted:{
            for(var i=0;i<engines.length;i++){
                enginesModels.append({"text":engines[i]})
            }
            for(var i=0;i<languages.length;i++){
                langModel.append({"text":languages[i]})
            }
            for(var i=0;i<voices.length;i++){
                voiceModel.append({"text":voices[i]})
            }
        }
    }

    ColumnLayout{
        anchors.fill: parent
        TextArea{
            id: textarea
            Layout.preferredWidth: parent.width / 1.07
            Layout.alignment: Qt.AlignHCenter
            text:
"Hello Qt Text To Speech,
this is an example text in English.

Qt Speech is a library that makes text to speech easy with Qt.
Done!
over and out."
        }

        TTSHelper{
            Layout.minimumWidth:  parent.width/ 1.07
            height: volumeSlider.height
            text:"Volume"
            view: Slider{
                id: volumeSlider
                width: parent.width
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                minimumValue: 0
                maximumValue: 100
                value: 50
                stepSize: 10

            }
        }

        TTSHelper{
            Layout.minimumWidth:  parent.width/ 1.07
            height: volumeSlider.height
            text:"Rate"
            view: Slider{
                id: rateSlider
                width: parent.width
                Layout.alignment: Qt.AlignRight
                anchors.verticalCenter: parent.verticalCenter
                minimumValue: -10
                maximumValue: 10
                value: 0
                stepSize: 1
            }
        }


        TTSHelper{
            Layout.minimumWidth:  parent.width/ 1.07
            height: volumeSlider.height
            text:"Pitch"
            view: Slider{
                id: pitchSlider
                width: parent.width
                Layout.alignment: Qt.AlignRight
                anchors.verticalCenter: parent.verticalCenter
                minimumValue: -10
                maximumValue: 10
                value: 0
                stepSize: 1
            }
        }


        TTSHelper{
            Layout.minimumWidth:  parent.width/ 1.07
            height: volumeSlider.height
            text:"Engines"
            ComboBox{
                id: engineView
                width:  parent.width
                anchors.verticalCenter: parent.verticalCenter
                model: enginesModels
            }
        }
        TTSHelper{
            Layout.minimumWidth:  parent.width/ 1.07
            height: volumeSlider.height
            text:"Languages"
            ComboBox{
                id: langView
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                model:langModel
            }
        }

        TTSHelper{
            Layout.minimumWidth:  parent.width/ 1.07
            height: volumeSlider.height
            text:"Voices"
            ComboBox{
                id: voiceView
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                model: voiceModel
            }
        }



        RowLayout{
            width: parent.width
            height: speakButton.height
            Layout.alignment: Qt.AlignHCenter
            Button{
                id: speakButton
                text: qsTr("Speak")
                Layout.preferredWidth: parent.width / 4.2
                onClicked: tts.speak()

            }
            Button{
                text: qsTr("Pause")
                Layout.preferredWidth: parent.width / 4.1
                onClicked: tts.pause()
            }
            Button{
                Layout.preferredWidth: parent.width / 4.1
                text: qsTr("Resume")
                onClicked: tts.resume()
            }
            Button{
                Layout.preferredWidth: parent.width / 4.1
                text: qsTr("Stop")
                onClicked: tts.stop()
            }

        }

    }
}

