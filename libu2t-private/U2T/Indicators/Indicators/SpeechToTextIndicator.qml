import QtQuick 2.3
import QtQuick.Controls 1.4
import QtSpeechRecognition 0.5
Rectangle{
    id: ind
    width : 20
    height:  20
    color: "#3e3e3e"
    property string image

    MouseArea{
        anchors.fill: ind
        onClicked: {
            speech.dispatchMessage("Start/stop");
            switch (speech.state) {
            case SpeechRecognition.IdleState:
            case SpeechRecognition.ProcessingState:
                //speech.muted = true
                speech.startListening()
                //speech.unmuteAfter(500);
                break;
            default:
                speech.stopListening()
                break;
            }
//            mainForm.resultText = ""
        }
    }
Column{

        Label {
            id: statusField
            x: 0
            y: -20
            width: 200
            height: 17
            color: "white"
            text: ""
        }
        ProgressBar {
            id: audioLevelBar
            width: parent.width / 1.07
        }
        Text {
            id: resultField
            x: 0
            y: 28
            width: 200
            text: ""
            color: "white"
            wrapMode: Text.WordWrap
        }
    }





    /////////////////////////////////////////////
    // Speech to Text
    ////////////////////////////////////////////



    SpeechRecognition {
        id: speech
        property string resourceDir: "/home/joseph/speechres"
        property url dictionaryFile: "file:lexicon.dict"
        //    property url mainGrammarFile: "qrc:grammar/main"
        property url yesNoGrammarFile:  "file://" + resourceDir + "/yesno"
        //    property url playerGrammarFile: "qrc:/grammar/grammar/player.jsgf"

        property var engine: createEngine("local", "pocketsphinx",
                                          { "locale" : "en_US",
                                              "resourceDirectory" : resourceDir,
                                              //"debugAudioDirectory" : "/tmp",
                                              "dictionary" : dictionaryFile })
        //    property var mainGrammar: createGrammar(engine, "main", mainGrammarFile)
        property var yesNoGrammar: createGrammar(engine, "yesno", yesNoGrammarFile)
        //    property var playerGrammar: createGrammar(engine, "player", playerGrammarFile)

        Component.onCompleted: {
            console.log("\n\n\n\n\n " + yesNoGrammarFile)
        }

        onResult: {
            var lastSpokenWord =  resultData["transcription"]

            if(lastSpokenWord === "TURN THE VOLUME UP"){
                sound.master = sound.master + 1
            }

            if(lastSpokenWord === "TURN THE VOLUME DOWN"){
                sound.master = sound.master - 1
            }




            //        mainForm.resultText =  "Out Put :  " + resultData["transcription"]
            //        mainForm.statusText = "Ready"
        }
        onError: {
            var errorText = "Error " + errorCode
            if (parameters["reason"] !== undefined)  {
                errorText += ": " + parameters["reason"]
            }
            //        mainForm.resultText = ""
            statusField.text = errorText
            console.log(errorText)
        }
        onListeningStarted: {
            statusText = "Listening..."
        }
        onListeningStopped: {
            if (expectResult)
                statusText = "Hold on..."
            else
                statusText = "Ready"
        }
        onAttributeUpdated: {
            if (key == "audioLevel")
                audioLevel = value
        }
        onStateChanged: {
            console.log("State: " + speech.state)
        }
        onMessage: {
            console.log("Message: " + message)
        }
    }

    Connections {
        target: speech.engine
        onCreated: {
            console.log("Engine " + speech.engine.name + " created")
            var supportedParameters = speech.engine.supportedParameters()
            console.log("Supported engine parameters: " + supportedParameters)
            // Switch to "pulse" audio device if available
            if (supportedParameters.indexOf("audioInputDevices") !== -1) {
                var inputDevices = speech.engine.parameter("audioInputDevices")
                if (inputDevices.indexOf("pulse") !== -1)
                    speech.engine.setParameter("audioInputDevice", "pulse")
            }
            // Example: recognize audio clip instead of live audio:
            //if (supportedParameters.indexOf("audioInputFile") !== -1) {
            //    speech.engine.setParameter("audioInputFile", homeDir + "/asr_input_1.wav")
            //}
        }
    }
}
