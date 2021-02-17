
var component;
var sprite;

function createSpriteObjects(parent,val) {
    for(var i = 0 ;i < val;i++){
        component = Qt.createComponent("Cube.qml");

        var incubator = component.incubateObject(parent, { position:particlesSource.scenePosition });
        incubator.destroy(1000);
    }
}

//var component = Qt.createComponent("Fire.qml");

//var incubator = component.incubateObject(parent, { x: 10, y: 10 });
//if (incubator.status != Component.Ready) {
//    incubator.onStatusChanged = function(status) {
//        if (status == Component.Ready) {
//            print ("Object", incubator.object, "is now ready!");
//        }
//    }
//} else {
//    print ("Object", incubator.object, "is ready immediately!");
//}

