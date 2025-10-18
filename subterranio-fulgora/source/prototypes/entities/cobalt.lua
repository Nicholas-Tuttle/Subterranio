local constants = require("scripts.constants")
local item_sounds = require("__base__.prototypes.item_sounds")

local ore_item = {
    type = "item",
    name = "cobalt-ore",
    icon = constants.cobalt_ore_path,
    icon_size = constants.cobalt_ore_size,
    subgroup = "subterranio-intermediate",
    order = "a-[cobalt-ore]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 100,
    weight = 5 * kg
}

local plate_item = {
    type = "item",
    name = "cobalt-plate",
    icon = constants.cobalt_plate_path,
    icon_size = constants.cobalt_plate_size,
    subgroup = "subterranio-intermediate",
    order = "a-[cobalt-plate]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 100,
    weight = 5 * kg
}

local plate_recipe = {
    type = "recipe",
    name = "cobalt-plate",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
        { type = "item",  name = "cobalt-ore",    amount = 2 }
    },
    results = { { type = "item", name = "cobalt-plate", amount = 1 } },
    allow_productivity = true,
    surface_conditions = {
        {
            property = "magnetic-field",
            min = 99,
            max = 99
        }
    }
}

local plate_tech = {
    type = "technology",
    name = "cobalt-plate",
    icons = {
        {
            icon = constants.cobalt_plate_path,
            icon_size = constants.cobalt_plate_size
        }
    },
    icon_size = 256,
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "cobalt-plate"
        }
    },
    prerequisites = { "type-1-scrap-recycling" },
    research_trigger = {
        type = "craft-item",
        item = "cobalt-ore",
        count = 1
    }
}

data:extend{ore_item, plate_item, plate_recipe, plate_tech}