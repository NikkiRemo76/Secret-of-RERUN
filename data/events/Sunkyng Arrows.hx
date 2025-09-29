var sunkerNotesActivated = false;
var grabbedNote:StrumNote;
var sunkyNotePos:Array<Array<Float>> = [
	[0,0],
	[0,0],
	[0,0],
	[0,0]
];
var defArrowPoses:Array<Dynamic> = [];

var strumCam = new FlxCamera();

function postCreate() {
    sunkyHandSpr = new FlxSprite(550);
	sunkyHandSpr.frames = Paths.getSparrowAtlas('mech/sunky/scramblesunky');
	sunkyHandSpr.animation.addByPrefix('sc','sc',24,false);
	sunkyHandSpr.animation.play('sc');
	sunkyHandSpr.cameras = [camHUD];
	sunkyHandSpr.setGraphicSize(815);
	sunkyHandSpr.updateHitbox();
    sunkyHandSpr.alpha = 0;
    sunkyHandSpr.flipY = Options.downscroll;
	add(sunkyHandSpr);

    for (i in strumLines.members[1])
	    defArrowPoses.push([i.x, i.y]);

    FlxG.cameras.add(strumCam, false);
    strumCam.bgColor = 0xFF000000;
    strumCam.alpha = 0;
}

function update(elapsed:Float) {
    if(sunkerNotesActivated){
		if(!FlxG.mouse.pressed && grabbedNote!=null)
			grabbedNote = null;
		
		for(idx in 1...strumLines.members[1].members.length+1){
			var i = strumLines.members[1].members[strumLines.members[1].members.length-idx];
			if(FlxG.mouse.justPressed && grabbedNote==null){
				var startMousePos = FlxG.mouse.getScreenPosition(strumCam);
				if (startMousePos.x - i.x >= 0 && startMousePos.x - i.x <= i.width && startMousePos.y - i.y >= 0 && startMousePos.y - i.y <= i.height)
				{
					grabbedNote = i;
				}
			}
			if (sunkyNotePos[i.ID][0] != 0 && sunkyNotePos[i.ID][1] != 0)
			{
				i.x = FlxMath.lerp(i.x, sunkyNotePos[i.ID][0], CoolUtil.bound(elapsed * 4, 0, 1));
				i.y = FlxMath.lerp(i.y, sunkyNotePos[i.ID][1], CoolUtil.bound(elapsed * 4, 0, 1));
			}
		}

		
		if(grabbedNote!=null){
			sunkyNotePos[grabbedNote.ID][0] += FlxG.mouse.deltaX;
			sunkyNotePos[grabbedNote.ID][1] += FlxG.mouse.deltaY;
		}
		
	}
}
function onEvent(event) {
	switch (event.event.name) {
		case 'Sunkyng Arrows':
            sunkyHandSpr.alpha = 1;
			sunkyHandSpr.animation.play('sc');
			sunkyHandSpr.animation.finishCallback=function(a:String){
				sunkyHandSpr.animation.finishCallback = null;
				sunkyHandSpr.alpha = 0.00001;
			}


			new FlxTimer().start(0.4,function(a:FlxTimer){
				sunkerNotesActivated = true;
				FlxG.mouse.enabled = true;
				FlxG.mouse.visible = true;
				for (i in strumLines.members[1])
				{
					if(i!=grabbedNote){
						sunkyNotePos[i.ID][0] = defArrowPoses[i.ID][0]+FlxG.random.int(-180, 180);
						sunkyNotePos[i.ID][1] = defArrowPoses[i.ID][1]+FlxG.random.int(-70, 100);
					}
				}
			});
	}
}