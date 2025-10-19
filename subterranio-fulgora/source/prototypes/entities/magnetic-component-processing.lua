local constants = require("scripts.constants")
local item_sounds = require("__base__.prototypes.item_sounds")

local item1 = {
  type = "item",
  name = "magnetic-packaging",
  icon = constants.magnetic_packaging_path,
  icon_size = constants.magnetic_packaging_size,
  subgroup = "subterranio-intermediate",
  order = "a-[magnetic-packaging]",
  inventory_move_sound = item_sounds.resource_inventory_move,
  pick_sound = item_sounds.resource_inventory_pickup,
  drop_sound = item_sounds.resource_inventory_move,
  stack_size = 100,
  weight = 5 * kg
}

local item2 = {
  type = "item",
  name = "damaged-magnetic-packaging",
  icons = { { icon = constants.magnetic_packaging_path, icon_size = constants.magnetic_packaging_size, tint = { 0.5, 0.5, 0.5, 1.0 } } },
  subgroup = "subterranio-intermediate",
  order = "a-[damaged-magnetic-packaging]",
  inventory_move_sound = item_sounds.resource_inventory_move,
  pick_sound = item_sounds.resource_inventory_pickup,
  drop_sound = item_sounds.resource_inventory_move,
  stack_size = 100,
  weight = 5 * kg
}

local item3 = {
  type = "item",
  name = "magnetic-component-assembler",
  icon = nil,
  icons = { { icon = "__base__/graphics/icons/assembling-machine-3.png", tint = constants.fulgoran_subway_tint } },
  subgroup = "production-machine",
  order = "a-[magnetic-component-assembler]",
  place_result = "magnetic-component-assembler",
  inventory_move_sound = item_sounds.resource_inventory_move,
  pick_sound = item_sounds.resource_inventory_pickup,
  drop_sound = item_sounds.resource_inventory_move,
  stack_size = 100,
  weight = 5 * kg
}

local entity = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"])
entity.name = "magnetic-component-assembler"
entity.minable.result = "magnetic-component-assembler"
entity.crafting_speed = 1.0
entity.graphics_set.animation.layers[1].tint = constants.fulgoran_subway_tint
entity.graphics_set.animation.layers[2].tint = constants.fulgoran_subway_tint
entity.crafting_categories = { "magnetic-components" }

local recipe1 = {
  type = "recipe",
  name = "magnetic-packaging",
  icon = constants.magnetic_packaging_path,
  icon_size = constants.magnetic_packaging_size,
  energy_required = 5,
  ingredients = { { type = "item", name = "iron-plate", amount = 1 } },
  results = { { type = "item", name = "magnetic-packaging", amount = 1 } },
  allow_productivity = true,
  enabled = false
}

local recipe2 = {
  type = "recipe",
  name = "magnetic-packaging-repair",
  icon = constants.magnetic_packaging_path,
  icon_size = constants.magnetic_packaging_size,
  energy_required = .5,
  ingredients = { { type = "item", name = "damaged-magnetic-packaging", amount = 1 } },
  results = { { type = "item", name = "magnetic-packaging", amount = 1 } },
  allow_productivity = true,
  enabled = false
}

local recipe3 = {
  type = "recipe",
  name = "magnetic-component-assembler",
  icon = constants.diamond_image_path,
  icon_size = constants.diamond_image_size,
  energy_required = 5,
  category = "electromagnetics",
  ingredients = {
    { type = "item", name = "assembling-machine-3", amount = 1 },
    { type = "item", name = "magnetic-shielding",   amount = 5 },
    { type = "item", name = "superconductor",       amount = 5 },
    { type = "item", name = "supercapacitor",       amount = 5 },
    { type = "item", name = "plastic-bar",          amount = 20 },
  },
  results = { { type = "item", name = "magnetic-component-assembler", amount = 1 } },
  allow_productivity = true,
  enabled = false
}

local magnetic_casing_item = {
  type = "item",
  name = "magnetic-casing",
  icon = constants.magnetic_casing_path,
  icon_size = constants.magnetic_casing_size,
  subgroup = "subterranio-intermediate",
  order = "a-[magnetic-casing]",
  inventory_move_sound = item_sounds.resource_inventory_move,
  pick_sound = item_sounds.resource_inventory_pickup,
  drop_sound = item_sounds.resource_inventory_move,
  stack_size = 100,
  weight = 5 * kg
}

local magnetic_casing_recipe = {
  type = "recipe",
  name = "magnetic-casing",
  enabled = false,
  energy_required = 1,
  ingredients =
  {
    { type = "item", name = "copper-plate",       amount = 1 },
    { type = "item", name = "cobalt-plate",       amount = 1 },
    { type = "item", name = "magnetic-shielding", amount = 1 },
  },
  results = { { type = "item", name = "magnetic-casing", amount = 1 } },
  allow_productivity = true,
  surface_conditions = {
    {
      property = "magnetic-field",
      min = 99,
      max = 99
    }
  }
}

local tech = {
  type = "technology",
  name = "magnetic-component-processing",
  icons = {
    {
      icon = constants.magnetic_packaging_path,
      icon_size = constants.magnetic_packaging_size
    }
  },
  icon_size = 256,
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "magnetic-component-assembler"
    },
    {
      type = "unlock-recipe",
      recipe = "magnetic-packaging"
    },
    {
      type = "unlock-recipe",
      recipe = "magnetic-packaging-repair"
    },
    {
      type = "unlock-recipe",
      recipe = "magnetic-casing"
    }
  },
  prerequisites = { "magnetic-shielding", "automation-3" },
  unit =
  {
    count = 1000,
    ingredients =
    {
      { "automation-science-pack",      1 },
      { "logistic-science-pack",        1 },
      { "chemical-science-pack",        1 },
      { "space-science-pack",           1 },
      { "subterranean-science-pack",    1 }, -- TODO: Only if ST Nauvis is present
      { "electromagnetic-science-pack", 1 },
    },
    time = 60
  }
}

local recipe_category = {
  type = "recipe-category",
  name = "magnetic-components"
}

data:extend {
  item1,
  item2,
  item3,
  entity,
  recipe1,
  recipe2,
  recipe3,
  magnetic_casing_item,
  magnetic_casing_recipe,
  tech,
  recipe_category
}
