local tile = table.deepcopy(data.raw["tile"]["landfill"])
tile.name = "cave-scaffolding"
tile.order = "d[subterrain]-b[cave-scaffolding]"
tile.subgroup = "special-tiles"
tile.minable = {
  mining_time = 0.5,
  result = "cave-scaffolding"
}
tile.is_foundation = true
tile.map_color = { 50, 50, 50 }

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

local tech = {

}

local recipe = {

}

data:extend { tile, item }
