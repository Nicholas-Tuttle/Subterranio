local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

local item = {
    type = "item",
    name = "mycellium",
    icon = "__subterranio-gleba__/graphics/entity/mycellium.png",
    icon_size = 64,
    subgroup = "raw-resource",
    order = "h[mycellium]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 50,
    weight = 5 * kg
}

local resource = {
    type = "resource",
    name = "mycellium",
    icon = "__subterranio-gleba__/graphics/entity/mycellium.png",
    icon_size = 64,
    flags = { "placeable-neutral" },
    order = "a-h-a",
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
        mining_time = 1,
        result = "mycellium"
    },
    collision_box = { { -0.1, -0.1 }, { 0.1, 0.1 } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    autoplace = {
        probability_expression = 0,
        order = "h"
    },
    stage_counts = { 100, 50, 10 },
    stages =
    {
        sheet =
        {
            filename = "__subterranio-gleba__/graphics/entity/mycellium-ore.png",
            priority = "extra-high",
            size = 128,
            frame_count = 2,
            variation_count = 3,
            scale = 0.4
        }
    },
    map_color = { 0, 0.7, 0.7 }
}

data:extend { item, resource }