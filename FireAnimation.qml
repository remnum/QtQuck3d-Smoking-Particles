import QtQuick
import QtQuick3D
import QtQuick.Timeline

Model{
    id:rOOT
    function startAnime(){
        anime.start()
    }
    property Node tracerObject: undefined

    property var size: Math.floor(Math.random() * 30)/200.0
    position: tracerObject.scenePosition
    source: "#Sphere"
    scale: Qt.vector3d(size,size,size)
    materials: mat001
    DefaultMaterial{
        id:mat001
        diffuseMap: Texture{
            source: "images/glowdot.png"
            rotationUV: Math.random()
            positionU:  Math.random()
            positionV:  Math.random()

        }
    }

    ParallelAnimation {
        id:anime
        running: false
        loops: 1
        NumberAnimation { target: rOOT; property: "x";from: position.x; to: position.x +Math.floor(Math.random() * 40)-20; duration: 1000 }
        NumberAnimation { target: rOOT; property: "y";from: position.y; to: position.y +Math.floor(Math.random() * 120); duration: 1000 }
        NumberAnimation { target: rOOT; property: "z";from: position.z; to: position.z+Math.floor(Math.random() * 40)-20 ; duration: 1000 }
        NumberAnimation { target: rOOT; property: "eulerRotation.x";from: 0; to:180 ; duration: 1000 }
        NumberAnimation { target: rOOT; property: "opacity";from: 0.5; to:0 ; duration: 1000
        }
        onFinished:{
            position =tracerObject.scenePosition
            start()
        }
    }
}
