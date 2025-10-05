// Camera Fade event created by Moro-Maniac. 
// You are free to use this in your own mods! No credit or mentioning of me is needed.

// Script Version: 1.0

function onEvent(e) {
    if (e.event.name == "Camera Fade") {
        var params:Array = e.event.params;
        // var easeType:String = "FlxEase.sineInOut";
        // easeType = "FlxEase." + params[3];
        switch (params[0]) {
            case "camGame":
                FlxTween.tween(camGame, {alpha: params[2]}, params[1]);
            case "camHUD":
                // trace(params, easeType, params[3]);
                FlxTween.tween(camHUD, {alpha: params[2]}, params[1]);
        }
    }
}