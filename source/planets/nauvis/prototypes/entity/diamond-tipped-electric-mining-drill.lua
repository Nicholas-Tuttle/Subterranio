local building = table.deepcopy(data.raw["mining-drill"]["electric-mining-drill"])
building.name = "diamond-tipped-electric-mining-drill"
building.mining_speed = building.mining_speed * 4
building.minable.result = "diamond-tipped-electric-mining-drill"

local recipe = {
    type = "recipe",
    name = "diamond-tipped-electric-mining-drill",
    enabled = false,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "electric-mining-drill", amount = 1},
        {type = "item", name = "diamond-shard", amount = 10}
    },
    results = {{type = "item", name = "diamond-tipped-electric-mining-drill", amount = 1}}
}

local item = {
    type = "item",
    name = "diamond-tipped-electric-mining-drill",
    stack_size = 50,
    icon = "__base__/graphics/icons/electric-mining-drill.png",
    place_result = "diamond-tipped-electric-mining-drill",
    subgroup = "extraction-machine",
    order = "a[items]-ba[electric-mining-drill]",
}

data:extend{building, recipe, item}
