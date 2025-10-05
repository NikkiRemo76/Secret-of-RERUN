function onEvent(daEvent) {
    if (daEvent.event.name == "Shake Camera") {
        var cam:String = daEvent.event.params[0];
        var time = daEvent.event.params[1];
        var intencity = daEvent.event.params[2];
        switch (cam){
            case "camHUD":
                camHUD.shake(intencity, time, null, true, null);
            case "camGame":
                camGame.shake(intencity, time, null, true, null);
        }

    }
}