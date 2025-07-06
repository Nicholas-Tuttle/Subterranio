local building = table.deepcopy(data.raw["mining-drill"]["electric-mining-drill"])
building.name = "diamond-tipped-electric-mining-drill"
building.mining_speed = building.mining_speed * 4
building.minable.result = "diamond-tipped-electric-mining-drill"

local constants = require("constants")

building.graphics_set.animation.north.layers[1].tint = constants.diamond_tint_color
building.graphics_set.animation.north.layers[1].tint_as_overlay = constants.diamond_tint_as_overlay
building.graphics_set.animation.east.layers[1].tint = constants.diamond_tint_color
building.graphics_set.animation.east.layers[1].tint_as_overlay = constants.diamond_tint_as_overlay
building.graphics_set.animation.south.layers[1].tint = constants.diamond_tint_color
building.graphics_set.animation.south.layers[1].tint_as_overlay = constants.diamond_tint_as_overlay
building.graphics_set.animation.west.layers[1].tint = constants.diamond_tint_color
building.graphics_set.animation.west.layers[1].tint_as_overlay = constants.diamond_tint_as_overlay

building.graphics_set.animation.north.layers[2].tint = constants.diamond_tint_color
building.graphics_set.animation.north.layers[2].tint_as_overlay = constants.diamond_tint_as_overlay
building.graphics_set.animation.east.layers[2].tint = constants.diamond_tint_color
building.graphics_set.animation.east.layers[2].tint_as_overlay = constants.diamond_tint_as_overlay
building.graphics_set.animation.south.layers[2].tint = constants.diamond_tint_color
building.graphics_set.animation.south.layers[2].tint_as_overlay = constants.diamond_tint_as_overlay
building.graphics_set.animation.west.layers[2].tint = constants.diamond_tint_color
building.graphics_set.animation.west.layers[2].tint_as_overlay = constants.diamond_tint_as_overlay

building.wet_mining_graphics_set.animation.north.layers[1].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.animation.north.layers[1].tint_as_overlay = constants.diamond_tint_as_overlay
building.wet_mining_graphics_set.animation.east.layers[1].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.animation.east.layers[1].tint_as_overlay = constants.diamond_tint_as_overlay
building.wet_mining_graphics_set.animation.south.layers[1].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.animation.south.layers[1].tint_as_overlay = constants.diamond_tint_as_overlay
building.wet_mining_graphics_set.animation.west.layers[1].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.animation.west.layers[1].tint_as_overlay = constants.diamond_tint_as_overlay

building.wet_mining_graphics_set.animation.north.layers[2].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.animation.north.layers[2].tint_as_overlay = constants.diamond_tint_as_overlay
building.wet_mining_graphics_set.animation.east.layers[2].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.animation.east.layers[2].tint_as_overlay = constants.diamond_tint_as_overlay
building.wet_mining_graphics_set.animation.south.layers[2].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.animation.south.layers[2].tint_as_overlay = constants.diamond_tint_as_overlay
building.wet_mining_graphics_set.animation.west.layers[2].tint = constants.diamond_tint_color
building.wet_mining_graphics_set.animation.west.layers[2].tint_as_overlay = constants.diamond_tint_as_overlay

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
