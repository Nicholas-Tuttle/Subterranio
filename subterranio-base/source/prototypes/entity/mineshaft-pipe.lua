local item = {
    type = "item",
    name = "mineshaft-pipe",
    stack_size = 50,
    hidden = false,
    icon = "__base__/graphics/entity/pipe/pipe-cross.png",
    icon_size = 128,
    subgroup = "energy-pipe-distribution",
    order = "a[pipe]-ba[pipe-to-ground]",
}

local object_down = table.deepcopy(data.raw["pipe-to-ground"]["pipe-to-ground"])
object_down.name = "mineshaft-pipe-down"
object_down.type = "storage-tank"
object_down.minable = {mining_time = 0.1, result = "mineshaft-pipe-down"}
object_down.fluid_box = {
    volume = 100,
    pipe_covers = nil,
    collision_box = {{-0.45, -0.45}, {0.45, 0.45}},
    selection_box = {{-1, -1}, {1, 1}},
    pipe_connections = {
        {
            direction = defines.direction.north, 
            position = {0, -0.1}
        },
        {
            direction = defines.direction.south, 
            position = {0, 0.1}
        },
        {
            direction = defines.direction.east, 
            position = {0.1, 0}
        },
        {
            direction = defines.direction.west, 
            position = {-0.1, 0}
        },
        {
            connection_type = "linked",
            linked_connection_id = 0,
        },
    },
    max_pipeline_extent = 100000
}
object_down.window_bounding_box = {{0, 0}, {0, 0}}
object_down.flow_length_in_ticks = 360
object_down.icon = "__base__/graphics/entity/pipe/pipe-cross.png"
object_down.icon_size = 128
object_down.pictures = {
    picture = {
        north = {
            filename = "__base__/graphics/entity/pipe/pipe-cross.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5
        },
        east = {
            filename = "__base__/graphics/entity/pipe/pipe-cross.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5
        },
        south = {
            filename = "__base__/graphics/entity/pipe/pipe-cross.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5
        },
        west = {
            filename = "__base__/graphics/entity/pipe/pipe-cross.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            scale = 0.5
        }
    }
}

local item_down = table.deepcopy(item)
item_down.name = "mineshaft-pipe-down"
item_down.place_result = "mineshaft-pipe-down"
item_down.icon = nil
item_down.icons = {
    {icon = "__base__/graphics/entity/pipe/pipe-cross.png", icon_size = 128},
    {icon = "__base__/graphics/icons/arrows/down-arrow.png", tint = {0, 1, 0, 1.0}, scale = 0.3, shift = {13, -13}}
}
item_down.order = "a[pipe]-ba[pipe-to-ground]-b"

local object_up = table.deepcopy(object_down)
object_up.name = "mineshaft-pipe-up"
object_up.minable.result = "mineshaft-pipe-up"

local item_up = table.deepcopy(item)
item_up.name = "mineshaft-pipe-up"
item_up.place_result = "mineshaft-pipe-up"
item_up.icon = nil
item_up.icons = {
    {icon = "__base__/graphics/entity/pipe/pipe-cross.png", icon_size = 128},
    {icon = "__base__/graphics/icons/arrows/up-arrow.png", tint = {0, 1, 0, 1.0}, scale = 0.3, shift = {13, -13}}
}
item_up.order = "a[pipe]-ba[pipe-to-ground]-a"

local recipe = {
    type = "recipe",
    name = "mineshaft-pipe",
    enabled = false,
    energy_required = 1,
    ingredients = {
        {type = "item", name = "pipe-to-ground", amount = 10},
        {type = "item", name = "low-density-structure", amount = 20},
        {type = "item", name = "steel-plate", amount = 50},
        {type = "item", name = "pump", amount = 1}
    },
    results = {{type = "item", name = "mineshaft-pipe", amount = 1}},
    order = "a[pipe]-ba[pipe-to-ground]"
}

local recipe_up = {
    type = "recipe",
    name = "mineshaft-pipe-up",
    enabled = false,
    energy_required = 0.1,
    ingredients = {
        {type = "item", name = "mineshaft-pipe", amount = 1}
    },
    results = {{type = "item", name = "mineshaft-pipe-up", amount = 1}},
    order = "a[pipe]-ba[pipe-to-ground]-a"
}

local recipe_down = {
    type = "recipe",
    name = "mineshaft-pipe-down",
    enabled = false,
    energy_required = 0.1,
    ingredients = {
        {type = "item", name = "mineshaft-pipe", amount = 1}
    },
    results = {{type = "item", name = "mineshaft-pipe-down", amount = 1}},
    order = "a[pipe]-ba[pipe-to-ground]-b"
}

local recipe_up_from_down = {
    type = "recipe",
    name = "mineshaft-pipe-up-from-down",
    enabled = false,
    energy_required = 0.1,
    ingredients = {
        {type = "item", name = "mineshaft-pipe-down", amount = 1}
    },
    results = {{type = "item", name = "mineshaft-pipe-up", amount = 1}},
    order = "a[pipe]-ba[pipe-to-ground]-c"
}

local recipe_down_from_up = {
    type = "recipe",
    name = "mineshaft-pipe-down-from-up",
    enabled = false,
    energy_required = 0.1,
    ingredients = {
        {type = "item", name = "mineshaft-pipe-up", amount = 1}
    },
    results = {{type = "item", name = "mineshaft-pipe-down", amount = 1}},
    order = "a[pipe]-ba[pipe-to-ground]-d"
}

local tech = {
    type = "technology",
    name = "mineshaft-pipe",
    icons = {
        {icon = "__base__/graphics/entity/pipe/pipe-cross.png", icon_size = 128},
        {icon = "__base__/graphics/icons/arrows/up-arrow.png", tint = {0, 1, 0, 1.0}, scale = 0.3, shift = {13, -13}},
        {icon = "__base__/graphics/icons/arrows/down-arrow.png", tint = {0, 1, 0, 1.0}, scale = 0.3, shift = {13, 13}}
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "mineshaft-pipe"
        },
        {
            type = "unlock-recipe",
            recipe = "mineshaft-pipe-up"
        },
        {
            type = "unlock-recipe",
            recipe = "mineshaft-pipe-down"
        },
        {
            type = "unlock-recipe",
            recipe = "mineshaft-pipe-up-from-down"
        },
        {
            type = "unlock-recipe",
            recipe = "mineshaft-pipe-down-from-up"
        }
    },
    prerequisites = {"steam-power"},
    unit =
    {
        count = 250,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 }
        },
        time = 60
    }
}

data:extend{item, item_down, item_up, object_down, object_up, recipe, recipe_up, recipe_down, recipe_up_from_down, recipe_down_from_up, tech}