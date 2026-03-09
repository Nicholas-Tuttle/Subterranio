require("subterranean-noise-expressions")
local constants = require("constants")
local surface_gen = require("surface-gen")

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
    starmap_icon = "__subterranio-vulcanus__/graphics/entity/mineshaft.png",
    starmap_icon_size = 512,
    icon = "__subterranio-vulcanus__/graphics/entity/mineshaft.png",
    icon_size = 512,
    magnitude = 0.75,
    order = "b[vulcanus]-[vulcanus_lava_tubes]",
    pollutant_type = "nil",
    player_effects = "nil",
    map_gen_settings = surface_gen["vulcanus_lava_tubes"](),
    distance = 10.0,
    draw_orbit = false,
    orientation = 0.12, -- Vulcanus is 0.1
    auto_save_on_first_trip = false,
    asteroid_spawn_definitions = "nil",
})}
