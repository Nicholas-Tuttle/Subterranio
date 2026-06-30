local item_sounds = require("__base__.prototypes.item_sounds")
local surface_tiles_definitions = require("prototypes.surfaces.surface-tiles-definitions")
local graphics_tinter = require("__subterranio-base__/utilities/graphics-tinter")

local cold_tiles = {
    "gleban-subterranean-deep-water"
}
local hot_tiles = {
    "gleban-subterranean-deep-water"
}

for _, value in pairs(surface_tiles_definitions.randomized_tiles) do
    cold_tiles[#cold_tiles + 1] = "gleban-subterranean-" .. value
    hot_tiles[#hot_tiles + 1] = "gleban-subterranean-" .. value
end

for _, value in pairs(surface_tiles_definitions.biomes.blue.tiles) do
    cold_tiles[#cold_tiles + 1] = "gleban-subterranean-" .. value .. "-blue"
end

for _, value in pairs(surface_tiles_definitions.biomes.red.tiles) do
    hot_tiles[#hot_tiles + 1] = "gleban-subterranean-" .. value .. "-red"
end


local overgrowth_cold_soil_item = {
    type = "item",
    name = "overgrowth-cold-soil",
    icons = { { icon = "__space-age__/graphics/icons/overgrowth-yumako-soil.png", tint = { r = 0.5, g = 0.5, b = 1.0 } } },
    subgroup = "terrain",
    order = "c[landfill]-ez[overgrowth-cold-soil]",
    inventory_move_sound = item_sounds.landfill_inventory_move,
    pick_sound = item_sounds.landfill_inventory_pickup,
    drop_sound = item_sounds.landfill_inventory_move,
    stack_size = 100,
    default_import_location = "gleba",
    place_as_tile =
    {
        result = "overgrowth-cold-soil",
        condition_size = 1,
        condition = { layers = {} },
        tile_condition = cold_tiles
    }
}

local overgrowth_hot_soil_item = {
    type = "item",
    name = "overgrowth-hot-soil",
    icons = { { icon = "__space-age__/graphics/icons/overgrowth-jellynut-soil.png", tint = { r = 1.0, g = 0.5, b = 0.5 } } },
    subgroup = "terrain",
    order = "c[landfill]-ez[overgrowth-hot-soil]",
    inventory_move_sound = item_sounds.landfill_inventory_move,
    pick_sound = item_sounds.landfill_inventory_pickup,
    drop_sound = item_sounds.landfill_inventory_move,
    stack_size = 100,
    default_import_location = "gleba",
    place_as_tile =
    {
        result = "overgrowth-hot-soil",
        condition_size = 1,
        condition = { layers = {} },
        tile_condition = hot_tiles
    }
}

local overgrowth_cold_soil_tile = table.deepcopy(data.raw["tile"]["overgrowth-yumako-soil"])
overgrowth_cold_soil_tile.name = "overgrowth-cold-soil"
overgrowth_cold_soil_tile.minable.result = "overgrowth-cold-soil"
overgrowth_cold_soil_tile.map_color = { r = 50, g = 50, b = 255 }
overgrowth_cold_soil_tile.decorative_removal_probability = 1.0
overgrowth_cold_soil_tile = graphics_tinter.tint(overgrowth_cold_soil_tile, { r = 50, g = 50, b = 255 })

local overgrowth_hot_soil_tile = table.deepcopy(data.raw["tile"]["overgrowth-jellynut-soil"])
overgrowth_hot_soil_tile.name = "overgrowth-hot-soil"
overgrowth_hot_soil_tile.minable.result = "overgrowth-hot-soil"
overgrowth_hot_soil_tile.map_color = { r = 255, g = 50, b = 50 }
overgrowth_hot_soil_tile.decorative_removal_probability = 1.0
overgrowth_hot_soil_tile = graphics_tinter.tint(overgrowth_hot_soil_tile, { r = 255, g = 50, b = 50 })

local overgrowth_cold_soil_recipe = {
    type = "recipe",
    name = "overgrowth-cold-soil",
    categories = { "crafting-with-fluid" },
    energy_required = 1,
    ingredients = {
        { type = "item",  name = "overgrowth-yumako-soil", amount = 3 },
        { type = "item",  name = "cold-resistant-bacteria", amount = 5 },
        { type = "item",  name = "expansion-resistant-fungi", amount = 5 },
        { type = "fluid", name = "water",                  amount = 50 }
    },
    results = {
        { type = "item", name = "overgrowth-cold-soil", amount = 1 }
    },
    enabled = false,
}

local overgrowth_hot_soil_recipe = {
    type = "recipe",
    name = "overgrowth-hot-soil",
    categories = { "crafting-with-fluid" },
    energy_required = 1,
    ingredients = {
        { type = "item",  name = "overgrowth-jellynut-soil", amount = 3 },
        { type = "item",  name = "heat-resistant-bacteria", amount = 5 },
        { type = "item",  name = "compression-resistant-fungi", amount = 5 },
        { type = "fluid", name = "water",                  amount = 50 }
    },
    results = {
        { type = "item", name = "overgrowth-hot-soil", amount = 1 }
    },
    enabled = false,
}

local overgrowth_soil_tech = {
    type = "technology",
    name = "subterranean-overgrowth-soil",
    icon = "__space-age__/graphics/technology/overgrowth-soil.png",
    icon_size = 256,
    prerequisites = { "cold-resistant-bacteria", "heat-resistant-bacteria", "compression-resistant-fungi", "expansion-resistant-fungi", "overgrowth-soil", "biological-science-pack" },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "overgrowth-cold-soil"
        },
        {
            type = "unlock-recipe",
            recipe = "overgrowth-hot-soil"
        }
    },
    unit =
    {
        count = 1000,
        ingredients =
        {
            { "automation-science-pack",   1 },
            { "logistic-science-pack",     1 },
            { "chemical-science-pack",     1 },
            { "space-science-pack",        1 },
            { "agricultural-science-pack", 1 },
            { "biological-science-pack",   1 }
        },
        time = 60
    }
}

data:extend({
    overgrowth_cold_soil_item,
    overgrowth_hot_soil_item,
    overgrowth_cold_soil_tile,
    overgrowth_hot_soil_tile,
    overgrowth_cold_soil_recipe,
    overgrowth_hot_soil_recipe,
    overgrowth_soil_tech
})
