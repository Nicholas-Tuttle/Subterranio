local item_sounds = require("__base__.prototypes.item_sounds")

local refrigerator = {
    type = "container",
    name = "refrigerator",
    icon = "__subterranio__/graphics/entity/refrigerator.png",
    icon_size = 512,
    inventory_size = 1,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.5, results = {{type = "item", name = "refrigerator", amount = 1}}},
    -- collision_box = {{-1.9, -1.9}, {1.9, 1.9}},
    collision_box = nil,
    selection_box = {{-2, -2}, {2, 2}},
    scale_entity_info_icon = true,
    collision_mask = {layers = {["item"] = true, ["object"] = true, ["player"] = true}},
    picture = {
        filename = "__subterranio__/graphics/entity/refrigerator.png",
        width = 512,
        height = 512,
        scale = 0.25
    }
}

local item = {
    type = "item",
    name = "refrigerator",
    icon = "__subterranio__/graphics/entity/refrigerator.png",
    icon_size = 512,
    subgroup = "raw-resource",
    order = "h[refrigerator]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 100,
    weight = 5*kg
}

local recipe = {
    type = "recipe",
    name = "refrigerator",
    enabled = false,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "low-density-structure", amount = 5},
        {type = "item", name = "insulation", amount = 10},
        {type = "item", name = "copper-wire", amount = 10},
        {type = "item", name = "plastic-bar", amount = 10}
    },
    results = {{type = "item", name = "refrigerator", amount = 1}}
}

local technology = {
    type = "technology",
    name = "refrigerator",
    icon = "__subterranio__/graphics/entity/refrigerator.png",
    icon_size = 512,
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "refrigerator"
        }
    },
    prerequisites = {"low-density-structure", "plastics"},
    research_trigger =
    {
      type = "mine-item",
      item = "sponge",
      count = 10
    }
}

data:extend{refrigerator, item, recipe, technology}