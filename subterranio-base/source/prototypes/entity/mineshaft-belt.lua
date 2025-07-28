-- name -> String
-- speed -> Float - speed in items per second
-- underground_belt_ingredient -> String
-- returns -> {object, item, recipe}
local function create_mineshaft_belt_type(prefix, order_postfix, speed, tech, tint)
    local object = table.deepcopy(data.raw["linked-belt"]["linked-belt"])
    object.name = prefix .. "mineshaft-belt"
    object.speed = speed / 480
    object.minable = {mining_time = 0.1, result = prefix .. "mineshaft-belt"}
    object.allow_side_loading = true
    object.belt_animation_set = data.raw["transport-belt"][prefix .. "transport-belt"].belt_animation_set
    
    object.structure.direction_in.sheet.tint = tint
    object.structure.direction_out.sheet.tint = tint
    object.structure.direction_in_side_loading.sheet.tint = tint
    object.structure.direction_out_side_loading.sheet.tint = tint
    object.structure.back_patch.sheet.tint = tint
    object.structure.front_patch.sheet.tint = tint

    local item = {
        type = "item",
        name = prefix .. "mineshaft-belt",
        stack_size = 50,
        hidden = false,
        icons = {{icon = "__base__/graphics/icons/linked-belt.png", tint = tint}},
        place_result = prefix .. "mineshaft-belt",
        subgroup = "belt",
        order = "d[subterranio]-" .. order_postfix,
    }

    local recipe = {
        type = "recipe",
        name = prefix .. "mineshaft-belt",
        enabled = false,
        energy_requirements = 1,
        ingredients = {
            {type = "item", name = prefix .. "underground-belt", amount = 20},
            {type = "item", name = "low-density-structure", amount = 20},
            {type = "item", name = "steel-plate", amount = 50}
        },
        results = {{type = "item", name = prefix .. "mineshaft-belt", amount = 1}}
    }

    -- TODO: Make techs for all of these

    return {object, item, recipe, tech}
end

local base_tech = {
    type = "technology",
    name = "mineshaft-belt",
    icon = subterrain.diamond_image_path,
    icon_size = subterrain.diamond_image_size,
    effects = {
        {
            type = "unlock-recipe",
            recipe = "mineshaft-belt"
        }
    },
    prerequisites = {"subterranean-science-pack", "logistics"},
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

local fast_tech = {
    type = "technology",
    name = "fast-mineshaft-belt",
    icon = subterrain.diamond_image_path,
    icon_size = subterrain.diamond_image_size,
    effects = {
        {
            type = "unlock-recipe",
            recipe = "fast-mineshaft-belt"
        }
    },
    prerequisites = {"subterranean-science-pack", "logistics-2", "mineshaft-belt" },
    unit =
    {
        count = 1000,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "subterranean-science-pack", 1 }
        },
        time = 60
    }
}

local express_tech = {
    type = "technology",
    name = "express-mineshaft-belt",
    icon = subterrain.diamond_image_path,
    icon_size = subterrain.diamond_image_size,
    effects = {
        {
            type = "unlock-recipe",
            recipe = "express-mineshaft-belt"
        }
    },
    prerequisites = {"subterranean-science-pack", "logistics-3", "fast-mineshaft-belt" },
    unit =
    {
        count = 2000,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "subterranean-science-pack", 1 }
        },
        time = 60
    }
}

local turbo_tech = {
    type = "technology",
    name = "turbo-mineshaft-belt",
    icon = subterrain.diamond_image_path,
    icon_size = subterrain.diamond_image_size,
    effects = {
        {
            type = "unlock-recipe",
            recipe = "turbo-mineshaft-belt"
        }
    },
    prerequisites = {"subterranean-science-pack", "turbo-transport-belt", "express-mineshaft-belt" },
    unit =
    {
        count = 5000,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "space-science-pack", 1 },
            { "metallurgic-science-pack", 1 },
            { "subterranean-science-pack", 1 }
        },
        time = 60
    }
}

data:extend(create_mineshaft_belt_type("", "a", 15, base_tech, {0.75, 0.65, 0.15, 1}))
data:extend(create_mineshaft_belt_type("fast-", "b", 30, fast_tech, {0.76, 0.38, 0.30, 1}))
data:extend(create_mineshaft_belt_type("express-", "c", 45, express_tech, {0.30, 0.30, 0.68, 1}))
data:extend(create_mineshaft_belt_type("turbo-", "d", 60, turbo_tech, {0.18, 0.65, 0.16, 1}))
