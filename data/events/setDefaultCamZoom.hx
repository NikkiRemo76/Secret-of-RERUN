function onEvent(_)
{
	if (_.event.name != 'setDefaultCamZoom') return;

	PlayState.instance.defaultCamZoom = _.event.params[0];
}