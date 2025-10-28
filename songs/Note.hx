//Credits:
// - Jesse Barnes, Microkat
// - Vechett
// - NexIsDumb (clearly not)

function getCharNotes(c:Character) {
    return (c.xml.exists("noteSkin") && Assets.exists(Paths.image("game/notes/" + c.xml.get("noteSkin")))) ?
    "game/notes/" + c.xml.get("noteSkin") :
    "game/notes/default";
}

function getCharSplashes(c:Character) {
    return (c.xml.exists("splashSkin") && Assets.exists(Paths.image("game/splashes/" + c.xml.get("splashSkin")))) ?
    "game/splashes/" + c.xml.get("splashSkin") :
    "game/splashes/default";
}

function onNoteCreation(e){
    switch (e.strumLineID) {
        case 0:
            e.noteSprite = getCharNotes(dad);
        case 1:
            e.noteSprite = getCharNotes(boyfriend);
        case 2:
            e.noteSprite = getCharNotes(gf);
    }
}

function onStrumCreation(e:StrumCreationEvent) {
    switch (e.player) {
        case 0:
            e.sprite = getCharNotes(dad);
        case 1:
            e.sprite = getCharNotes(boyfriend);
        case 2:
            e.sprite = getCharNotes(gf);
    }
}

function onNoteHit(e:NoteHitEvent) {
    switch (e.character) {
        case 0:
            e.note.splash = getCharSplashes(dad);
        case 1:
            e.note.splash = getCharSplashes(boyfriend);
        case 2:
            e.note.splash = getCharSplashes(gf);
    }
}