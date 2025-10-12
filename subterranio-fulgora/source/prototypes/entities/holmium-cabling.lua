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
  energy_required = 0.5,
  ingredients = { { type = "item", name = "holmium-plate", amount = 1 } },
  results = { { type = "item", name = "holmium-cabling", amount = 2 } },
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
  unit =
  {
      count = 1000,
      ingredients =
      {
          { "automation-science-pack", 1 },
          { "logistic-science-pack", 1 },
          { "chemical-science-pack", 1 },
          { "space-science-pack", 1 },
          { "subterranean-science-pack", 1 }, -- TODO: Only if ST Nauvis is present
          { "electromagnetic-science-pack", 1 },
      },
      time = 60
  }
}

data:extend { item, recipe, tech }
