function onCameraMove(_){
    //trace(curCameraTarget);
}
function update(elapsed:Float) {
    if (curCameraTarget == 1) {
        for (strum in strumLines.members[0].members) {
            strum.alpha = CoolUtil.fpsLerp(strum.alpha, strumOpasity - 0.4, 0.15);
        }
        for (strum in strumLines.members[1].members) {
            strum.alpha = CoolUtil.fpsLerp(strum.alpha, strumOpasity, 0.15);
        }
    } else {
        for (strum in strumLines.members[0].members) {
            strum.alpha = CoolUtil.fpsLerp(strum.alpha, strumOpasity, 0.15);
        }
        for (strum in strumLines.members[1].members) {
            strum.alpha = CoolUtil.fpsLerp(strum.alpha, strumOpasity - 0.4, 0.15);
        }
    }
}