local constants = require("scripts.constants")
local item_sounds = require("__base__.prototypes.item_sounds")

local item = {
  type = "item",
  name = "magnetic-shielding",
  icon = constants.magnetic_shielding_path,
  icon_size = constants.magnetic_shielding_size,
  subgroup = "subterranio-intermediate",
  order = "a-[magnetic-shielding]",
  inventory_move_sound = item_sounds.resource_inventory_move,
  pick_sound = item_sounds.resource_inventory_pickup,
  drop_sound = item_sounds.resource_inventory_move,
  stack_size = 100,
  weight = 5 * kg
}
local recipe = {
  type = "recipe",
  name = "magnetic-shielding",
  icon = constants.magnetic_shielding_path,
  icon_size = constants.magnetic_shielding_size,
  energy_required = 5,
  ingredients = { { type = "item", name = "iron-plate", amount = 1 } },
  results = { { type = "item", name = "magnetic-shielding", amount = 1 } },
  allow_productivity = true,
  enabled = false
}

local tech = {
  type = "technology",
  name = "magnetic-shielding",
  icons = {
    {
        icon = constants.magnetic_shielding_path,
        icon_size = constants.magnetic_shielding_size
    }
  },
  icon_size = 256,
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "magnetic-shielding"
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
