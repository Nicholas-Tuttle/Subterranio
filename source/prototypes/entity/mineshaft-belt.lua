local mineshaft_belt_object = table.deepcopy(data.raw["linked-belt"]["linked-belt"])
mineshaft_belt_object.name = "mineshaft-belt"

local mineshaft_belt_item = {
    type = "item",
    name = "mineshaft-belt",
    stack_size = 1,
    icon = "__base__/graphics/icons/linked-belt.png",
    place_result = "mineshaft-belt"
}

local mineshaft_belt_recipe = {
    type = "recipe",
    name = "mineshaft-belt",
    enabled = true,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "low-density-structure", amount = 5},
        {type = "item", name = "steel-plate", amount = 10},
        {type = "item", name = "concrete", amount = 10}
    },
    results = {{type = "item", name = "mineshaft-belt", amount = 1}}
}

data:extend{mineshaft_belt_object, mineshaft_belt_item, mineshaft_belt_recipe}