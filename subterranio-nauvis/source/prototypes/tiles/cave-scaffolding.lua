local tile = table.deepcopy(data.raw["tile"]["landfill"])
tile.name = "cave-scaffolding"
tile.order = "d[subterrain]-b[cave-scaffolding]"
tile.subgroup = "special-tiles"
tile.minable = {
  mining_time = 0.5,
  result = "cave-scaffolding"
}
tile.is_foundation = true
tile.map_color = { 30, 30, 30 }

local item = table.deepcopy(data.raw["item"]["landfill"])
item.name = "cave-scaffolding"
item.order = "z[subterrain]-a[cave-scaffolding]"
item.place_as_tile =
{
  result = "cave-scaffolding",
  condition_size = 1,
  condition = { layers = {} },
  tile_condition = { "cave-wall" }
}
item.enabled = false
item.icon = subterrain.cave_scaffolding_image_path
item.icon_size = subterrain.cave_scaffolding_image_size

local tech = {
  type = "technology",
  name = "cave-scaffolding",
  icon = subterrain.cave_scaffolding_image_path,
  icon_size = subterrain.cave_scaffolding_image_size,
  effects = {
    {
      type = "unlock-recipe",
      recipe = "cave-scaffolding"
    }
  },
  prerequisites = {
    "chemical-science-pack",
    "subterranean-science-pack",
    "landfill",
    "steel-processing",
    "low-density-structure",
    "explosives",
    "nuclear-power"
  },
  unit =
  {
    count = 100,
    ingredients =
    {
      { "automation-science-pack",   1 },
      { "logistic-science-pack",     1 },
      { "chemical-science-pack",     1 },
      { "subterranean-science-pack", 1 }
    },
    time = 60
  }
}

local recipe = {
  type = "recipe",
  name = "cave-scaffolding",
  icon = subterrain.cave_scaffolding_image_path,
  icon_size = subterrain.cave_scaffolding_image_size,
  enabled = false,
  energy_required = 20,
  ingredients = {
    { type = "item", name = "landfill",           amount = 1 },
    { type = "item", name = "steel-plate",              amount = 2 },
    { type = "item", name = "low-density-structure", amount = 1 },
    { type = "item", name = "explosives",           amount = 1 },
    { type = "item", name = "heat-pipe",           amount = 1 }
  },
  results = { { type = "item", name = "cave-scaffolding", amount = 1 } }
}

data:extend { tile, item, tech, recipe }
