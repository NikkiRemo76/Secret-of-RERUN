import funkin.backend.utils.HttpUtil;

var transitioning:Bool = false;
var curModVersion:String = 'Alpha 1 (Fleatway)'; //MAKE SURE TO CHANGE THIS EVERY UPDATE
var curWebVersion:String = HttpUtil.requestText('https://raw.githubusercontent.com/NikkiRemo76/Secret-of-RERUN/refs/heads/main/version.txt?token=GHSAT0AAAAAADLQXVZKJGPBBZMG6ZUNSAG62IE3E6Q');

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