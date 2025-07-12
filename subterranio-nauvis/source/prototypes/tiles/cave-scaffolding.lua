local tile_trigger_effects = require("__base__/prototypes/tile/tile-trigger-effects")
local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")
local base_sounds = require("__base__/prototypes/entity/sounds")
local base_tile_sounds = require("__base__/prototypes/tile/tile-sounds")

local function tile_variations_template(high_res_picture, high_res_transition_mask, options)
  local function main_variation(size_)
    local y_ = ((size_ == 1) and 0) or ((size_ == 2) and 128) or ((size_ == 4) and 320) or 640
    local ret =
    {
      picture = high_res_picture,
      count = (options[size_] and options[size_].weights) and #options[size_].weights or 16,
      size = size_,
      y = y_,
      line_length = (size_ == 8) and 8 or 16,
      scale = 0.5
    }

    if options[size_] then
      for k, v in pairs(options[size_]) do
        ret[k] = v
      end
    end

    return ret
  end

  local result =
  {
    main =
    {
      main_variation(1),
      main_variation(2),
      main_variation(4)
    }
  }

  if (options.max_size == 8) then
    table.insert(result.main, main_variation(8))
  end

  if options.empty_transitions then
    result.empty_transitions = true
  else
    result.transition =
    {
      spritesheet = high_res_transition_mask,
      layout =
      {
        scale = 0.5,
        count = (options and options.mask_variations) or 8,
        double_side_count = 0,
        u_transition_count = 1,
        o_transition_count = 1,
        u_transition_line_length = 1,
        o_transition_line_length = 2,
        outer_corner_x = 576,
        side_x = 1152,
        u_transition_x = 1728,
        o_transition_x = 2304,
        mask = { y_offset = 0 }
      }
    }
  end
  return result

end

local tile = {
    type = "tile",
    name = "cave-scaffolding",
    order = "d[subterrain]-b[cave-scaffolding]",
    subgroup = "special-tiles",
    minable = {
        mining_time = 0.5,
        result = "cave-scaffolding"
    },
    mined_sound = base_sounds.deconstruct_bricks(0.8),
    is_foundation = true,
    collision_mask = tile_collision_masks.ground(),
    layer = 22,
    searchable = false,

    transitions = data.raw["tile"]["landfill"].transitions,
    transitions_between_transitions = data.raw["tile"]["landfill"].transitions_between_transitions,
    trigger_effect = tile_trigger_effects.landfill_trigger_effect(),

    build_sound = base_tile_sounds.building.landfill,
    map_color={50, 50, 50},
    scorch_mark_color = {r = 0.329, g = 0.242*2, b = 0.177, a = 1.000},

    variants = tile_variations_template(
      "__base__/graphics/terrain/dry-dirt.png", "__base__/graphics/terrain/masks/transition-1.png",
      {
        max_size = 4,
        [1] = { weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
        [2] = { probability = 1, weights = {0.070, 0.070, 0.025, 0.070, 0.070, 0.070, 0.007, 0.025, 0.070, 0.050, 0.015, 0.026, 0.030, 0.005, 0.070, 0.027 }, },
        [4] = { probability = 1.00, weights = {0.070, 0.070, 0.070, 0.070, 0.070, 0.070, 0.015, 0.070, 0.070, 0.070, 0.015, 0.050, 0.070, 0.070, 0.065, 0.070 }, },
        --[8] = { probability = 1.00, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} }
      }
    ),
}

local item_sounds = require("__base__.prototypes.item_sounds")

local item = {
    type = "item",
    name = "cave-scaffolding",
    icon = "__space-age__/graphics/icons/artificial-yumako-soil.png",
    subgroup = "terrain",
    order = "z[subterrain]-a[cave-scaffolding]",
    inventory_move_sound = item_sounds.landfill_inventory_move,
    pick_sound = item_sounds.landfill_inventory_pickup,
    drop_sound = item_sounds.landfill_inventory_move,
    stack_size = 100,
    default_import_location = "nauvis",
    place_as_tile =
    {
      result = "cave-scaffolding",
      condition_size = 1,
      condition = {layers={}},
      tile_condition = {"cave-wall"}
    }
}

local tech = {

}

local recipe = {

}

data:extend{tile, item}