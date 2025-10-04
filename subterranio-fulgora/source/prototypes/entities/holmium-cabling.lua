local constants = require("scripts.constants")
local item_sounds = require("__base__.prototypes.item_sounds")

local item = {
  type = "item",
  name = "holmium-cabling",
  icon = constants.holmium_cabling_path,
  icon_size = constants.holmium_cabling_size,
  subgroup = "subterranio-intermediate",
  order = "a-[holmium-cabling]",
  inventory_move_sound = item_sounds.resource_inventory_move,
  pick_sound = item_sounds.resource_inventory_pickup,
  drop_sound = item_sounds.resource_inventory_move,
  stack_size = 100,
  weight = 5 * kg
}
local recipe = {
  type = "recipe",
  name = "holmium-cabling",
  icon = constants.holmium_cabling_path,
  icon_size = constants.holmium_cabling_size,
  energy_required = 5,
  ingredients = { { type = "item", name = "iron-plate", amount = 1 } },
  results = { { type = "item", name = "holmium-cabling", amount = 1 } },
  allow_productivity = true,
  enabled = false
}

local tech = {
  type = "technology",
  name = "holmium-cabling",
  icons = {
    {
        icon = constants.holmium_cabling_path,
        icon_size = constants.holmium_cabling_size
    }
  },
  icon_size = 256,
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "holmium-cabling"
    }
  },
  prerequisites = { "induction-science-pack" },
  research_trigger =
  {
    type = "craft-item",
    item = "military-scrap",
    count = 50
  }
}

data:extend { item, recipe, tech }
