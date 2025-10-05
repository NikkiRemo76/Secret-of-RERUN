import openfl.geom.ColorTransform;

function onEvent(e) {
    if (e.event.name == "changeCamZoom"){
        if (e.event.params[0] == true) {
            FlxG.camera.zoom = e.event.params[1];
            defaultCamZoom = e.event.params[1];
        }
        if (e.event.params[0] == false) {
            defaultCamZoom = e.event.params[1];
        }
    }
}