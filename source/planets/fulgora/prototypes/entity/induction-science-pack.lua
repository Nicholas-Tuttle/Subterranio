local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

local induction_science_item = {
    type = "item",
    name = "induction-science-pack",
    icon = subterrain.diamond_image_path,
    icon_size = subterrain.diamond_image_size,
    subgroup = "science-pack",
    order = "g[induction-science-pack]",
    default_import_location = "fulgora",
    inventory_move_sound = item_sounds.science_inventory_move,
    pick_sound = item_sounds.science_inventory_pickup,
    drop_sound = item_sounds.science_inventory_move,
    stack_size = 200,
    weight = 1*kg
}

local induction_science_recipe = {
    type = "recipe",
    name = "induction-science-pack",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
        {type = "item", name = "iron-plate", amount = 2},
        -- {type = "item", name = "superconductor", amount = 2},
        -- {type = "item", name = "supercapacitor", amount = 2},
        -- {type = "item", name = "supermagnet", amount = 1}
    },
    results = {{type="item", name="induction-science-pack", amount=1}},
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

local induction_science_tech = {
    type = "technology",
    name = "induction-science-pack",
    icon = subterrain.diamond_image_path,
    icon_size = subterrain.diamond_image_size,
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "induction-science-pack"
        }
    },
    -- prerequisites = {"supermagnet"},
    essential = true,
    research_trigger =
    {
      type = "craft-item",
      item = "iron-plate", -- supermagnet
      count = 1
    }
}

data:extend{induction_science_item, induction_science_recipe, induction_science_tech}