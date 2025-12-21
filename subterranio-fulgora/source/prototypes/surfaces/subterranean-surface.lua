local surface_gen = require("surface-gen")

local planet = subterrain.merge(data.raw.planet.fulgora, {
    name = "fulgoran_subway",
    starting_area = 1,
    surface_properties = {
        ["day-night-cycle"] = 5 * minute,
        ["magnetic-field"] = 99,
        ["solar-power"] = 0,
        pressure = 1,
        gravity = 1,
    },
    starmap_icon = "__subterranio-nauvis__/graphics/entity/mineshaft.png",
    starmap_icon_size = 512,
    icon = "__subterranio-nauvis__/graphics/entity/mineshaft.png",
    icon_size = 512,
    magnitude = 0.75,
    order = "a[fulgora]-[fulgoran_subway]",
    pollutant_type = "nil",
    player_effects = "nil",
    map_gen_settings = surface_gen["fulgoran_subway"](),
    distance = 25.0,
    draw_orbit = false,
    orientation = 0.340, -- Nauvis is 0.325
    auto_save_on_first_trip = false,
    asteroid_spawn_definitions = "nil",
    lightning_properties = "nil"
})

data:extend{planet}
