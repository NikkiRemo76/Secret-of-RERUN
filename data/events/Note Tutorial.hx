function postCreate() {
    tutorial = new FlxSprite(1500, 140);
	tutorial.frames = Paths.getSparrowAtlas('mech/sunky/SunkyTutorialBox');
	tutorial.cameras = [camHUD];
	tutorial.visible = false;
	tutorial.animation.addByPrefix('play','enter',24,false);
	//tutorial.animation.play('play');
	add(tutorial);
}
function update(elapsed:Float) {
    if(tutorial.frame == '(name: enter0068)'){
        tutorial.frame = '(name: enter0067)';
        FlxTween.tween(tutorial, {x: 1500}, 0.5, {ease: FlxEase.backIn, onComplete: function(twn:FlxTween)
	    {
            tutorial.animation.play('play');
	    }});
    }
}
function onEvent(event) {
	switch (event.event.name) {
		case 'Note Tutorial':
            tutorial.visible = true;
            FlxTween.tween(tutorial, {x: 800}, 0.5, {ease: FlxEase.backOut, onComplete: function(twn:FlxTween)
	        {
                tutorial.animation.play('play');
	        }});
	}
}