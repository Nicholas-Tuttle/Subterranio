local constants = require("scripts.constants")
local item_sounds = require("__base__.prototypes.item_sounds")

local refined_tint = { 0.5, 0.5, 1.0, 1.0 }
local primary_beacon_tint = { 0.741, 0.714, 1.000, 1.000 }
local secondary_beacon_tint = { 0.788, 0.976, 1.000, 1.000 }

local item1 = {
  type = "module",
  name = "refined-speed-module",
  localised_description = { "item-description.speed-module" },
  icons = { { icon = "__base__/graphics/icons/speed-module.png", tint = refined_tint } },
  subgroup = "module",
  color_hint = { text = "S" },
  category = "speed",
  tier = 1,
  order = "a[speed-refined]-a[refined-speed-module]",
  inventory_move_sound = item_sounds.module_inventory_move,
  pick_sound = item_sounds.module_inventory_pickup,
  drop_sound = item_sounds.module_inventory_move,
  stack_size = 50,
  weight = 20 * kg,
  effect = { speed = 0.2, consumption = 0.5 },
  beacon_tint =
  {
    primary = primary_beacon_tint,
    secondary = secondary_beacon_tint,
  },
  art_style = "vanilla",
  requires_beacon_alt_mode = false
}

local item2 = {
  type = "module",
  name = "refined-speed-module-2",
  localised_description = { "item-description.speed-module" },
  icons = { { icon = "__base__/graphics/icons/speed-module-2.png", tint = refined_tint } },
  subgroup = "module",
  category = "speed",
  color_hint = { text = "S" },
  tier = 2,
  order = "a[speed-refined]-b[refined-speed-module]",
  inventory_move_sound = item_sounds.module_inventory_move,
  pick_sound = item_sounds.module_inventory_pickup,
  drop_sound = item_sounds.module_inventory_move,
  stack_size = 50,
  weight = 20 * kg,
  effect = { speed = 0.3, consumption = 0.6 },
  beacon_tint =
  {
    primary = primary_beacon_tint,
    secondary = secondary_beacon_tint,
  },
  art_style = "vanilla",
  requires_beacon_alt_mode = false
}

local item3 = {
  type = "module",
  name = "refined-speed-module-3",
  localised_description = { "item-description.speed-module" },
  icons = { { icon = "__base__/graphics/icons/speed-module-3.png", tint = refined_tint } },
  subgroup = "module",
  color_hint = { text = "S" },
  category = "speed",
  tier = 3,
  order = "a[speed-refined]-c[refined-speed-module]",
  inventory_move_sound = item_sounds.module_inventory_move,
  pick_sound = item_sounds.module_inventory_pickup,
  drop_sound = item_sounds.module_inventory_move,
  stack_size = 50,
  weight = 20 * kg,
  effect = { speed = 0.5, consumption = 0.7 },
  beacon_tint =
  {
    primary = primary_beacon_tint,
    secondary = secondary_beacon_tint,
  },
  art_style = "vanilla",
  requires_beacon_alt_mode = false
}

local recipe1 = {
  type = "recipe",
  name = "refined-speed-module",
  icons = { { icon = "__base__/graphics/icons/speed-module.png", tint = refined_tint } },
  enabled = false,
  ingredients =
  {
    { type = "item", name = "speed-module",   amount = 2 },
    { type = "item", name = "quality-module", amount = 2 },
    { type = "item", name = "holmium-ore",    amount = 10 },
  },
  energy_required = 15,
  results = { { type = "item", name = "refined-speed-module", amount = 1 } }
}

local recipe2 = {
  type = "recipe",
  name = "refined-speed-module-2",
  icons = { { icon = "__base__/graphics/icons/speed-module-2.png", tint = refined_tint } },
  enabled = false,
  ingredients =
  {
    { type = "item", name = "refined-speed-module", amount = 2 },
    { type = "item", name = "quality-module-2",     amount = 2 },
    { type = "item", name = "holmium-plate",        amount = 10 },
    { type = "item", name = "cobalt-plate",         amount = 10 },
  },
  energy_required = 15,
  results = { { type = "item", name = "refined-speed-module-2", amount = 1 } }
}

local recipe3 = {
  type = "recipe",
  name = "refined-speed-module-3",
  icons = { { icon = "__base__/graphics/icons/speed-module-3.png", tint = refined_tint } },
  enabled = false,
  ingredients =
  {
    { type = "item", name = "refined-speed-module-2", amount = 4 },
    { type = "item", name = "quality-module-3",       amount = 4 },
    { type = "item", name = "magnetic-shielding",     amount = 25 },
    { type = "item", name = "neodymium-magnet",       amount = 25 },
  },
  energy_required = 15,
  results = {
    { type = "item", name = "refined-speed-module-3",     amount = 1 },
    { type = "item", name = "damaged-magnetic-packaging", amount = 25, probability = constants.damaged_packaging_return_change, show_details_in_recipe_tooltip = false },
    { type = "item", name = "magnetic-packaging",         amount = 25, probability = constants.undamaged_packaging_return_change, show_details_in_recipe_tooltip = false },
  }
}

local tech1 = {
  type = "technology",
  name = "refined-speed-module",
  icons = { { icon = "__base__/graphics/icons/speed-module.png", tint = refined_tint } },
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "refined-speed-module"
    }
  },
  prerequisites = { "speed-module", "quality-module" },
  unit =
  {
    count = 500,
    ingredients =
    {
      { "automation-science-pack", 1 },
      { "logistic-science-pack",   1 },
      { "chemical-science-pack",   1 },
      { "production-science-pack", 1 },
      { "space-science-pack",      1 },
      { "induction-science-pack",  1 },
    },
    time = 60
  },
  upgrade = true
}

local tech2 = {
  type = "technology",
  name = "refined-speed-module-2",
  icons = { { icon = "__base__/graphics/icons/speed-module-2.png", tint = refined_tint } },
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "refined-speed-module-2"
    }
  },
  prerequisites = { "refined-speed-module", "speed-module-2", "quality-module-2" },
  unit =
  {
    count = 1000,
    ingredients =
    {
      { "automation-science-pack", 1 },
      { "logistic-science-pack",   1 },
      { "chemical-science-pack",   1 },
      { "production-science-pack", 1 },
      { "space-science-pack",      1 },
      { "induction-science-pack",  1 },
    },
    time = 60
  },
  upgrade = true
}

local tech3 = {
  type = "technology",
  name = "refined-speed-module-3",
  icons = { { icon = "__base__/graphics/icons/speed-module-3.png", tint = refined_tint } },
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "refined-speed-module-3"
    }
  },
  prerequisites = { "refined-speed-module-2", "speed-module-3", "quality-module-3" },
  unit =
  {
    count = 2000,
    ingredients =
    {
      { "automation-science-pack",  1 },
      { "logistic-science-pack",    1 },
      { "chemical-science-pack",    1 },
      { "production-science-pack",  1 },
      { "space-science-pack",       1 },
      { "metallurgic-science-pack", 1 },
      { "induction-science-pack",   1 },
    },
    time = 60
  },
  upgrade = true
}

data:extend { item1, item2, item3, recipe1, recipe2, recipe3, tech1, tech2, tech3 }
