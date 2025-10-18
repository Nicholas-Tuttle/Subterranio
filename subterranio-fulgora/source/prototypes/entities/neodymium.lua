local constants = require("scripts.constants")
local item_sounds = require("__base__.prototypes.item_sounds")

local powder_item = {
    type = "item",
    name = "neodymium-powder",
    icon = constants.neodymium_powder_path,
    icon_size = constants.neodymium_powder_size,
    subgroup = "subterranio-intermediate",
    order = "a-[neodymium-powder]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 100,
    weight = 5 * kg
}

local intermediate_item = {
    type = "item",
    name = "neodymium",
    icon = constants.neodymium_path,
    icon_size = constants.neodymium_size,
    subgroup = "subterranio-intermediate",
    order = "a-[neodymium]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 100,
    weight = 5 * kg
}

local intermediate_recipe = {
    type = "recipe",
    name = "neodymium",
    enabled = false,
    energy_required = 60,
    ingredients =
    {
        { type = "item", name = "neodymium-powder", amount = 1 },
        { type = "item", name = "boron-powder",     amount = 1 },
        { type = "item", name = "iron-plate",       amount = 1 }
    },
    results = { { type = "item", name = "neodymium", amount = 1 } },
    allow_productivity = true,
    surface_conditions = {
        {
            property = "magnetic-field",
            min = 99,
            max = 99
        }
    }
}

local intermediate_tech = {
    type = "technology",
    name = "neodymium",
    icons = {
        {
            icon = constants.neodymium_path,
            icon_size = constants.neodymium_size
        }
    },
    icon_size = 256,
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "neodymium"
        }
    },
    prerequisites = { "advanced-scrap-recycling" },
    research_trigger =
    {
        type = "craft-item",
        item = "neodymium-powder",
        count = 100
    }
}

local magnet_item = {
    type = "item",
    name = "neodymium-magnet",
    icon = constants.neodymium_magnet_path,
    icon_size = constants.neodymium_magnet_size,
    subgroup = "subterranio-intermediate",
    order = "a-[neodymium-magnet]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 200,
    weight = 1 * kg
}

local magnet_recipe = {
    type = "recipe",
    name = "neodymium-magnet",
    enabled = false,
    energy_required = 1,
    ingredients =
    {
        { type = "item", name = "neodymium",    amount = 1 },
        { type = "item", name = "magnetic-casing", amount = 1 }
    },
    results = { { type = "item", name = "neodymium-magnet", amount = 1 } },
    allow_productivity = true,
    surface_conditions = {
        {
            property = "magnetic-field",
            min = 99,
            max = 99
        }
    }
}

local magnet_tech = {
    type = "technology",
    name = "neodymium-magnets",
    icons = {
        {
            icon = constants.neodymium_magnet_path,
            icon_size = constants.neodymium_magnet_size
        }
    },
    icon_size = 256,
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "neodymium-magnet"
        }
    },
    prerequisites = { "magnetic-component-processing" },
    unit =
    {
        count = 4000,
        ingredients =
        {
            { "automation-science-pack",      1 },
            { "logistic-science-pack",        1 },
            { "chemical-science-pack",        1 },
            { "space-science-pack",           1 },
            { "subterranean-science-pack",    1 }, -- TODO: Only if ST Nauvis is present
            { "electromagnetic-science-pack", 1 },
        },
        time = 60
    }
}

data:extend { powder_item, intermediate_item, intermediate_recipe, intermediate_tech, magnet_item, magnet_recipe, magnet_tech }
