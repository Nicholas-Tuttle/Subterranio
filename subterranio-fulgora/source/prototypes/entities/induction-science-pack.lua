local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local constants = require("scripts.constants")

local item = {
    type = "tool",
    name = "induction-science-pack",
    icon = constants.induction_science_pack_path,
    icon_size = constants.induction_science_pack_size,
    subgroup = "science-pack",
    order = "g[induction-science-pack]",
    default_import_location = "fulgora",
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
    name = "induction-science-pack",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
        { type = "item", name = "neodymium-powder",        amount = 10 },
        { type = "item", name = "boron-powder",            amount = 10 },
        { type = "item", name = "neodymium",               amount = 1 },
        { type = "item", name = "cobalt-plate",            amount = 1 },
        { type = "item", name = "electrostatic-shielding", amount = 1 },
        { type = "item", name = "steel-plate",             amount = 10 },
        { type = "item", name = "iron-plate",              amount = 10 },
        { type = "item", name = "copper-plate",            amount = 10 },
    },
    results = { { type = "item", name = "induction-science-pack", amount = 6 } },
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
            property = "magnetic-field",
            min = 99,
            max = 99
        }
    }
}

local tech = {
    type = "technology",
    name = "induction-science-pack",
    icon = constants.induction_science_pack_path,
    icon_size = constants.induction_science_pack_size,
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "induction-science-pack"
        }
    },
    prerequisites = { "boron-powder", "cobalt-plate", "neodymium" },
    essential = true,
    unit =
    {
        count = 1000,
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

data:extend { item, recipe, tech }
