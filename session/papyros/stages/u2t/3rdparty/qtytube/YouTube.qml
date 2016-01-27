import Qt 4.7
Rectangle {
    width:460 
    height:324 
    Image {
        source:"YouTube_images/toprightbk.png"
        id:toprightbk
        x:180 ; y:0
        width:460 
        height:324 
    }
    Image {
        source:"YouTube_images/centerbk.png"
        id:centerbk
        x:179 ; y:88
        width:241 
        height:223 
    }
    Image {
        source:"YouTube_images/topleftbk.png"
        id:topleftbk
        x:0 ; y:0
        width:191 
        height:395 
    }
    Image {
        source:"YouTube_images/bottombk.png"
        id:bottombk
        x:3 ; y:307
        width:637 
        height:93 
    }
    Image {
        source:"YouTube_images/icons.png"
        id:icons
        opacity: 0.839215686275
        x:201 ; y:125
        width:205 
        height:155 
    }
    Image {
        source:"YouTube_images/selectedtxt__1.png"
        id:selectedtxt__1
        x:9 ; y:58
        width:182 
        height:44 
    }
    Image {
        source:"YouTube_images/rightbox.png"
        id:rightbox
        x:421 ; y:89
        width:219 
        height:219 
    }
    Text {
        text:'Discover Channels' 
        font.pixelSize:18 
        color:Qt.rgba(1, 1, 1, 1)
        id:discover_channels
        x:14 ; y:69
        width:177 
        height:21 
    }
    Text {
        text:'Search' 
        font.pixelSize:18 
        color:Qt.rgba(1, 1, 1, 1)
        id:search
        x:53 ; y:114
        width:88 
        height:26 
    }
    Text {
        text:'YouTube' 
        font.pixelSize:18 
        color:Qt.rgba(1, 1, 1, 1)
        id:youtube
        x:51 ; y:165
        width:98 
        height:23 
    }
    Text {
        text:'Featured' 
        font.pixelSize:18 
        color:Qt.rgba(1, 1, 1, 1)
        id:featured
        x:50 ; y:216
        width:74 
        height:21 
    }
    Text {
        text:'Settings' 
        font.pixelSize:18 
        color:Qt.rgba(1, 1, 1, 1)
        id:settings
        x:50 ; y:265
        width:92 
        height:28 
    }
}
