local building = table.deepcopy(data.raw["assembling-machine"]["crusher"])
building.name = "diamond-tipped-crusher"
building.crafting_speed = building.crafting_speed * 4
building.minable.result = "diamond-tipped-crusher"

local recipe = {
    type = "recipe",
    name = "diamond-tipped-crusher",
    enabled = false,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "crusher", amount = 1},
        {type = "item", name = "diamond-shard", amount = 10}
    },
    results = {{type = "item", name = "diamond-tipped-crusher", amount = 1}}
}

local item = {
    type = "item",
    name = "diamond-tipped-crusher",
    stack_size = 10,
    icon = "__space-age__/graphics/icons/crusher.png",
    place_result = "diamond-tipped-crusher",
    subgroup = "space-platform",
    order = "ea[crusher]",
}

data:extend{building, recipe, item}
