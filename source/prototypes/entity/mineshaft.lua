local mineshaft = {
    type = "container",
    name = "mineshaft",
    icon = "__subterranio__/graphics/entity/mineshaft.png",
    icon_size = 512,
    inventory_size = 1,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.5, results = {{type = "item", name = "mineshaft", amount = 1}}},
    -- collision_box = {{-1.9, -1.9}, {1.9, 1.9}},
    collision_box = nil,
    selection_box = {{-2, -2}, {2, 2}},
    scale_entity_info_icon = true,
    collision_mask = {layers = {["item"] = true, ["object"] = true, ["player"] = true}},
    picture = {
        filename = "__subterranio__/graphics/entity/mineshaft.png",
        width = 512,
        height = 512,
        scale = 0.25
    }
}

local item = {
    type = "item",
    name = "mineshaft",
    stack_size = 1,
    icon = "__subterranio__/graphics/entity/mineshaft.png",
    icon_size = 512,
    place_result = "mineshaft"
}

local recipe = {
    type = "recipe",
    name = "mineshaft",
    enabled = false,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "low-density-structure", amount = 5},
        {type = "item", name = "steel-plate", amount = 10},
        {type = "item", name = "concrete", amount = 10}
    },
    results = {{type = "item", name = "mineshaft", amount = 1}}
}

local technology = {
    type = "technology",
    name = "mineshaft",
    icon = "__subterranio__/graphics/entity/mineshaft.png",
    icon_size = 512,
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "mineshaft"
        }
    },
    prerequisites = {"low-density-structure"},
    research_trigger =
    {
      type = "craft-item",
      item = "low-density-structure",
      count = 10
    }
}

local custom_input = {
    type = "custom-input",
    key_sequence = "CONTROL + ENTER",
    name = "subterranean-mineshaft-player-enter",
    consuming = "game-only",
    alternative_key_sequence = "",
    controller_key_sequence = "controller-righttrigger + controller-lefttrigger + controller-y",
    controller_alternative_key_sequence = "",
    action = "lua",
}

data:extend{mineshaft, item, recipe, technology, custom_input}
