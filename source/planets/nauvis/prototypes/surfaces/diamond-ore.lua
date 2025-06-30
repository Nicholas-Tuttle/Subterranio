local constants = require("constants")
local resource_autoplace = require("resource-autoplace")
local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

resource_autoplace.initialize_patch_set("diamond-ore", true)

local item = {
    type = "item",
    name = "diamond-ore",
    icon = subterrain.diamond_image_path,
    icon_size = subterrain.diamond_image_size,
    subgroup = "raw-resource",
    order = "g[diamond-ore]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 50,
    weight = 5*kg
}

local diamond_ore_noise_function = {
    type = "noise-function",
    name = "subterranean_diamond_ore_noise_expression",
    expression = [[
        subterranean_impassable_cliffs_caverns_spot_noise(x, y, seed, min_patch_size, max_patch_size)
        + subterranean_starting_area(x, y, 10)
    ]],
    local_expressions = {
        min_patch_size = constants.diamond_ore_min_patch_size,
        max_patch_size = constants.diamond_ore_max_patch_size,
        seed = constants.diamond_ore_patch_seed
    },
    parameters = {"x", "y"}
}

local resource = {
    type = "resource",
    name = "diamond-ore",
    icon = subterrain.diamond_image_path,
    flags = {"placeable-neutral"},
    order = "a-b-f",
    tree_removal_probability = 1.0,
    tree_removal_max_distance = 32 * 32,
    walking_sound = sounds.ore,
    driving_sound = 
    {
      sound =
      {
        filename = "__base__/sound/driving/vehicle-surface-stone.ogg", volume = 0.8,
        advanced_volume_control = {fades = {fade_in = {curve_type = "cosine", from = {control = 0.5, volume_percentage = 0.0}, to = {1.5, 100.0 }}}}
      },
      fade_ticks = 6
    },
    minable =
    {
        mining_particle = "stone-particle",
        mining_time = 5,
        result = "diamond-ore"
    },
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = {
        probability_expression = "subterranean_diamond_ore_noise_expression(x, y)",
        richness_expression = "20 * (sqrt(x * x + y * y) + 2)",
        has_starting_area_placement = true,
        control = "diamond-ore-autoplace-control",
        order = "f"
    },
    stage_counts = {10000, 6330, 3670, 1930, 870, 270, 100, 50},
    stages =
    {
        sheet =
        {
            filename = "__base__/graphics/entity/uranium-ore/uranium-ore.png",
            tint = {0.153, 0.898, 0.9493, 1.0},
            tint_as_overlay = true,
            priority = "extra-high",
            width = 128,
            height = 128,
            frame_count = 8,
            variation_count = 8,
            scale = 0.5
        }
    },
    stages_effect =
    {
        sheet =
        {
            filename = "__base__/graphics/entity/uranium-ore/uranium-ore-glow.png",
            tint = {0.153, 0.898, 0.9493, 1.0},
            priority = "extra-high",
            width = 128,
            height = 128,
            frame_count = 8,
            variation_count = 8,
            scale = 0.5,
            blend_mode = "additive",
            flags = {"light"}
        }
    },
    effect_animation_period = 5,
    effect_animation_period_deviation = 1,
    effect_darkness_multiplier = 3.6,
    min_effect_alpha = 0.2,
    max_effect_alpha = 0.3,
    mining_visualisation_tint = {r = 0.153, g = 0.898, b = 0.949, a = 1.000}, -- #27e5f2
    map_color = {0, 0.7, 0.7}
}

local diamond_ore_autoplace_control = {
    type = "autoplace-control",
    name = "diamond-ore-autoplace-control",
    localised_name = {"", "[entity=diamond-ore]", {"entity-name.diamond-ore"}},
    richness = true,
    order = "a-f",
    category = "resource"
}

local technology = {
    type = "technology",
    name = "diamonds",
    icon = subterrain.diamond_image_path,
    icon_size = subterrain.diamond_image_size,
    effects =
        {
        {
            type = "unlock-recipe",
            recipe = "diamond-shard"
        }
    },
    prerequisites = {"tunnelling-drill-equipment"},
    research_trigger =
    {
      type = "mine-entity",
      entity = "diamond-ore"
    }
}

data:extend({
    item,
    resource,
    diamond_ore_noise_function,
    diamond_ore_autoplace_control,
    technology
})
