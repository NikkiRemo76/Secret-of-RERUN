function postCreate() {
    CoolUtil.playMusic(Paths.music("menus/creditsTheme"), false, 0);
    FlxG.sound.music.fadeIn(2, 0, 0.7);
}