local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")

local tile = {
    type = "tile",
    name = "cave-wall",
    order = "d[subterrain]-b[cave-wall]",
    subgroup = "special-tiles",
    collision_mask = tile_collision_masks.out_of_map(),
    layer_group = "zero",
    layer = 0,
    variants =
    {
      main =
      {
        {
          picture = "__base__/graphics/terrain/out-of-map.png",
          count = 1,
          size = 1
        }
      },
      empty_transitions = true
    },
    map_color={10, 10, 10},
    default_cover_tile = "cave-scaffolding",
    autoplace = {
			order = "a[landscape]-c[rock]-b[big]",
			probability_expression = "subterranean_impassable_cliffs_ridge_noise_expression"
		}
}

table.insert(out_of_map_tile_type_names, "cave-wall")

data:extend{tile}