local constants = require("constants")

local building = table.deepcopy(data.raw["assembling-machine"]["crusher"])
building.name = "diamond-tipped-crusher"
building.crafting_speed = building.crafting_speed * 4
building.minable.result = "diamond-tipped-crusher"
building.icon = nil
building.icons = {{icon = "__space-age__/graphics/icons/crusher.png", tint = constants.diamond_tint_icon_color}}

building.graphics_set.animation.north.layers[1].tint = constants.diamond_tint_color
building.graphics_set.animation.east.layers[1].tint = constants.diamond_tint_color
building.graphics_set.animation.south.layers[1].tint = constants.diamond_tint_color
building.graphics_set.animation.west.layers[1].tint = constants.diamond_tint_color

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
    icons = {{icon = "__space-age__/graphics/icons/crusher.png", tint = constants.diamond_tint_icon_color}},
    place_result = "diamond-tipped-crusher",
    subgroup = "space-platform",
    order = "ea[crusher]",
}

local tech = {
    type = "technology",
    name = "diamond-tipped-crusher",
    icons = {
        {icon = "__space-age__/graphics/icons/crusher.png", tint = constants.diamond_tint_icon_color},
        constants.diamond_tech_overlay_icon
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "diamond-tipped-crusher"
        }
    },
    prerequisites = { "space-platform", "subterranean-science-pack", "space-science-pack" },
    unit =
    {
        count = 500,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "space-science-pack", 1 },
            { "subterranean-science-pack", 1 }
        },
        time = 60
    }
}

data:extend{building, recipe, item, tech}
