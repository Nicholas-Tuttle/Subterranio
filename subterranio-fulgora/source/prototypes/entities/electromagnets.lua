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
  category = "magnetic-components",
  ingredients = {
    { type = "item", name = "iron-plate",       amount = 2 },
    { type = "item", name = "copper-cable",     amount = 2 },
    { type = "item", name = "advanced-circuit", amount = 1 },
    { type = "item", name = "holmium-cabling",  amount = 1 },
    { type = "item", name = "magnetic-casing",  amount = 1 },
  },
  results = { { type = "item", name = "electromagnet", amount = 1 } },
  allow_productivity = true,
  enabled = false
}

local tech = {
  type = "technology",
  name = "electromagnets",
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
  prerequisites = { "holmium-cabling", "magnetic-component-processing" },
  unit =
  {
    count = 2000,
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
