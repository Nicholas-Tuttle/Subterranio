local constants = require("scripts.constants")
local item_sounds = require("__base__.prototypes.item_sounds")

local item = {
  type = "item",
  name = "electromagnet",
  icon = constants.electromagnet_path,
  icon_size = constants.electromagnet_size,
  subgroup = "subterranio-intermediate",
  order = "a-[electromagnet]",
  inventory_move_sound = item_sounds.resource_inventory_move,
  pick_sound = item_sounds.resource_inventory_pickup,
  drop_sound = item_sounds.resource_inventory_move,
  stack_size = 100,
  weight = 5 * kg
}
local recipe = {
  type = "recipe",
  name = "electromagnet",
  icon = constants.electromagnet_path,
  icon_size = constants.electromagnet_size,
  energy_required = 5,
  ingredients = { { type = "item", name = "iron-plate", amount = 1 } },
  results = { { type = "item", name = "electromagnet", amount = 1 } },
  allow_productivity = true,
  enabled = false
}

local tech = {
  type = "technology",
  name = "electromagnet",
  icons = {
    {
        icon = constants.electromagnet_path,
        icon_size = constants.electromagnet_size
    }
  },
  icon_size = 256,
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "electromagnet"
    }
  },
  prerequisites = { "holmium-cabling" },
  unit =
  {
      count = 1000,
      ingredients =
      {
          { "automation-science-pack", 1 },
          { "logistic-science-pack", 1 },
          { "military-science-pack", 1 },
          { "chemical-science-pack", 1 },
          { "utility-science-pack", 1 },
          { "subterranean-science-pack", 1 }, -- TODO: Only if ST Nauvis is present
          { "electromagnetic-science-pack", 1 },
      },
      time = 60
  }
}

data:extend { item, recipe, tech }
