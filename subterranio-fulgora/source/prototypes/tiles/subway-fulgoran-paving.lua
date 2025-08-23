local tile = table.deepcopy(data.raw["tile"]["fulgoran-paving"])
tile.name = "subway-fulgoran-paving"
tile.order = "z[fulgoran_subway]-a[subway-floor][subway-fulgoran-paving]"
tile.autoplace.probability_expression = "subway_floor_noise_expression"
data:extend {tile}

local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")

local out_of_map = {
    type = "tile",
    name = "subway-out-of-map",
    order = "d[fulgoran_subway]-b[subway-out-of-map]",
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
    autoplace = {
        order = "a[landscape]-c[rock]-b[big]",
        probability_expression = [[
            1 - 1000 * subway_floor_noise_expression
        ]]
    }
}

table.insert(out_of_map_tile_type_names, "cave-wall")

data:extend{out_of_map}