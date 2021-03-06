import QtQuick
import QtQuick3D
import QtQuick.Timeline

Node{
    Repeater3D{
        id:repeater
        model: 100
        delegate: Model{
            id:rOOT
            property var size: Math.floor(Math.random() * 30)/200.0
            position: particlesSource.scenePosition
            source: "#Sphere"
            scale: Qt.vector3d(size,size,size)
            materials: mat0012
            DefaultMaterial{
                id:mat0012
                diffuseMap: Texture{
                    source: "images/glowdot.png"
                    rotationUV: Math.random()
                    positionU:  Math.random()
                    positionV:  Math.random()

                }
            }
            property var key_obj : KeyframeGroup {
              target: repeater.children[index]
              property: "position.y"
              Keyframe { frame: 0; value: particlesSource.scenePosition.y  }
//              Keyframe { frame: 20; value: Math.floor(Math.random() * 5) }
//              Keyframe { frame: 40; value: Math.floor(Math.random() * 10) }
//              Keyframe { frame: 60; value: Math.floor(Math.random() * 30) }
//              Keyframe { frame: 80; value: Math.floor(Math.random() * 60) }
              Keyframe { frame: 100; value: particlesSource.scenePosition.y + Math.floor(Math.random() * 100) }
            }
            property var key_obj2 : KeyframeGroup {
              target: repeater.children[index]
              property: "position.x"
              Keyframe { frame: 0; value: particlesSource.scenePosition.x }
              Keyframe { frame: 100; value: particlesSource.scenePosition.x+Math.floor(Math.random() * 40)-20 }
            }
            property var key_obj3 : KeyframeGroup {
              target: repeater.children[index]
              property: "position.z"
              Keyframe { frame: 0; value: particlesSource.scenePosition.z }
              Keyframe { frame: 100; value: particlesSource.scenePosition.z+Math.floor(Math.random() * 40)-20 }
            }
            property var key_obj4 : KeyframeGroup {
              target: repeater.children[index]
              property: "opacity"
              Keyframe { frame: 0; value: 0.5 }
              Keyframe { frame: 100; value: 0 }
            }

            property var key_obj5 : KeyframeGroup {
              target: repeater.children[index]
              property: "eulerRotation.x"
              Keyframe { frame: 0; value: 0 }
              Keyframe { frame: 100; value: 100 }
            }
        }

    }

    Timeline {
        id: timeline0
        startFrame: 0
        endFrame: 100
        currentFrame: 0
        enabled: true

        animations: [
            TimelineAnimation {
                pingPong: false
                duration: 5000
                from: 0
                to: 100
                running: true
                loops: Animation.Infinite
            }
        ]
        keyframeGroups: [

        ]

    }
    Component.onCompleted: {
        for(var i =0 ; i<repeater.children.length;i++){
            timeline0.keyframeGroups.push(repeater.children[i].key_obj)
            timeline0.keyframeGroups.push(repeater.children[i].key_obj2)
            timeline0.keyframeGroups.push(repeater.children[i].key_obj3)
            timeline0.keyframeGroups.push(repeater.children[i].key_obj4)
            timeline0.keyframeGroups.push(repeater.children[i].key_obj5)
        }
    }
}
