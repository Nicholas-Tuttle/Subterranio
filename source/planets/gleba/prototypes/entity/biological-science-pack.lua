local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

local biological_science_item = {
    type = "item",
    name = "biological-science-pack",
    icon = subterrain.diamond_image_path,
    icon_size = subterrain.diamond_image_size,
    subgroup = "science-pack",
    order = "g[biological-science-pack]",
    default_import_location = "gleba",
    inventory_move_sound = item_sounds.science_inventory_move,
    pick_sound = item_sounds.science_inventory_pickup,
    drop_sound = item_sounds.science_inventory_move,
    stack_size = 200,
    weight = 1*kg
}

local biological_science_recipe = {
    type = "recipe",
    name = "biological-science-pack",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type = "item", name = "bioflux", amount = 1},
      {type = "item", name = "preservatives", amount = 5},
      {type = "item", name = "raw-fish", amount = 1}
    },
    results = {{type="item", name="biological-science-pack", amount=1}},
    crafting_machine_tint =
    {
        primary = {r = 0.0, g = 0.2, b = 1.0, a = 1.000},
        secondary = {r = 0.0, g = 0.2, b = 1.0, a = 1.000},
    },
    allow_productivity = true,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    factoriopedia_durability_description_key = "description.factoriopedia-science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value",
    random_tint_color = item_tints.bluish_science
}

local biological_science_tech = {
    type = "technology",
    name = "biological-science-pack",
    icon = subterrain.diamond_image_path,
    icon_size = subterrain.diamond_image_size,
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "biological-science-pack"
        }
    },
    --prerequisites = {"preservatives"},
    essential = true,
    research_trigger =
    {
      type = "craft-item",
      item = "preservatives",
      count = 5
    }
}

data:extend{
    biological_science_item,
    biological_science_recipe,
    biological_science_tech
}
