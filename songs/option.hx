defaultDisplayCombo = true;
public static var instLength = inst.length;
public static var instInfo = inst;
public static var hudLives:Int = 5;
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