require("subterranean-noise-expressions")
local constants = require("scripts.constants")
local surface_gen = require("surface-gen")
local starmap_icon_util = require("__subterranio-base__.utilities.starmap-icon")
local starmap_icon_position = starmap_icon_util.position_starmap_icon(data.raw.planet.vulcanus, 1)

data:extend {subterrain.merge(data.raw.planet.vulcanus, {
    name = "vulcanus_lava_tubes",
    starting_area = 1,
    surface_properties = {
        ["day-night-cycle"] = 5 * minute,
        ["magnetic-field"] = 0,
        ["solar-power"] = 0,
        pressure = constants.subterrain_pressure,
        gravity = constants.subterrain_gravity,
    },
    starmap_icon = constants.vulcanus_lava_tubes_icon_path,
    starmap_icon_size = constants.vulcanus_lava_tubes_icon_size,
    icon = constants.vulcanus_lava_tubes_icon_path,
    icon_size = constants.vulcanus_lava_tubes_icon_size,
    magnitude = 0.75,
    order = "b[vulcanus]-[vulcanus_lava_tubes]",
    pollutant_type = "nil",
    player_effects = "nil",
    map_gen_settings = surface_gen["vulcanus_lava_tubes"](),
    distance = starmap_icon_position.starmap_icon_distance,
    draw_orbit = false,
    orientation = starmap_icon_position.starmap_icon_orientation,
    auto_save_on_first_trip = false,
    asteroid_spawn_definitions = "nil",
})}
