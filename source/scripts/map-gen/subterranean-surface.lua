cave.on_event(defines.events.on_surface_created, function(event)
    local surface = game.get_surface(event.surface_index)
	if not surface or not surface.valid then return end
	if surface.name ~= "cave" then return end
    local parent_surface = game.planets["nauvis"].create_surface()

	surface.daytime = 0.5 -- dead of night
	surface.freeze_daytime = true
	surface.show_clouds = false
	surface.brightness_visual_weights = {r = 1, g = 1, b = 1}
	surface.min_brightness = 0
	surface.solar_power_multiplier = 0
	local map_gen_settings = surface.map_gen_settings
	map_gen_settings.seed = parent_surface.map_gen_settings.seed
	surface.map_gen_settings = map_gen_settings
end)