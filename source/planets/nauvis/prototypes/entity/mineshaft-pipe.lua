local object = table.deepcopy(data.raw["pipe-to-ground"]["pipe-to-ground"])
object.name = "mineshaft-pipe-to-ground"
object.type = "storage-tank"
object.minable = {mining_time = 0.1, result = "mineshaft-pipe-to-ground"}
object.fluid_box = {
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
    -- hide_connection_info = true,
    max_pipeline_extent = 100000, -- TODO: What should this be?
}
object.window_bounding_box = {{0, 0}, {0, 0}}
object.flow_length_in_ticks = 360
object.icon = "__base__/graphics/entity/pipe/pipe-cross.png"
object.icon_size = 128
object.pictures = {
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

local item = {
    type = "item",
    name = "mineshaft-pipe-to-ground",
    stack_size = 50,
    hidden = false,
    icon = "__base__/graphics/entity/pipe/pipe-cross.png",
    icon_size = 128,
    place_result = "mineshaft-pipe-to-ground",
    subgroup = "energy-pipe-distribution",
    order = "a[pipe]-ba[pipe-to-ground]",
}

local recipe = {
    type = "recipe",
    name = "mineshaft-pipe-to-ground",
    enabled = false,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "pipe-to-ground", amount = 10},
        {type = "item", name = "low-density-structure", amount = 20},
        {type = "item", name = "steel-plate", amount = 50},
        {type = "item", name = "pump", amount = 1}
    },
    results = {{type = "item", name = "mineshaft-pipe-to-ground", amount = 1}}
}

local tech = {
    type = "technology",
    name = "mineshaft-pipe-to-ground",
    icon = subterrain.diamond_image_path,
    icon_size = subterrain.diamond_image_size,
    effects = {
        {
            type = "unlock-recipe",
            recipe = "mineshaft-pipe-to-ground"
        }
    },
    prerequisites = {"subterranean-science-pack", "steam-power"},
    unit =
    {
        count = 250,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "subterranean-science-pack", 1 }
        },
        time = 60
    }
}

data:extend{item, object, recipe, tech}