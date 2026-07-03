local constants = require("scripts.constants")
local graphics_tinter = require("__subterranio-base__/utilities/graphics-tinter")

local tile = table.deepcopy(data.raw["tile"]["landfill"])
tile.name = "heat-resistant-cave-scaffolding"
tile.order = "d[subterrain]-e[heat-resistant-cave-scaffolding]"
tile.subgroup = "special-tiles"
tile.minable = {
  mining_time = 0.5,
  result = "heat-resistant-cave-scaffolding"
}
tile.is_foundation = true
tile.map_color = { 30, 30, 30 }
tile = graphics_tinter.tint(tile, constants.vulcanus_lava_tubes_tint)

local item = table.deepcopy(data.raw["item"]["landfill"])
item.name = "heat-resistant-cave-scaffolding"
item.order = "z[subterrain]-d[heat-resistant-cave-scaffolding]"
item.place_as_tile =
{
  result = "heat-resistant-cave-scaffolding",
  condition_size = 1,
  condition = { layers = {} },
  tile_condition = { "vulcanus-cave-wall" }
}
item.enabled = false
item.icon = constants.cave_scaffolding_image_path
item.icon_size = constants.cave_scaffolding_image_size

local tech = {
  type = "technology",
  name = "heat-resistant-cave-scaffolding",
  icon = constants.cave_scaffolding_image_path,
  icon_size = constants.cave_scaffolding_image_size,
  effects = {
    {
      type = "unlock-recipe",
      recipe = "heat-resistant-cave-scaffolding"
    }
  },
  prerequisites = {
    "propulsion-science-pack",
  },
  unit =
  {
    count = 100,
    ingredients =
    {
      { "automation-science-pack",  1 },
      { "logistic-science-pack",    1 },
      { "chemical-science-pack",    1 },
      { "space-science-pack",       1 },
      { "metallurgic-science-pack", 1 },
      { "propulsion-science-pack",  1 }
    },
    time = 60
  }
}

local ingredients = {}
if mods["subterranio-nauvis"] then
  ingredients = {
    { type = "item", name = "cave-scaffolding",   amount = 1 },
    { type = "item", name = "aeroluminite-plate", amount = 1 },
    { type = "item", name = "duratitanite-plate", amount = 1 },
  }
else
  ingredients = {
    { type = "item", name = "landfill",              amount = 1 },
    { type = "item", name = "steel-plate",           amount = 2 },
    { type = "item", name = "low-density-structure", amount = 1 },
    { type = "item", name = "explosives",            amount = 1 },
    { type = "item", name = "heat-pipe",             amount = 1 },
    { type = "item", name = "aeroluminite-plate",    amount = 1 },
    { type = "item", name = "duratitanite-plate",    amount = 1 },
  }
end

local recipe = {
  type = "recipe",
  name = "heat-resistant-cave-scaffolding",
  icon = subterrain.cave_scaffolding_image_path,
  icon_size = subterrain.cave_scaffolding_image_size,
  enabled = false,
  energy_required = 20,
  ingredients = ingredients,
  results = { { type = "item", name = "heat-resistant-cave-scaffolding", amount = 1 } }
}

data:extend { tile, item, tech, recipe }
