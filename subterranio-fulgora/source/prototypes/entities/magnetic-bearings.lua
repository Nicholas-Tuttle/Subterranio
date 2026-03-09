local constants = require("scripts.constants")
local item_sounds = require("__base__.prototypes.item_sounds")

local item = {
  type = "item",
  name = "magnetic-bearings",
  icon = constants.magnetic_bearings_path,
  icon_size = constants.magnetic_bearings_size,
  subgroup = "subterranio-fulgora-intermediate",
  order = "a-[magnetic-bearings]",
  inventory_move_sound = item_sounds.resource_inventory_move,
  pick_sound = item_sounds.resource_inventory_pickup,
  drop_sound = item_sounds.resource_inventory_move,
  stack_size = 100,
  weight = 5 * kg
}

local recipe = {
  type = "recipe",
  name = "magnetic-bearings",
  icon = constants.magnetic_bearings_path,
  icon_size = constants.magnetic_bearings_size,
  energy_required = 5,
  category = "magnetic-components",
  ingredients = {
    { type = "item", name = "steel-plate",      amount = 2 },
    { type = "item", name = "electromagnet",    amount = 1 },
    { type = "item", name = "neodymium-magnet", amount = 1 },
  },
  results = {
    { type = "item", name = "magnetic-bearings",          amount = 1 },
    { type = "item", name = "damaged-magnetic-packaging", amount = 10, probability = constants.damaged_packaging_return_change, show_details_in_recipe_tooltip = false },
    { type = "item", name = "magnetic-packaging",         amount = 10, probability = constants.undamaged_packaging_return_change, show_details_in_recipe_tooltip = false },
  },
  allow_productivity = true,
  enabled = false
}

local tech = {
  type = "technology",
  name = "magnetic-bearings",
  icons = {
    {
      icon = constants.magnetic_bearings_path,
      icon_size = constants.magnetic_bearings_size
    }
  },
  icon_size = 256,
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "magnetic-bearings"
    }
  },
  prerequisites = { "electromagnets", "neodymium-magnets" },
  unit =
  {
    count = 5000,
    ingredients =
    {
      { "automation-science-pack",      1 },
      { "logistic-science-pack",        1 },
      { "chemical-science-pack",        1 },
      { "space-science-pack",           1 },
      { "electromagnetic-science-pack", 1 },
    },
    time = 60
  }
}

data:extend { item, recipe, tech }
