var boing:Bool = false;

function onEvent(e){
    if (e.event.name == "Note Bounce" || "Note_Bounce" /* mfw discord */){
        constant = e.event.params[1];
        mult = e.event.params[2];

        if (e.event.params[0] == true){
            boing = true;
        }
        if (e.event.params[0] == false){
            boing = false;
        }
    }
}

function stepHit(){
    if (boing){
        if (curStep % 4 == 0){
            boingUp();
        }
        if (curStep % 4 == 2){
            boingDown();
        }
    }
    else{
        FlxTween.tween(camHUD, {y: 0}, Conductor.stepCrochet * 0.002, {ease: FlxEase.sineOut});
    }
}

function boingUp(){
    FlxTween.tween(camHUD, {y: -constant * mult}, Conductor.stepCrochet * 0.002, {ease: FlxEase.circOut});
}

function boingDown(){
    FlxTween.tween(camHUD, {y: 0}, Conductor.stepCrochet * 0.002, {ease: FlxEase.sineIn});
}