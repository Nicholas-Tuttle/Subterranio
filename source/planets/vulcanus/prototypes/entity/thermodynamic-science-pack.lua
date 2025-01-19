local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")

local thermodynamic_science_item = {
    type = "item",
    name = "thermodynamic-science-pack",
    icon = "__subterranio__/graphics/entity/diamond.png",
    icon_size = 512,
    subgroup = "science-pack",
    order = "g[thermodynamic-science-pack]",
    default_import_location = "vulcanus",
    inventory_move_sound = item_sounds.science_inventory_move,
    pick_sound = item_sounds.science_inventory_pickup,
    drop_sound = item_sounds.science_inventory_move,
    stack_size = 200,
    weight = 1*kg
}

local thermodynamic_science_recipe = {
    type = "recipe",
    name = "thermodynamic-science-pack",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type = "item", name = "steel-plate", amount = 2},
      {type = "item", name = "iron-plate", amount = 2},
      {type = "item", name = "copper-plate", amount = 1}
    },
    results = {{type="item", name="thermodynamic-science-pack", amount=1}},
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

local thermodynamic_science_tech = {
    type = "technology",
    name = "thermodynamic-science-pack",
    icon = "__subterranio__/graphics/entity/diamond.png",
    icon_size = 512,
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "thermodynamic-science-pack"
        }
    },
    -- prerequisites = {"supermagnet"},
    essential = true,
    research_trigger =
    {
      type = "craft-item",
      item = "iron-plate",
      count = 1
    }
}

data:extend{thermodynamic_science_item, thermodynamic_science_recipe, thermodynamic_science_tech}