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
  icon = constants.diamond_image_path,
  icon_size = constants.diamond_image_size,
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
  icon = constants.diamond_image_path,
  icon_size = constants.diamond_image_size,
  subgroup = "subterranio-intermediate",
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
  ingredients = { { type = "item", name = "iron-plate", amount = 1 } },
  results = { { type = "item", name = "magnetic-component-assembler", amount = 1 } },
  allow_productivity = true,
  enabled = false
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
    }
  },
  prerequisites = { "magnetic-shielding" },
  research_trigger =
  {
    type = "craft-item",
    item = "military-scrap",
    count = 50
  }
}

data:extend { item1, item2, item3, entity, recipe1, recipe2, recipe3, tech }
