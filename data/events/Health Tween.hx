var healthTweenObjThingy:FlxSprite;
var healthTweenin:Bool = false;

function postCreate() {
	healthTweenObjThingy = new FlxSprite().loadGraphic(Paths.image("icons/bf"));
	healthTweenObjThingy.x = 0;
	healthTweenObjThingy.y = 0;
	add(healthTweenObjThingy);
	healthTweenObjThingy.visible = false;
}

function postUpdate() {
	if (healthTweenin)
		health = healthTweenObjThingy.x;
}

function onEvent(event) {
	switch (event.event.name) {
		case 'Health Tween':
			healthTweenin = true;
			healthTweenObjThingy.x = health;
			var flxease:String = event.event.params[2] + (event.event.params[2] == "linear" ? "" : event.event.params[3]);
			FlxTween.tween(healthTweenObjThingy, {x: event.event.params[0]}, event.event.params[1], {ease: Reflect.field(FlxEase, flxease), onComplete: function() { healthTweenin = false; }});
	}
}