local surface_gen = require("surface-gen")
local constants = require("scripts.constants")
local starmap_icon_util = require("__subterranio-base__.utilities.starmap-icon")
local starmap_icon_position = starmap_icon_util.position_starmap_icon(data.raw.planet.fulgora, 1)

local planet = subterrain.merge(data.raw.planet.fulgora, {
    name = "fulgoran_subway",
    starting_area = 1,
    surface_properties = {
        ["day-night-cycle"] = 5 * minute,
        ["magnetic-field"] = constants.subterrain_magnetic_field,
        ["solar-power"] = 0,
        pressure = constants.subterrain_pressure,
        gravity = constants.subterrain_gravity,
    },
    starmap_icon = constants.subway_starmap_icon_path,
    starmap_icon_size = constants.subway_starmap_icon_size,
    icon = constants.subway_starmap_icon_path,
    icon_size = constants.subway_starmap_icon_size,
    magnitude = 0.75,
    order = "da[fulgoran-subway]",
    pollutant_type = "nil",
    player_effects = "nil",
    map_gen_settings = surface_gen["fulgoran_subway"](),
    distance = starmap_icon_position.starmap_icon_distance,
    draw_orbit = false,
    orientation = starmap_icon_position.starmap_icon_orientation,
    auto_save_on_first_trip = false,
    asteroid_spawn_definitions = "nil",
    lightning_properties = "nil"
})

data:extend{planet}
