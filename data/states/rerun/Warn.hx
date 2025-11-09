var transitioning:Bool = false;

function create() {
    warn = new FlxSprite().loadGraphic(Paths.image('menus/warning'));
	warn.setGraphicSize(1280);
	warn.updateHitbox();
    warn.screenCenter();
	add(warn);
}

function update(elapsed:Float) {
    if (!transitioning && controls.ACCEPT) {
        transitioning = true;
		FlxG.camera.flash(0xff0000, 1);
		CoolUtil.playMenuSFX("1");
        FlxTween.tween(warn, {alpha: 0}, 1, {ease: FlxEase.backOut});

        if (curModVersion != curWebVersion) {
            new FlxTimer().start(1.2, (_) -> FlxG.switchState(new ModState("rerun/UpdateScreenState")));
        } else {
            new FlxTimer().start(1.2, (_) -> FlxG.switchState(new TitleState()));
        }
	}
}