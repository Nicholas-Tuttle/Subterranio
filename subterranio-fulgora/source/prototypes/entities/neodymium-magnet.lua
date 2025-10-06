local constants = require("scripts.constants")
local item_sounds = require("__base__.prototypes.item_sounds")

local item = {
  type = "item",
  name = "neodymium-magnet",
  icon = constants.neodymium_magnet_path,
  icon_size = constants.neodymium_magnet_size,
  subgroup = "subterranio-intermediate",
  order = "a-[neodymium-magnet]",
  inventory_move_sound = item_sounds.resource_inventory_move,
  pick_sound = item_sounds.resource_inventory_pickup,
  drop_sound = item_sounds.resource_inventory_move,
  stack_size = 100,
  weight = 5 * kg
}
local recipe = {
  type = "recipe",
  name = "neodymium-magnet",
  icon = constants.neodymium_magnet_path,
  icon_size = constants.neodymium_magnet_size,
  energy_required = 5,
  ingredients = { { type = "item", name = "iron-plate", amount = 1 } },
  results = { { type = "item", name = "neodymium-magnet", amount = 1 } },
  allow_productivity = true,
  enabled = false
}

local tech = {
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
  research_trigger =
  {
    type = "craft-item",
    item = "science-scrap",
    count = 50
  }
}

data:extend { item, recipe, tech }
