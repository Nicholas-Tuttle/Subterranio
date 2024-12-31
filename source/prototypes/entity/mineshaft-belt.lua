-- name -> String
-- speed -> Float
-- underground_belt_ingredient -> String
-- returns -> {object, item, recipe}
local function create_mineshaft_belt_type(prefix, speed)
    local object = table.deepcopy(data.raw["linked-belt"]["linked-belt"])
    object.name = prefix .. "mineshaft-belt"
    object.speed = speed
    object.minable = {mining_time = 0.1, result = prefix .. "mineshaft-belt"}

    local item = {
        type = "item",
        name = prefix .. "mineshaft-belt",
        stack_size = 50,
        hidden = false,
        icon = "__base__/graphics/icons/linked-belt.png",
        place_result = prefix .. "mineshaft-belt"
    }

    local recipe = {
        type = "recipe",
        name = prefix .. "mineshaft-belt",
        enabled = true,
        energy_requirements = 1,
        ingredients = {
            {type = "item", name = prefix .. "underground-belt", amount = 10},
            {type = "item", name = "low-density-structure", amount = 5},
            {type = "item", name = "steel-plate", amount = 10},
            {type = "item", name = "concrete", amount = 10}
        },
        results = {{type = "item", name = prefix .. "mineshaft-belt", amount = 1}}
    }

    return {object, item, recipe}
end

data:extend(create_mineshaft_belt_type("", 0.03125))
data:extend(create_mineshaft_belt_type("fast-", 0.0625))
data:extend(create_mineshaft_belt_type("express-", 0.09375))
data:extend(create_mineshaft_belt_type("turbo-", 0.125))