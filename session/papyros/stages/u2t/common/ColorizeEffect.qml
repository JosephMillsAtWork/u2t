import QtQuick 1.0
import Qt.labs.shaders 1.0

ShaderEffectItem {
    property bool enabled: true
    property bool hideSource: true
    property real ratio: 1.0
    property color color: "gray"
    property variant source
    property alias sourceItem: shaderSource.sourceItem

    anchors.fill: sourceItem

    opacity: enabled ? sourceItem.opacity : 0

    source: ShaderEffectSource {
        id: shaderSource
        hideSource: parent.enabled ? parent.hideSource : false
    }

    fragmentShader:
        "
        uniform highp vec4 color;
        varying highp vec2 qt_TexCoord0;
        uniform sampler2D source;
        uniform highp float ratio;
        void main(void)
        {
            lowp vec4 textureColor = texture2D(source, qt_TexCoord0.st) * ratio;
            gl_FragColor = mix(vec4(0), color, textureColor.a);
        }
        "
}
