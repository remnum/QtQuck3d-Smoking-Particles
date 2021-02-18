import QtQml 2.15

import QtQuick
import QtQuick3D
import QtQuick3D.Helpers
import QtQuick.Particles
import QtQuick.Controls 2.0

import QtQuick.Timeline


import "comCreation.js" as MyScript

Window {
    id: mainWindow
    // visibility: Window.FullScreen
    width: 800
    height: 600
    visible: true
    color: "#000000"
    property int count:0
    property var smoking_objs : []

    View3D {
        id: view3D
        focus: true
        anchors.fill: parent
        environment: SceneEnvironment {
            clearColor: "#000000"
            backgroundMode: SceneEnvironment.Color
        }
        camera: viewCamera
        PerspectiveCamera {
            id: viewCamera
            position: Qt.vector3d( 0, 40, 300);
            // pivot: Qt.vector3d(0,0,-160)
            NumberAnimation on eulerRotation.y{
                from:0
                to :360
                duration: 10000
                running: false
                loops: 10
            }

        }

        PointLight {
            x: 400
            y: 1000
            ambientColor: "#FFFFFF"
            brightness: 500
        }

        Model{
            id:particlesSource
            source: "#Sphere"
            position: Qt.vector3d(0.0,0.0,0.0)
            scale: Qt.vector3d(0.2,0.2,0.2)
            materials: mat001
            PrincipledMaterial{
                id:mat001
                baseColor: "#FF6666"
                metalness: 0.5
                roughness: 0.0
            }
            pivot: Qt.vector3d(0,0,-300)
        }

        Model{
            id:particlesSource2
            source: "#Sphere"
            position: Qt.vector3d(0.0,0.0,0.0)
            scale: Qt.vector3d(0.2,0.2,0.2)
            materials: mat0012
            PrincipledMaterial{
                id:mat0012
                baseColor: "#FF6666"
                metalness: 0.5
                roughness: 0.0
            }
            pivot: Qt.vector3d(0,-300,0)
        }

        Model{
            id:particlesSource3
            source: "#Sphere"
            position: Qt.vector3d(0.0,0.0,0.0)
            scale: Qt.vector3d(0.2,0.2,0.2)
            materials: mat0013
            PrincipledMaterial{
                id:mat0013
                baseColor: "#FF6666"
                metalness: 0.5
                roughness: 0.0
            }
            pivot: Qt.vector3d(-300,-300,0)
        }
    }

    Timeline {
        id: timeline_root
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
            KeyframeGroup {
                target: particlesSource
                property: "eulerRotation.y"
                Keyframe { frame: 0; value: 0 }
                Keyframe { frame: 25; value: 90 }
                Keyframe { frame: 50; value: 180 }
                Keyframe { frame: 75; value: 270 }
                Keyframe { frame: 100; value: 360 }
            },
            KeyframeGroup {
                target: particlesSource2
                property: "eulerRotation.x"
                Keyframe { frame: 0; value: 0 }
                Keyframe { frame: 25; value: 90 }
                Keyframe { frame: 50; value: 180 }
                Keyframe { frame: 75; value: 270 }
                Keyframe { frame: 100; value: 360 }
            },
            KeyframeGroup {
                target: particlesSource3
                property: "eulerRotation.z"
                Keyframe { frame: 0; value: 0 }
                Keyframe { frame: 25; value: 90 }
                Keyframe { frame: 50; value: 180 }
                Keyframe { frame: 75; value: 270 }
                Keyframe { frame: 100; value: 360 }
            },
            KeyframeGroup {
                target: particlesSource3
                property: "eulerRotation.y"
                Keyframe { frame: 0; value: 0 }
                Keyframe { frame: 25; value: 90 }
                Keyframe { frame: 50; value: 180 }
                Keyframe { frame: 75; value: 270 }
                Keyframe { frame: 100; value: 360 }
            }
        ]
    }

    Button{
        width: 100
        height: 30
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        text: "start"
        onClicked: {

        }
    }

    Component.onCompleted: {
        for(var i =0 ;i < 100 ;i ++) {
        var newObject =  Qt.createQmlObject("FireAnimation{tracerObject:particlesSource;}"
                                            ,view3D.scene,"particle_"+count);
        smoking_objs.push(newObject)

        var newObject2 =  Qt.createQmlObject("FireAnimation{tracerObject:particlesSource2;}"
                                            ,view3D.scene,"particle_"+count);
        smoking_objs.push(newObject2)

        var newObject3 =  Qt.createQmlObject("FireAnimation{tracerObject:particlesSource3;}"
                                            ,view3D.scene,"particle_"+count);
        smoking_objs.push(newObject3)
        }

    }

    Timer{
        interval: slider_timer.value
        repeat: true
        running: true
        onTriggered: {
            smoking_objs[count*2].startAnime()
            smoking_objs[count*2+1].startAnime()
            count ++ ;
            if(count == 150)
                count =0;
        }
    }

    DebugView{
        source: view3D
    }

    Column{
        anchors.top: parent.top
        anchors.right: parent.right
        width: 300
        height: 30
        spacing: 10
        RectSlider {
            id:slider_timer
            width: 300
            height: 30
            name:"Timer (ms)"
        }
        RectSlider {
            id:slider_particles
            width: 300
            height: 30
            name:"Particles (num)"
        }
        Text {
            text: qsTr("Praticles Generates : " +slider_particles.value +"/"+ slider_timer.value + " ms")
            color: "#FFFFFF"
        }
    }
}
