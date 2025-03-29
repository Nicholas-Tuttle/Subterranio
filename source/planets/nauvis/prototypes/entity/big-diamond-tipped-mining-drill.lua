local building = table.deepcopy(data.raw["mining-drill"]["big-mining-drill"])
building.name = "big-diamond-tipped-mining-drill"
building.mining_speed = building.mining_speed * 4
building.minable.result = "big-diamond-tipped-mining-drill"

local recipe = {
    type = "recipe",
    name = "big-diamond-tipped-mining-drill",
    enabled = false,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "big-mining-drill", amount = 1},
        {type = "item", name = "diamond-shard", amount = 10}
    },
    results = {{type = "item", name = "big-diamond-tipped-mining-drill", amount = 1}}
}

local item = {
    type = "item",
    name = "big-diamond-tipped-mining-drill",
    subgroup = "extraction-machine",
    order = "a[items]-d[big-mining-drill]",
    stack_size = 20,
    icon = "__space-age__/graphics/icons/big-mining-drill.png",
    place_result = "big-diamond-tipped-mining-drill"
}

data:extend{building, recipe, item}
