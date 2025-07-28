local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local constants = require("prototypes/surfaces/constants")

local subterranean_science_item = {
    type = "tool",
    name = "subterranean-science-pack",
    icon = subterrain.subterranean_science_pack_image_path,
    icon_size = subterrain.subterranean_science_pack_image_size,
    subgroup = "science-pack",
    order = "g[subterranean-science-pack]",
    default_import_location = "nauvis",
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

local subterranean_science_recipe = {
    type = "recipe",
    name = "subterranean-science-pack",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
        { type = "item", name = "diamond-ore",   amount = 5 },
        { type = "item", name = "diamond-shard", amount = 2 },
        { type = "item", name = "iron-plate",    amount = 2 },
        { type = "item", name = "steel-plate",   amount = 2 },
    },
    results = { { type = "item", name = "subterranean-science-pack", amount = 1 } },
    crafting_machine_tint =
    {
        primary = { r = 0.0, g = 0.2, b = 1.0, a = 1.000 },
        secondary = { r = 0.0, g = 0.2, b = 1.0, a = 1.000 },
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
        }
    }
}

local subterranean_science_tech = {
    type = "technology",
    name = "subterranean-science-pack",
    icon = subterrain.subterranean_science_pack_image_path,
    icon_size = subterrain.subterranean_science_pack_image_size,
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "subterranean-science-pack"
        }
    },
    prerequisites = { "diamonds" },
    essential = true,
    research_trigger =
    {
        type = "craft-item",
        item = "diamond-shard",
        count = 1
    }
}

data:extend {
    subterranean_science_item,
    subterranean_science_recipe,
    subterranean_science_tech
}
