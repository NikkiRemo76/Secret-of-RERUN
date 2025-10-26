defaultDisplayCombo = true;
public static var instLength = inst.length;
public static var instInfo = inst;
var updateInfo = true;
function postCreate() {
    
    instLength = inst.length;
    trace(instLength);
}
function onStartSong() {
    instLength = inst.length;
    trace(instLength);
}
function onGameOver() {
    //trace(inst.time);
    updateInfo = false;
}
function update(elapsed:Float) {
    if(updateInfo){
        instInfo = inst;
    }
    
}