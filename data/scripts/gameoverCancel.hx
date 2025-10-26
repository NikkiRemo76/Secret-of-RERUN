import funkin.game.Strum;

var colorShaderGameover = new CustomShader('adjustColor');
colorShaderGameover.brightness = 0;
colorShaderGameover.hue = 0;
colorShaderGameover.contrast = 0;
colorShaderGameover.saturation = 0;

var bluring = new CustomShader('blur');
bluring.directions = 16.0;
bluring.quality = 3.0;
bluring.size = 0.0;

var played = false;

function onGameOver(e){
    e.cancel();
    if (!played){
        canPause = false;
        camGame.addShader(colorShaderGameover);
        camHUD.addShader(colorShaderGameover);
            if (PlayState.character != null)
              PlayState.character.stunned = true;
            persistentUpdate = false;
            persistentDraw = false;
            paused = true;
            //vocals.stop();
            //if (FlxG.sound.music != null)
            //    FlxG.sound.music.stop();

            FlxTween.tween(vocals, {pitch: 0},2.5, {ease: FlxEase.expoOut});
            FlxTween.tween(FlxG.sound.music, {pitch: 0},2.5, {ease: FlxEase.expoOut});

            new FlxTimer().start(1, (_) -> [
                FlxG.sound.play(Paths.sound('gameover/iner'), 1)
            ]);

            FlxTween.tween(colorShaderGameover, {saturation: -100, brightness: -100}, 2, {ease: FlxEase.expoIn});

            strumLines.members[0].notes.forEach(function(n){
                //FlxTween.tween(n, {y: 600}, 10, {ease: FlxEase.expoIn});
                new FlxTimer().start(3, (_) -> [
                    n.updateNotesPosX = false,
                    n.updateNotesPosY = false,
                    n.copyStrumAngle = false,
                    FlxTween.tween(n, {y: 800}, 1.5, {ease: FlxEase.expoIn}),
                    //n.angle += FlxG.random.float(800, 1000),
                ]);
            });   
            strumLines.members[1].notes.forEach(function(n){
                //FlxTween.tween(n, {y: 600}, 10, {ease: FlxEase.expoIn});
                new FlxTimer().start(3, (_) -> [
                    n.updateNotesPosX = false,
                    n.updateNotesPosY = false,
                    //n.copyStrumAngle = false,
                    FlxTween.tween(n, {y: 800}, 1.5, {ease: FlxEase.expoIn}),
                    //n.angle += FlxG.random.float(800, 1000),
                ]);
            }); 
            new FlxTimer().start(3, (_) -> [
                camGame.addShader(bluring),
                camHUD.addShader(bluring),
                FlxTween.tween(bluring, {size: 16}, 2, {ease: FlxEase.expoOut}),
                openSubState(new ModSubState('substates/GameOverCustomSubstate'))
            ]);
            cancelTweens();   

            played = true;
    }
}

function cancelTweens(){
    //strumLines.members[0].notes.copyStrumScrollX = false;
    //strumLines.members[0].notes.copyStrumScrollY = false;
    strumLines.members[0].notes.forEach(function(n){
        n.avoid = true;
    });
}

function update(elapsed:Float) {
    //strumLines.members[0].notes.forEach(function(n){
    //    //n.angle += 50;
    //});
}