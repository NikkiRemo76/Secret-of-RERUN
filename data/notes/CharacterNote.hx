/* 
    Made by Two Ef, credits are appreciated
*/

function onNoteHit(event) {
    if(event.noteType == null) return;

    var namesList = event.noteType.split(" ");
    for (strum in strumLines) {
        for (char in strum.characters){
            for (name in namesList) {
                if (name == char.curCharacter) {
                    event.animCancelled = true;
                    char.playSingAnim(event.direction, event.animSuffix, PlayState.SING, event.forceAni);  
                }
            }
        }  
    }
}

function onPlayerMiss(event) {
    if(event.noteType == null) return;

    var namesList = event.noteType.split(" ");
    for (strum in strumLines) {
        for (char in strum.characters){
            for (name in namesList) {
                if (name == char.curCharacter) {
                    event.animCancelled = true;
                    char.playSingAnim(event.direction, event.animSuffix, PlayState.SING, event.forceAni);   
                }
            }
        }  
    }  
}