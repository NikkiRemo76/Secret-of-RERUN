import flixel.tweens.FlxTween.FlxTweenType;
introSprites = ['game/introCounts/sunk/3', 'game/introCounts/sunk/2', 'game/introCounts/sunk/1', 'game/introCounts/sunk/go'];
function onPlayerHit(event:NoteHitEvent) {
    event.ratingPrefix = "game/score/sunk/";
}
function onCountdown(e){

    e.antialiasing = false;
    e.scale = 1;

}
function onPostCountdown(e) {
	var spr = e.sprite;
	if (spr != null) spr.camera = camHUD;

    FlxTween.tween(spr.scale, {x: 3, y: 3}, 0.4, {ease: FlxEase.backOut, onComplete: function(twn:FlxTween)
	{
		spr.destroy();
		remove(spr, true);
	}});

	// prevents tweening the y  - Nex
	var props = e.spriteTween?._propertyInfos;
	if (props != null) for (info in props)
		if (info.field == "y") e.spriteTween._propertyInfos.remove(info);
}