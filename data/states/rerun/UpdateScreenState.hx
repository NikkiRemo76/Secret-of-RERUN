
function create() {
    warnText = new FlxText(0, 0, FlxG.width,
        "Sup bro, looks like you're running an\noutdated version of the mod,\n
        Press ACCEPT to download the newest version,\nPress BACK to proceed anyway.\n
        \n
        Thank you for playing our mod!",
        32);
    warnText.setFormat(null, 32, FlxColor.WHITE, 'center');
    warnText.screenCenter();
    warnText.y += 80;
    add(warnText);
}

function update(elapsed:Float) {
    
    if (controls.ACCEPT || controls.BACK) {
        transitioning = true;
		FlxG.camera.flash(0xff0000, 1);
		CoolUtil.playMenuSFX("1");
        if(controls.ACCEPT){
            FlxG.openURL("https://github.com/NikkiRemo76/Secret-of-RERUN/releases", "_blank");
        }
        FlxTween.tween(warnText, {alpha: 0}, 1, {ease: FlxEase.backOut});
		new FlxTimer().start(1.2, (_) -> FlxG.switchState(new TitleState()));
	}
}