-- name -> String
-- speed -> Float - speed in items per second
-- underground_belt_ingredient -> String
-- returns -> {objects}
local function create_mineshaft_belt_type(prefix, order_postfix, speed, tech, tint)
    local object_up = table.deepcopy(data.raw["linked-belt"]["linked-belt"])
    object_up.name = prefix .. "mineshaft-belt-up"
    object_up.speed = speed / 480
    object_up.minable = {mining_time = 0.1, result = prefix .. "mineshaft-belt-up"}
    object_up.allow_side_loading = true
    object_up.belt_animation_set = data.raw["transport-belt"][prefix .. "transport-belt"].belt_animation_set

    object_up.structure.direction_in.sheet.tint = tint
    object_up.structure.direction_out.sheet.tint = tint
    object_up.structure.direction_in_side_loading.sheet.tint = tint
    object_up.structure.direction_out_side_loading.sheet.tint = tint
    object_up.structure.back_patch.sheet.tint = tint
    object_up.structure.front_patch.sheet.tint = tint

    local object_down = table.deepcopy(object_up)
    object_down.name = prefix .. "mineshaft-belt-down"
    object_down.minable.result = prefix .. "mineshaft-belt-down"

    local item = {
        type = "item",
        name = prefix .. "mineshaft-belt",
        stack_size = 50,
        hidden = false,
        icons = {
            {icon = "__base__/graphics/icons/linked-belt.png", tint = tint},
        },
        subgroup = "belt",
        order = "d[subterranio]-" .. order_postfix,
    }

    local item_up = {
        type = "item",
        name = prefix .. "mineshaft-belt-up",
        stack_size = 50,
        hidden = false,
        icons = {
            {icon = "__base__/graphics/icons/linked-belt.png", tint = tint},
            {icon = "__base__/graphics/icons/arrows/up-arrow.png", tint = {0, 1, 0, 1.0}, scale = 0.3, shift = {13, -13}},
        },
        place_result = prefix .. "mineshaft-belt-up",
        subgroup = "belt",
        order = "d[subterranio][a]-" .. order_postfix,
    }

    local item_down = {
        type = "item",
        name = prefix .. "mineshaft-belt-down",
        stack_size = 50,
        hidden = false,
        icons = {
            {icon = "__base__/graphics/icons/linked-belt.png", tint = tint},
            {icon = "__base__/graphics/icons/arrows/down-arrow.png", tint = {0, 1, 0, 1.0}, scale = 0.3, shift = {13, -13}}
        },
        place_result = prefix .. "mineshaft-belt-down",
        subgroup = "belt",
        order = "d[subterranio][b]-" .. order_postfix,
    }

    local recipe = {
        type = "recipe",
        name = prefix .. "mineshaft-belt",
        order = "d[subterranio]-" .. order_postfix .. "-[a]",
        enabled = false,
        energy_requirements = 1,
        ingredients = {
            {type = "item", name = prefix .. "underground-belt", amount = 20},
            {type = "item", name = "low-density-structure", amount = 20},
            {type = "item", name = "steel-plate", amount = 50}
        },
        results = {{type = "item", name = prefix .. "mineshaft-belt", amount = 1}}
    }

    local recipe_up = {
        type = "recipe",
        name = prefix .. "mineshaft-belt-up",
        order = "d[subterranio]-" .. order_postfix .. "-[b]",
        enabled = false,
        energy_required = 0.1,
        ingredients = {
            {type = "item", name = prefix .. "mineshaft-belt", amount = 1}
        },
        results = {{type = "item", name = prefix .. "mineshaft-belt-up", amount = 1}}
    }

    local recipe_down = {
        type = "recipe",
        name = prefix .. "mineshaft-belt-down",
        order = "d[subterranio]-" .. order_postfix .. "-[c]",
        enabled = false,
        energy_required = 0.1,
        ingredients = {
            {type = "item", name = prefix .. "mineshaft-belt", amount = 1}
        },
        results = {{type = "item", name = prefix .. "mineshaft-belt-down", amount = 1}}
    }

    local recipe_up_from_down = {
        type = "recipe",
        name = prefix .. "mineshaft-belt-up-from-down",
        order = "d[subterranio]-" .. order_postfix .. "-[d]",
        enabled = false,
        energy_required = 0.1,
        ingredients = {
            {type = "item", name = prefix .. "mineshaft-belt-down", amount = 1}
        },
        results = {{type = "item", name = prefix .. "mineshaft-belt-up", amount = 1}}
    }

    local recipe_down_from_up = {
        type = "recipe",
        name = prefix .. "mineshaft-belt-down-from-up",
        order = "d[subterranio]-" .. order_postfix .. "-[e]",
        enabled = false,
        energy_required = 0.1,
        ingredients = {
            {type = "item", name = prefix .. "mineshaft-belt-up", amount = 1}
        },
        results = {{type = "item", name = prefix .. "mineshaft-belt-down", amount = 1}}
    }

    tech.type = "technology"
    tech.name = prefix .. "mineshaft-belt"
    tech.icons = {{icon = "__base__/graphics/icons/linked-belt.png", tint = tint}}
    tech.effects = {
        {
            type = "unlock-recipe",
            recipe = prefix .. "mineshaft-belt"
        },
        {
            type = "unlock-recipe",
            recipe = prefix .. "mineshaft-belt-up"
        },
        {
            type = "unlock-recipe",
            recipe = prefix .. "mineshaft-belt-down"
        },
        {
            type = "unlock-recipe",
            recipe = prefix .. "mineshaft-belt-up-from-down"
        },
        {
            type = "unlock-recipe",
            recipe = prefix .. "mineshaft-belt-down-from-up"
        }
    }
    tech.unit.time = 60

    return {object_up, object_down, item, item_up, item_down, recipe, recipe_up, recipe_down, recipe_up_from_down, recipe_down_from_up, tech}
end

local base_tint = {0.75, 0.65, 0.15, 1}
local base_tech_params = {
    prerequisites = {"subterranean-science-pack", "logistics"},
    unit =
    {
        count = 250,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "subterranean-science-pack", 1 }
        }
    }
}

local fast_tint = {0.76, 0.38, 0.30, 1}
local fast_tech_params = {
    prerequisites = {"subterranean-science-pack", "logistics-2", "mineshaft-belt" },
    unit =
    {
        count = 1000,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "subterranean-science-pack", 1 }
        }
    }
}

local express_tint = {0.30, 0.30, 0.68, 1}
local express_tech_params = {
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
        }
    }
}

local turbo_tint = {0.18, 0.65, 0.16, 1}
local turbo_tech_params = {
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
        }
    }
}

data:extend(create_mineshaft_belt_type("", "a", 15, base_tech_params, base_tint))
data:extend(create_mineshaft_belt_type("fast-", "b", 30, fast_tech_params, fast_tint))
data:extend(create_mineshaft_belt_type("express-", "c", 45, express_tech_params, express_tint))
data:extend(create_mineshaft_belt_type("turbo-", "d", 60, turbo_tech_params, turbo_tint))
