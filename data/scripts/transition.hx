function create(event) {
    event.cancel();
	//transitionTween.cancel(); // Disabling original tween

	remove(blackSpr);
	remove(transitionSprite);

	//transitionCamera.fade(0xFF000000, 0.25, newState == null, () -> {finish();}, true);

    var cam = FlxG.cameras.list[FlxG.cameras.list.length-1];
	cameras = [cam];

	shader = new CustomShader('madnessShader');
	shader.transPoint = !event.transOut ? 0 : 1;
	if (cam.filters == null) cam.filters = [];
	cam.addShader(shader);

	FlxTween.tween(shader, {transPoint: !event.transOut ? 1 : 0},0.7,{onComplete: Void->{finish();}});
}