import funkin.menus.BetaWarningState;
import funkin.menus.TitleState;
import funkin.menus.MainMenuState;
import funkin.menus.StoryMenuState;
import funkin.menus.FreeplayState;
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.WindowUtils;
import lime.graphics.Image;
import openfl.text.TextFormat;
import funkin.backend.system.framerate.FramerateCounter;
import funkin.backend.MusicBeatTransition;
import funkin.backend.system.framerate.Framerate;
import openfl.text.TextFormat;
import funkin.backend.utils.NativeAPI;
import funkin.backend.scripting.MultiThreadedScript;
import funkin.backend.scripting.GlobalScript;

static var windowTitle:String = "";

static var curMainMenuSelected:Int = 0;
static var curStoryMenuSelected:Int = 0;
static var isInPlayState:Bool = false;
static var curOptionMenuSelected:Int = 0;
static var optionsSelectedSomethin:Bool = false;

static var redirectStates:Map<FlxState, String> = [
    //BetaWarningState => "rom/warn",
    //TitleState => "exe/ManiaTitleState",
    //MainMenuState => "exe/ManiaMainMenu",
    //StoryMenuState => "rom/TitleState",
    //FreeplayState => "rom/TitleState",
    //OptionsMenu => "",
    //CreditsMain => ""
];

function preStateSwitch()
{
    for(i in redirectStates.keys()){
        if(Std.isOfType(FlxG.game._requestedState, i)){
            FlxG.game._requestedState = new ModState(redirectStates.get(i));
        }
    }

	Main.framerateSprite.codenameBuildField.text = "Secret of RERUN.";

    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('2char'))));
	window.title = windowTitle;
}

function readSubFolder(folder) {
	var globalScripts = Paths.getFolderContent(folder).filter((i:String) -> return StringTools.endsWith(i, '.hx'));
	for (script in globalScripts) {
		var daScript = new MultiThreadedScript(Paths.script(folder + '/' + script));
		daScript.call('create');
		GlobalScript.scripts.add(daScript.script);
		daScript.call('postCreate');
	}
	for (daFolder in Paths.getFolderDirectories(folder+"/", true)) {
		readSubFolder(daFolder);
	}
}

function new() {
	var globalScripts = Paths.getFolderContent('data/scripts/global').filter((i:String) -> return StringTools.endsWith(i, '.hx'));
	for (script in globalScripts) {
		var daScript = new MultiThreadedScript(Paths.script('data/scripts/global/' + script));
		daScript.call('create');
		GlobalScript.scripts.add(daScript.script);
		daScript.call('postCreate');
	}
	for (folder in Paths.getFolderDirectories('data/scripts/global/', true)) {
		readSubFolder(folder);
	}
}
function postStateSwitch(){
	Framerate.fpsCounter.fpsNum.defaultTextFormat = new TextFormat(Paths.getFontName(Paths.font('NiseSegaSonic.TTF')), 18); //default font is consolas, default size is 18
    Framerate.fpsCounter.fpsLabel.defaultTextFormat = new TextFormat(Paths.getFontName(Paths.font('NiseSegaSonic.TTF')), 12); //default font is consolas, default size is 12
	NativeAPI.setDarkMode(null, true);
}