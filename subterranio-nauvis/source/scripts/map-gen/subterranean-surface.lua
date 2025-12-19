local function create_subterrain(surface_index, name, seed)
    local surface = game.get_surface(surface_index)
	if not surface or not surface.valid then return end
	if surface.name ~= name then return end

	surface.daytime = 0.5 -- dead of night
	surface.freeze_daytime = true
	surface.show_clouds = false
	surface.brightness_visual_weights = {r = 1, g = 1, b = 1}
	surface.min_brightness = 0
	surface.solar_power_multiplier = 0
	local map_gen_settings = surface.map_gen_settings
	map_gen_settings.seed = seed
	surface.map_gen_settings = map_gen_settings
end

script.on_event(defines.events.on_surface_created, function(event)
	local parent_surface = game.planets["nauvis"].create_surface()
	create_subterrain(event.surface_index, "subterrain", parent_surface.map_gen_settings.seed)
	create_subterrain(event.surface_index, "subterrain_level_2", parent_surface.map_gen_settings.seed)
end)