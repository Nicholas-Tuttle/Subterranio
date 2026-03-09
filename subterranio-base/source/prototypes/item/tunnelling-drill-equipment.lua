local item_sounds = require("__base__.prototypes.item_sounds")

local equipment = {
    type = "movement-bonus-equipment",
    name = "tunnelling-drill-equipment",
    sprite = {
        filename = subterrain.tunnelling_drill_equipment_path,
        width = subterrain.tunnelling_drill_equipment_size,
        height = subterrain.tunnelling_drill_equipment_size,
        priority = "medium",
        scale = 0.5
    },
    shape = {
        width = 2,
        height = 2,
        type = "full"
    },
    categories = { "armor" },
    energy_source = {
        type = "electric",
        usage_priority = "primary-input",
        output_flow_limit = "1W"
    },
    energy_consumption = "1W",
    movement_bonus = 0.0
}

local item = {
    type = "item",
    name = "tunnelling-drill-equipment",
    icon = subterrain.tunnelling_drill_equipment_path,
    icon_size = subterrain.tunnelling_drill_equipment_size,
    place_as_equipment_result = "tunnelling-drill-equipment",
    subgroup = "utility-equipment",
    order = "g[toolbelt]-z[tunnelling-drill-equipment]",
    inventory_move_sound = item_sounds.armor_small_inventory_move,
    pick_sound = item_sounds.armor_small_inventory_pickup,
    drop_sound = item_sounds.armor_small_inventory_move,
    stack_size = 20,
    weight = 50 * kg
}

local technology = {
    type = "technology",
    name = "tunnelling-drill-equipment",
    icon = subterrain.tunnelling_drill_equipment_path,
    icon_size = subterrain.tunnelling_drill_equipment_size,
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "tunnelling-drill-equipment"
        },
        {
            type = "unlock-recipe",
            recipe = "geothermal-powerplant"
        }
    },
    prerequisites = {
        "low-density-structure",
        "processing-unit",
        "electric-engine",
        "modular-armor",
        "lubricant"
    },
    unit =
    {
        count = 100,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 }
        },
        time = 30
    }
}

local recipe = {
    type = "recipe",
    name = "tunnelling-drill-equipment",
    category = "crafting-with-fluid",
    enabled = false,
    energy_required = 1,
    ingredients = {
        { type = "item",  name = "low-density-structure", amount = 20 },
        { type = "item",  name = "steel-plate",           amount = 10 },
        { type = "item",  name = "processing-unit",       amount = 20 },
        { type = "item",  name = "electric-engine-unit",  amount = 10 },
        { type = "fluid", name = "lubricant",             amount = 100 }
    },
    results = { { type = "item", name = "tunnelling-drill-equipment", amount = 1 } }
}

local custom_input = {
    type = "custom-input",
    key_sequence = "CONTROL + ENTER",
    name = "subterranean-mineshaft-player-enter",
    consuming = "game-only",
    alternative_key_sequence = "",
    controller_alternative_key_sequence = "",
    action = "lua",
}

data:extend { equipment, item, technology, recipe, custom_input }
