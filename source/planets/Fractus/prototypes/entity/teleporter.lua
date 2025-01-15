local teleporter = {
    type = "container",
    name = "teleporter",
    icon = "__subterranio__/graphics/entity/teleporter.png",
    icon_size = 512,
    inventory_size = 1,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.5, results = {{type = "item", name = "teleporter", amount = 1}}},
    -- collision_box = {{-1.9, -1.9}, {1.9, 1.9}},
    collision_box = nil,
    selection_box = {{-2, -2}, {2, 2}},
    scale_entity_info_icon = true,
    collision_mask = {layers = {["item"] = true, ["object"] = true, ["player"] = true}},
    picture = {
        filename = "__subterranio__/graphics/entity/teleporter.png",
        width = 512,
        height = 512,
        scale = 0.25
    }
}

local item = {
    type = "item",
    name = "teleporter",
    stack_size = 1,
    icon = "__subterranio__/graphics/entity/teleporter.png",
    icon_size = 512,
    place_result = "teleporter"
}

local recipe = {
    type = "recipe",
    name = "teleporter",
    enabled = false,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "steel-plate", amount = 8},
        {type = "item", name = "copper-wire", amount = 10},
        {type = "item", name = "superconductor", amount = 10},
        {type = "item", name = "supermagnet", amount = 5}
    },
    results = {{type = "item", name = "teleporter", amount = 1}}
}

local technology = {
    type = "technology",
    name = "teleporter",
    icon = "__subterranio__/graphics/entity/teleporter.png",
    icon_size = 512,
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "teleporter"
        }
    },
    prerequisites = {"supermagnet"},
    research_trigger =
    {
      type = "craft-item",
      item = "supermagnet",
      count = 10
    }
}

data:extend{teleporter, item, recipe, technology}