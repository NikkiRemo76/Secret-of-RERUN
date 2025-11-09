
var nowLives = hudLives;
trace(nowLives);

var songName = PlayState.SONG.meta.displayName;

var transTime:FlxTimer;

function postCreate(){
    for (i in [healthBarBG, scoreTxt, iconP1]) remove(i);
    doIconBop = false;

    //rerunBarBG = new FlxSprite(24, 571.5).loadGraphic(Paths.image('game/ui/newHealthBars/'+songName+'/hpframe'));
    //rerunBarBG.camera = camHUD;
    //rerunBarBG.y -= 75/2;

    healthBarNew = new FlxSprite(160,FlxG.height * 0.72);
	healthBarNew.frames = Paths.getSparrowAtlas('game/ui/newHealthBars/'+songName+'/bar');
    for (bi in 0...hudLives + 1){
        healthBarNew.animation.addByPrefix('health'+bi+'Trans','health'+bi+'Trans',30, false);
        healthBarNew.animation.addByPrefix('health'+bi,'health'+bi,30, false);
    }
    healthBarNew.animation.play('health0');
	healthBarNew.camera = camHUD;
    healthBarNew.scale.set(0.8,0.8);
    add(healthBarNew);

    healthBarMain = new FlxSprite(healthBarNew.x - 285,healthBarNew.y - 200);
	healthBarMain.frames = Paths.getSparrowAtlas('game/ui/newHealthBars/'+songName+'/main');
    healthBarMain.animation.addByPrefix('Normal','Normal',24, true);
    healthBarMain.animation.addByPrefix('CrackTransition','CrackTransition',24, false);
    healthBarMain.animation.addByPrefix('Cracked','Cracked',24, true);
    healthBarMain.animation.addByPrefix('Explode','Explode',24, false);
    healthBarMain.animation.addByPrefix('Shattered','Shattered',24, true);
    healthBarMain.animation.play('Normal');
	healthBarMain.camera = camHUD;
    healthBarMain.scale.set(0.8,0.8);
    add(healthBarMain);
    add(healthBarMain);

    healthBarNew.antialiasing = true;
    healthBarMain.antialiasing = true;

    for (o in [missesTxt, accuracyTxt]) {
        o.angle -= 20;
        o.x = healthBarNew.x + 20;

        if (downscroll) o.y -= 95;
        else o.y -= 70;
    }
    
    healthBar.visible = false;
}

var preStart = true;

function onSongStart(){
    preStart = false;
    healthBarNew.animation.play('health'+nowLives+'Trans');
    healthBarNew.animation.finishCallback = function(name:String) {
        if (healthBarNew.animation.name == 'health'+nowLives+'Trans') {
            healthBarNew.animation.play('health'+nowLives);
        }
    }
}

function update(elapsed:Float) {
    if(preStart){
        healthBarNew.animation.play('health0');
    }
    healthBarMain.alpha = healthBarBG.alpha;
    healthBarNew.alpha = healthBarBG.alpha;
    if(nowLives >= 2){
        health = 1;
    }else if(nowLives <= 3 && nowLives >= 1){
        health = 2;
    }else {
        health = 0;
    }
    //trace(healthBar.percent / 100);
}
var firstLust = nowLives - 1;
function onPlayerMiss(event:NoteMissEvent) {
    if (misses % 10 == 0 && misses != 0)
    {
        nowLives --;
        healthBarNew.animation.play('health'+nowLives+'Trans');
        healthBarNew.animation.finishCallback = function(name:String) {
            if (healthBarNew.animation.name == 'health'+nowLives+'Trans') {
                healthBarNew.animation.play('health'+nowLives);
            }
        }
        switch(nowLives){
            case firstLust:
                healthBarMain.animation.play('CrackTransition');
                healthBarMain.animation.finishCallback = function(name:String) {
                    if (healthBarMain.animation.name == 'CrackTransition') {
                        healthBarMain.animation.play('Cracked');
                    }
                }
            case 1:
                healthBarMain.animation.play('Explode');
                healthBarMain.animation.finishCallback = function(name:String) {
                    if (healthBarMain.animation.name == 'Explode') {
                        healthBarMain.animation.play('Shattered');
                    }
                }
        }
    }
}

function postUpdate(){
    iconP2.scale.set(CoolUtil.fpsLerp(iconP2.scale.x, 0.8, 0.33), CoolUtil.fpsLerp(iconP2.scale.y ,0.8, 0.33));
    iconP2.setPosition(healthBarMain.x + 210, healthBarMain.y + 190);

    //if(nowLives <= 2){
    //    iconP2.health = 1;
    //}
}

function onDadHit() iconP2.scale.set(0.9, 0.9);

function beatHit() iconP2.scale.set(1, 1);