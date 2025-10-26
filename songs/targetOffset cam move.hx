/*
this is a (kinda) port of the script by SenTCM, credits to him

(this looks nothing like their code)

made by silly borja please credit if used
*/

// how far the camera should go (affects angle asw)
public var tilt_offset:Float = 10.0;

// angle offset multiplier
public var tilt_angleIntensity:Float = 0.05;

// multiply the current camera follow lerp used in the cam movement (if you do not want it to be slow as shit)
public var tilt_followMult:Float = 10.0;

// should camHUD's angle be affected by this?
public var tilt_isHUDlerped:Bool = false;

function update(){
    switch (strumLines.members[curCameraTarget].characters[0].animation.curAnim.name){
        case "singLEFT", "singLEFT-alt": doCameraStuffEhehehe([-tilt_offset, 0]);
        case "singDOWN", "singDOWN-alt": doCameraStuffEhehehe([0, tilt_offset]);
        case "singUP", "singUP-alt": doCameraStuffEhehehe([0, -tilt_offset]);
        case "singRIGHT", "singRIGHT-alt": doCameraStuffEhehehe([tilt_offset, 0]);
        default: doCameraStuffEhehehe([0, 0]);
    }
}

function doCameraStuffEhehehe(offsets:Array<Float>){
    camGame.targetOffset.x = FlxMath.lerp(camGame.targetOffset.x, offsets[0], camGame.followLerp * tilt_followMult);
    camGame.targetOffset.y = FlxMath.lerp(camGame.targetOffset.y, offsets[1], camGame.followLerp * tilt_followMult);

    camGame.angle = FlxMath.lerp(camGame.angle, offsets[0] * tilt_angleIntensity, camGame.followLerp * tilt_followMult / 2);
    if (tilt_isHUDlerped) camHUD.angle = FlxMath.lerp(camHUD.angle, offsets[0] * tilt_angleIntensity, camGame.followLerp * tilt_followMult / 2);
}