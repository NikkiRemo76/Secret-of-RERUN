import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.WindowUtils;
import lime.graphics.Image;
import openfl.text.TextFormat;
import funkin.backend.system.framerate.FramerateCounter;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.NativeAPI;
import funkin.backend.utils.HttpUtil;

static var windowTitle:String = "";
static var windowIcon:String = '2char';
static var curModVersion:String = 'Alpha 1 (Fleetway) Hotfix'; //MAKE SURE TO CHANGE THIS EVERY UPDATE
static var curWebVersion:String = HttpUtil.requestText('https://gist.githubusercontent.com/raw/ad0b6d0915dbd8260f8506348b9c3030/version.txt');

function preStateSwitch() {
	Main.framerateSprite.codenameBuildField.text = "Secret of RERUN.";
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image(windowIcon))));
	window.title = windowTitle;
}

function postStateSwitch(){
	Framerate.fpsCounter.fpsNum.defaultTextFormat = new TextFormat(Paths.getFontName(Paths.font('NiseSegaSonic.TTF')), 18); //default font is consolas, default size is 18
    Framerate.fpsCounter.fpsLabel.defaultTextFormat = new TextFormat(Paths.getFontName(Paths.font('NiseSegaSonic.TTF')), 12); //default font is consolas, default size is 12
	NativeAPI.setDarkMode(null, true);
}