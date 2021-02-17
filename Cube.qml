import QtQuick
import QtQuick3D

Node {
    Repeater3D{
        id:repeater
        model: 100
        delegate: Model{
            id:rOOT
            source: "#Cube"
            position: Qt.vector3d(0.0,15.0*index,0.0)
            scale: Qt.vector3d(0.1,0.1,0.1)
            materials: mat001
            PrincipledMaterial{
                id:mat001
                baseColor: "#0000FF"
            }
            RotationAnimation {
                id:anime
                property: "position.x"
                from :0
                to: 100
                running: true
                loops: Animation.Infinite
                duration: 1500
            }
        }
    }


//    Component.onCompleted: {
//        console.log(repeater.children.length)
//        anime.start()
//    }
}
