local chunk_information = require("scripts.map-gen.chunk-information")
local starting_area = require("rooms.starting-area")
local base_room_32 = require("base-room-size-thirty-two")

script.on_event(defines.events.on_surface_created, function(event)
    local surface = game.get_surface(event.surface_index)
	if not surface or not surface.valid then return end
	if surface.name ~= "fulgoran_subway" then return end
    local parent_surface = game.planets["fulgora"].create_surface()

	surface.daytime = 0.5 -- dead of night
	-- surface.daytime = 1.0 -- mid day
	surface.freeze_daytime = true
	surface.show_clouds = false
	surface.brightness_visual_weights = {r = 1, g = 1, b = 1}
	surface.min_brightness = 0
	surface.solar_power_multiplier = 0
	local map_gen_settings = surface.map_gen_settings
	map_gen_settings.seed = parent_surface.map_gen_settings.seed
	surface.map_gen_settings = map_gen_settings

	-- Setup the starting area for the underground subway
	chunk_information.set_chunk_data({ x = -1, y = -1 }, starting_area.generate_room({ x = -1, y = -1 }))
	chunk_information.set_chunk_data({ x = -1, y = 0  }, starting_area.generate_room({ x = -1, y = 0  }))
	chunk_information.set_chunk_data({ x = 0,  y = -1 }, starting_area.generate_room({ x = 0,  y = -1 }))
	chunk_information.set_chunk_data({ x = 0,  y = 0  }, starting_area.generate_room({ x = 0,  y = 0  }))

	chunk_information.set_chunk_data({ x = -2, y = -1 }, base_room_32.generate_room())
	chunk_information.set_chunk_data({ x = 1,  y = -1 }, base_room_32.generate_room())
	chunk_information.set_chunk_data({ x = -2, y = 0  }, base_room_32.generate_room())
	chunk_information.set_chunk_data({ x = 1,  y = 0  }, base_room_32.generate_room())
	chunk_information.set_chunk_data({ x = -1, y = -2 }, base_room_32.generate_room())
	chunk_information.set_chunk_data({ x = -1, y = 1  }, base_room_32.generate_room())
	chunk_information.set_chunk_data({ x = 0,  y = -2 }, base_room_32.generate_room())
	chunk_information.set_chunk_data({ x = 0,  y = 1  }, base_room_32.generate_room())
end)