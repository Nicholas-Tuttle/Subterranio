local constants = require("scripts.constants")
local item_sounds = require("__base__.prototypes.item_sounds")

local chunk_item = {
    type = "item",
    name = "boron-chunk",
    icon = constants.boron_chunk_path,
    icon_size = constants.boron_chunk_size,
    subgroup = "subterranio-intermediate",
    order = "a-[boron-chunk]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 100,
    weight = 5 * kg
}

local powder_item = {
    type = "item",
    name = "boron-powder",
    icon = constants.boron_powder_path,
    icon_size = constants.boron_powder_size,
    subgroup = "subterranio-intermediate",
    order = "a-[boron-powder]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 100,
    weight = 5 * kg
}

local powder_recipe = {
    type = "recipe",
    name = "boron-powder",
    enabled = false,
    energy_required = 10,
    category = "advanced-crafting",
    ingredients =
    {
        { type = "item",  name = "boron-chunk",    amount = 5 },
        { type = "fluid", name = "sulfuric-acid", amount = 200 }
    },
    results = { { type = "item", name = "boron-powder", amount = 100 } },
    allow_productivity = true,
    surface_conditions = {
        {
            property = "magnetic-field",
            min = 99,
            max = 99
        }
    }
}

local powder_tech = {
    type = "technology",
    name = "boron-powder",
    icons = {
        {
            icon = constants.boron_powder_path,
            icon_size = constants.boron_powder_size
        }
    },
    icon_size = 256,
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "boron-powder"
        }
    },
    prerequisites = { "type-2-scrap-recycling" },
    research_trigger = {
        type = "craft-item",
        item = "boron-chunk",
        count = 1
    }
}

data:extend { chunk_item, powder_item, powder_recipe, powder_tech }
