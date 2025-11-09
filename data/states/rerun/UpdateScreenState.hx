import flixel.text.FlxTextFormat;
import flixel.text.FlxTextFormatMarkerPair;

var transitioning:Bool = false;

function create() {
    // не переноси строки он это чувствует
    warnText = new FlxText(0, 0, FlxG.width,"Sup bro, looks like you're running an\noutdated version of the mod #" + curModVersion + "#! \n\nPress ACCEPT to download the newest version,\nPress BACK to proceed anyway.\n\nThank you for playing our mod!");
    warnText.setFormat(null, 32, FlxColor.WHITE, 'center');
    warnText.applyMarkup(warnText.text, [
			new FlxTextFormatMarkerPair(new FlxTextFormat(0xFFFF4444), "*"),
			new FlxTextFormatMarkerPair(new FlxTextFormat(0xFFFFFF44), "#")
		]
	);
    warnText.screenCenter();
    warnText.y += 20;
    add(warnText);
}

function update() { //если не используешь elapsed, не пиши его
    if (!transitioning && controls.ACCEPT) {
        transitioning = true;
		FlxG.camera.flash(0xff0000, 1);
        CoolUtil.playMenuSFX("1");
        FlxTween.tween(warnText, {alpha: 0}, 1, {ease: FlxEase.backOut, onComplete: function(_) {
            CoolUtil.openURL("https://github.com/NikkiRemo76/Secret-of-RERUN/releases/latest");
            FlxG.switchState(new TitleState());
        }});
    }
    if (!transitioning && controls.BACK) {
        transitioning = true;
        FlxG.camera.flash(0xff0000, 1);
        CoolUtil.playMenuSFX("1");
        FlxTween.tween(warnText, {alpha: 0}, 1, {ease: FlxEase.backOut, onComplete: function(_) {
            FlxG.switchState(new TitleState());
        }});
    }
}