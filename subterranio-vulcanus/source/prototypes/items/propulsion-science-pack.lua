local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local constants = require("scripts.constants")

local item = {
    type = "tool",
    name = "propulsion-science-pack",
    icon = constants.propulsion_science_pack_path,
    icon_size = constants.propulsion_science_pack_size,
    subgroup = "science-pack",
    order = "h[propulsion-science-pack]",
    default_import_location = "vulcanus",
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
    name = "propulsion-science-pack",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
        { type = "item", name = "iron-plate",     amount = 1 },
        { type = "item", name = "aluminum-ingot", amount = 1 },
        { type = "item", name = "titanium-hunk",  amount = 1 },
    },
    results = { { type = "item", name = "propulsion-science-pack", amount = 1 } },
    crafting_machine_tint =
    {
        primary = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 },
        secondary = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 },
    },
    allow_productivity = true,
    durability_description_key = "description.science-pack-remaining-amount-key",
    factoriopedia_durability_description_key = "description.factoriopedia-science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value",
    random_tint_color = item_tints.redish_science,
    surface_conditions = {
        {
            property = "pressure",
            min = 4000,
            max = 4000
        }
    }
}

local tech = {
    type = "technology",
    name = "propulsion-science-pack",
    icon = constants.propulsion_science_pack_path,
    icon_size = constants.propulsion_science_pack_size,
    prerequisites = { "aluminum-filtering", "titanium-pulverization" },
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "propulsion-science-pack"
        }
    },
    unit =
    {
        count = 2000,
        ingredients =
        {
            { "automation-science-pack",  1 },
            { "logistic-science-pack",    1 },
            { "chemical-science-pack",    1 },
            { "production-science-pack",  1 },
            { "utility-science-pack",     1 },
            { "space-science-pack",       1 },
            { "metallurgic-science-pack", 1 },
        },
        time = 30
    }
}

data:extend({
    item,
    recipe,
    tech
})
