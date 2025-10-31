//var accel_x = 0;
//var accel_x2 = 0;
//var bounce = 0;
//var bf_flip = 1;
//var pos_x = 800;
import flixel.math.FlxRandom;
var rnd:FlxRandom = new FlxRandom();
var angleDad = 1;
var shirinaDad = 1;
var bfPos = 770;

var visotaBf = 1;
function update(elapsed:Float) {
    //trace(strumLines.members[0].characters[0].getAnimName());
    //dad.width = FlxMath.lerp(dad.width, shirinaDad, (1/30)*240*elapsed);
    dad.angle = FlxMath.lerp(dad.angle, angleDad, (1/30)*240*elapsed);
    boyfriend.x = FlxMath.lerp(boyfriend.x, bfPos, (1/30)*240*elapsed);
    boyfriend.scale.x = FlxMath.lerp(boyfriend.scale.x, visotaBf, (1/30)*240*elapsed);
    dad.scale.x = FlxMath.lerp(dad.scale.x, shirinaDad, (1/30)*240*elapsed);
    for(s in strumLines) {
		for(i in 0...4) {
			var n = s.members[i];
			n.angle = Math.sin(curBeatFloat + (i * 15)) * 5;
		}
	}
    switch(strumLines.members[0].characters[0].getAnimName()){
        case "singLEFT" | "singLEFT-alt":
            angleDad -= rnd.float(1, 20);
        case "singRIGHT" | "singRIGHT-alt":
            angleDad += rnd.float(1, 20);
        case "singDOWN" | "singDOWN-alt":
            shirinaDad += rnd.float(0.0001, 0.005);
        case "singUP" | "singUP-alt":
            shirinaDad -= rnd.float(0.0001, 0.005);
        case "idle" | "idle-loop":
            angleDad = 1;
            shirinaDad = 1;
    }
    switch(strumLines.members[1].characters[0].getAnimName()){
        case "singLEFT" | "singLEFT-alt":
            bfPos -= rnd.float(1, 5);
            boyfriend.flipX = false;
        case "singRIGHT" | "singRIGHT-alt":
            bfPos += rnd.float(1, 5);
            boyfriend.flipX = true;
        case "singDOWN" | "singDOWN-alt":
            visotaBf += rnd.float(0.0001, 0.0005);
        case "singUP" | "singUP-alt":
            visotaBf -= rnd.float(0.0001, 0.0005);
        case "idle" | "idle-loop":
            boyfriend.flipX = false;
            bfPos = 770;
            //shirinaDad = 0;
            visotaBf = 1;
    }

    //trace(dad.width);
}
/*
accel_x = 0
accel_x2 = 0
bounce = 0
bf_flip = 1
pos_x = 800
 
function onUpdate()
	if keyPressed("left") then
		bounce = (1 - math.abs(accel_x)/5)
		bf_flip = 1
	elseif keyPressed("up") then
		bounce = bounce*0.8 + 0.25
	elseif keyPressed("down") then
		bounce = bounce*0.7 + 0.25
	elseif keyPressed("right") then
		bounce = (1 - math.abs(accel_x)/5)
		bf_flip = -1
	else
		accel_x2 = accel_x2 + (1 - bounce)/5
		bounce = (bounce*0.8 + 0.2) + accel_x2
	end
 
	if keyPressed("left") then
		accel_x = accel_x*0.75 - 1*0.25
	elseif keyPressed("right") then
		accel_x = accel_x*0.75 + 1*0.25
	else
		accel_x = (accel_x)*0.8
	end
 
	pos_x = pos_x + accel_x*6
	setProperty('boyfriend.x', pos_x - 1/bounce * 150)
        setProperty('boyfriend.y', 100 + 1/bounce * 350)
	scaleObject('boyfriend', bf_flip/bounce, bounce)
end
*/