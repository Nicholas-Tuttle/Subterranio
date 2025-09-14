local item = {
    type = "item",
    name = "planetary-repair-device",
    icon = subterrain.planetary_repair_device_image_path,
    icon_size = subterrain.planetary_repair_device_image_size,
    subgroup = "subterranio",
    order = "b",
    default_import_location = "nauvis",
    stack_size = 1,
    weight = 1000*kg
}

local recipe = {
    type = "recipe",
    name = "planetary-repair-device",
    enabled = true,
    energy_requirements = 115200, -- 32 * 60 * 60
    localized_description = { "item-description.planetary-repair-device" },
    ingredients = {
        {type = "item", name = "low-density-structure", amount = 60000},
        {type = "item", name = "steel-plate", amount = 60000},
        {type = "item", name = "tungsten-plate", amount = 60000},
        -- {type = "item", name = "supermagnet", amount = 50000},
        {type = "item", name = "diamond-shard", amount = 50000},
        {type = "item", name = "quantum-processor", amount = 50000},
        {type = "item", name = "supercapacitor", amount = 50000},
        {type = "item", name = "fusion-power-cell", amount = 10000},
        {type = "item", name = "overgrowth-yumako-soil", amount = 10000},
        {type = "item", name = "overgrowth-jellynut-soil", amount = 10000}
    },
    results = {{type = "item", name = "planetary-repair-device", amount = 1}}
}

data:extend{item, recipe}

-- For testing in creative mode, to destroy all asteroids on the way to the shattered planet:
-- local surface = game.player.surface
-- game.print(surface)
-- local asteroids = surface.find_entities_filtered{type="asteroid"}
-- game.print(#asteroids)
-- for i = 1, #asteroids do
--   asteroids[i].destroy({})
-- end
