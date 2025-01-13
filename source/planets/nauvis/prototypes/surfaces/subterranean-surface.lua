require("subterranean-noise-expressions")

local surface_gen = require("surface-gen")

data:extend {subterrain.merge(data.raw.planet.vulcanus, {
    name = "subterrain",
    starting_area = 1,
    surface_properties = {
        ["day-night-cycle"] = 5 * minute,
        ["magnetic-field"] = 25,
        ["solar-power"] = 0,
        pressure = 5000,
        gravity = 20,
    },
    starmap_icon = "__subterranio__/graphics/entity/mineshaft.png",
    starmap_icon_size = 512,
    icon = "__subterranio__/graphics/entity/mineshaft.png",
    icon_size = 512,
    order = "ce[subterrain]",
    pollutant_type = "nil",
    solar_power_in_space = 150,
    player_effects = "nil",
    map_gen_settings = surface_gen["subterrain"](),
    distance = 14.0,
    draw_orbit = false,
    orientation = 0.295 -- Nauvis is 0.275
})}