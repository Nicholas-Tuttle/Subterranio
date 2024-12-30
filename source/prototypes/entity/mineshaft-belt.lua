-- name -> String
-- speed -> Float
-- underground_belt_ingredient -> String
-- returns -> {object, item, recipe}
local function create_mineshaft_belt_type(name, speed, underground_belt_ingredient)
    local object = table.deepcopy(data.raw["linked-belt"]["linked-belt"])
    object.name = name
    object.speed = speed

    local item = {
        type = "item",
        name = name,
        stack_size = 50,
        hidden = false,
        icon = "__base__/graphics/icons/linked-belt.png",
        place_result = name
    }

    local recipe = {
        type = "recipe",
        name = name,
        enabled = true,
        energy_requirements = 1,
        ingredients = {
            {type = "item", name = underground_belt_ingredient, amount = 10},
            {type = "item", name = "low-density-structure", amount = 5},
            {type = "item", name = "steel-plate", amount = 10},
            {type = "item", name = "concrete", amount = 10}
        },
        results = {{type = "item", name = name, amount = 1}}
    }

    return {object, item, recipe}
end

data:extend(create_mineshaft_belt_type("mineshaft-belt", 0.03125, "underground-belt"))
data:extend(create_mineshaft_belt_type("fast-mineshaft-belt", 0.0625, "fast-underground-belt"))
data:extend(create_mineshaft_belt_type("express-mineshaft-belt", 0.09375, "express-underground-belt"))
data:extend(create_mineshaft_belt_type("turbo-mineshaft-belt", 0.125, "turbo-underground-belt"))