local constants = require("constants")
local resource_autoplace = require("resource-autoplace")
local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

resource_autoplace.initialize_patch_set("diamond-ore", true)

local item = {
    type = "item",
    name = "diamond-ore",
    icon = subterrain.diamond_ore_image_path,
    icon_size = subterrain.diamond_ore_image_size,
    subgroup = "raw-resource",
    order = "g[diamond-ore]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 50,
    weight = 5 * kg
}

local autoplace_control_name = "diamond-ore-autoplace-control"
local autoplace_frequency_setting_name = "var(\"control:" .. autoplace_control_name .. ":frequency\")"
local autoplace_size_setting_name = "var(\"control:" .. autoplace_control_name .. ":size\")"
local autoplace_richness_setting_name = "var(\"control:" .. autoplace_control_name .. ":richness\")"

local diamond_ore_noise_function = {
    type = "noise-function",
    name = "subterranean_diamond_ore_noise_expression",
    expression = [[
        subterranean_impassable_cliffs_caverns_spot_noise(x, y, seed, min_patch_size, max_patch_size, autoplace_size_setting, autoplace_frequency_setting)
        + subterranean_starting_area(x, y, 10 * autoplace_size_setting)
    ]],
    local_expressions = {
        autoplace_size_setting = autoplace_size_setting_name,
        autoplace_frequency_setting = autoplace_frequency_setting_name,
        min_patch_size = constants.diamond_ore_min_patch_size,
        max_patch_size = constants.diamond_ore_max_patch_size,
        seed = constants.diamond_ore_patch_seed
    },
    parameters = { "x", "y" }
}

local resource = {
    type = "resource",
    name = "diamond-ore",
    icon = subterrain.diamond_ore_image_path,
    icon_size = subterrain.diamond_image_size,
    flags = { "placeable-neutral" },
    order = "a-g-a",
    tree_removal_probability = 1.0,
    tree_removal_max_distance = 32 * 32,
    walking_sound = sounds.ore,
    driving_sound =
    {
        sound =
        {
            filename = "__base__/sound/driving/vehicle-surface-stone.ogg",
            volume = 0.8,
            advanced_volume_control = { fades = { fade_in = { curve_type = "cosine", from = { control = 0.5, volume_percentage = 0.0 }, to = { 1.5, 100.0 } } } }
        },
        fade_ticks = 6
    },
    minable =
    {
        mining_particle = "stone-particle",
        mining_time = 5,
        result = "diamond-ore"
    },
    collision_box = { { -0.1, -0.1 }, { 0.1, 0.1 } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    autoplace = {
        probability_expression = "subterranean_diamond_ore_noise_expression(x, y)",
        richness_expression = "20 * (sqrt(x * x + y * y) + 2) * " .. autoplace_richness_setting_name,
        has_starting_area_placement = true,
        control = "diamond-ore-autoplace-control",
        order = "f"
    },
    stage_counts = { 10000, 3000 },
    stages =
    {
        sheet =
        {
            filename = subterrain.diamond_ore_resource_image_path,
            priority = "extra-high",
            size = 64,
            frame_count = 4,
            variation_count = 2,
            scale = 0.6
        }
    },
    map_color = { 0, 0.7, 0.7 }
}

local diamond_ore_autoplace_control = {
    type = "autoplace-control",
    name = autoplace_control_name,
    localised_name = { "", "[entity=diamond-ore]", { "entity-name.diamond-ore" } },
    richness = true,
    order = "a-g-z",
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
    prerequisites = { "tunnelling-drill-equipment" },
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
