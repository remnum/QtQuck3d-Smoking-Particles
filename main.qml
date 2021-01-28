import QtQuick
import QtQuick3D
import QtQuick3D.Helpers
import QtQuick.Particles
import QtQuick.Controls 2.0

Window {
    id: mainWindow
    visibility: Window.FullScreen
    width: 800
    height: 600
    visible: true
    color: "#000000"
    property int count:0

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
            pivot: Qt.vector3d(0,0,-500)
            NumberAnimation on eulerRotation.y{
                from:0
                to :360
                duration: 5000
                running: true
                loops: Animation.Infinite
            }
        }
    }
    Timer{
        interval: slider_timer.value
        repeat: true
        running: true
        onTriggered: {
            count++
            if(count > 10000)
                count =1;
            for(var i = 0 ;i < slider_particles.value;i++){
                var newObject = Qt.createQmlObject("Fire{position:particlesSource.scenePosition;}",view3D.scene,"particle_"+count);
                newObject.destroy(Math.floor(Math.random() * 1000)+2000);
            }
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
