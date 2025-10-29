function onCameraMove(_){
    //trace(curCameraTarget);
}
var mainAlpha = if (strumOpasity == null) 1;

function update(elapsed:Float) {
    if (curCameraTarget == 1) {
        for (strum in strumLines.members[0].members) {
            strum.alpha = CoolUtil.fpsLerp(strum.alpha, mainAlpha - 0.4, 0.15);
        }
        for (strum in strumLines.members[1].members) {
            strum.alpha = CoolUtil.fpsLerp(strum.alpha, mainAlpha, 0.15);
        }
    } else {
        for (strum in strumLines.members[0].members) {
            strum.alpha = CoolUtil.fpsLerp(strum.alpha, mainAlpha, 0.15);
        }
        for (strum in strumLines.members[1].members) {
            strum.alpha = CoolUtil.fpsLerp(strum.alpha, mainAlpha - 0.4, 0.15);
        }
    }
}