function onEvent(e) {
    if (e.event.name == "Change Noteskin") {
        for (a in strumLines.members[e.event.params[1]]) updateStrumSkin(a, e.event.params[0] == "" ? "game/notes/default" : "game/notes/" + e.event.params[0]);
        for (a in strumLines.members[e.event.params[1]].notes) updateNoteSkin(a, e.event.params[0] == "" ? "game/notes/default" : "game/notes/" + e.event.params[0]);
    }
}

function updateStrumSkin(theFucking:Strum, newSkin:String) {
    theFucking.frames = Paths.getSparrowAtlas(newSkin);

    theFucking.animation.addByPrefix('green', 'arrowUP');
    theFucking.animation.addByPrefix('blue', 'arrowDOWN');
    theFucking.animation.addByPrefix('purple', 'arrowLEFT');
    theFucking.animation.addByPrefix('red', 'arrowRIGHT');

    theFucking.antialiasing = Options.antialiasing;
    theFucking.setGraphicSize(Std.int(theFucking.width * 0.7));

    theFucking.animation.addByPrefix('static', 'arrow' + ["left", "down", "up", "right"][theFucking.ID].toUpperCase());
    theFucking.animation.addByPrefix('pressed', ["left", "down", "up", "right"][theFucking.ID] + ' press', 24, false);
    theFucking.animation.addByPrefix('confirm', ["left", "down", "up", "right"][theFucking.ID] + ' confirm', 24, false);

    theFucking.animation.play('static');
    theFucking.updateHitbox();

}

function updateNoteSkin(theFucker:Note, newSkin:String){
    var idk = theFucker.animation.name;
    theFucker.frames = Paths.getSparrowAtlas(newSkin);

    theFucker.animation.addByPrefix(idk, switch(idk){
        case 'scroll': ['purple', 'blue', 'green', 'red'][theFucker.strumID % 4] + '0';
        case 'hold': ['purple hold piece', 'blue hold piece', 'green hold piece', 'red hold piece'][theFucker.strumID % 4];
        case 'holdend': ['pruple end hold', 'blue hold end', 'green hold end', 'red hold end'][theFucker.strumID % 4] + '0';
    });

    theFucker.animation.play(idk);
    theFucker.updateHitbox();
}