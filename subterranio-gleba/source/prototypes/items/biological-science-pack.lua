local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local constants = require("scripts.constants")

local item = {
    type = "tool",
    name = "biological-science-pack",
    icon = constants.biological_science_pack_path,
    icon_size = constants.biological_science_pack_size,
    subgroup = "science-pack",
    order = "iz[biological-science-pack]",
    default_import_location = "gleba",
    inventory_move_sound = item_sounds.science_inventory_move,
    pick_sound = item_sounds.science_inventory_pickup,
    drop_sound = item_sounds.science_inventory_move,
    stack_size = 200,
    weight = 1 * kg,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    factoriopedia_durability_description_key = "description.factoriopedia-science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value",
}

local recipe = {
    type = "recipe",
    name = "biological-science-pack",
    enabled = false,
    energy_required = 5,
    category = "organic-or-assembling",
    ingredients =
    {
        { type = "item", name = "iron-bacteria",               amount = 1 },
        { type = "item", name = "copper-bacteria",             amount = 1 },
        { type = "item", name = "cold-resistant-bacteria",     amount = 1 },
        { type = "item", name = "heat-resistant-bacteria",     amount = 1 },
        { type = "item", name = "compression-resistant-fungi", amount = 1 },
        { type = "item", name = "expansion-resistant-fungi",   amount = 1 },
    },
    results = { { type = "item", name = "biological-science-pack", amount = 6 } },
    crafting_machine_tint =
    {
        primary = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 },
        secondary = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 },
    },
    allow_productivity = true,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    factoriopedia_durability_description_key = "description.factoriopedia-science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value",
    random_tint_color = item_tints.bluish_science,
    surface_conditions = {
        {
            property = "pressure",
            min = constants.subterrain_pressure,
            max = constants.subterrain_pressure
        },
        {
            property = "magnetic-field",
            min = constants.subterrain_magnetic_field,
            max = constants.subterrain_magnetic_field
        },
        {
            property = "gravity",
            min = constants.subterrain_gravity,
            max = constants.subterrain_gravity
        }
    }
}

local tech = {
    type = "technology",
    name = "biological-science-pack",
    icon = constants.biological_science_pack_path,
    icon_size = constants.biological_science_pack_size,
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "biological-science-pack"
        }
    },
    prerequisites = {
        "agricultural-science-pack",
        "cold-resistant-bacteria",
        "heat-resistant-bacteria",
        "expansion-resistant-fungi",
        "compression-resistant-fungi"
    },
    essential = true,
    unit =
    {
        count = 1000,
        ingredients =
        {
            { "automation-science-pack",   1 },
            { "logistic-science-pack",     1 },
            { "chemical-science-pack",     1 },
            { "space-science-pack",        1 },
            { "subterranean-science-pack", 1 },
            { "agricultural-science-pack", 1 },
        },
        time = 60
    }
}

data:extend({ item, recipe, tech })
