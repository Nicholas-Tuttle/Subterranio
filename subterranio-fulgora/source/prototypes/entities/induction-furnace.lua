local constants = require("scripts.constants")

local entity = table.deepcopy(data.raw["furnace"]["electric-furnace"])
entity.name = "induction-furnace"
entity.icons = {{icon = entity.icon, tint = constants.fulgoran_subway_tint}}
entity.icon = nil
entity.minable.result = "induction-furnace"
entity.module_slots = 6
entity.crafting_speed = entity.crafting_speed * 5
entity.effect_receiver = { base_effect = { productivity = 0.5 }}
entity.collision_box = {{-1.7, -1.7}, {1.7, 1.7}}
entity.selection_box = {{-2.0, -2.0}, {2.0, 2.0}}

entity.graphics_set.animation.layers[1].tint = constants.fulgoran_subway_tint
entity.graphics_set.animation.layers[1].scale = entity.graphics_set.animation.layers[1].scale * 4 / 3

local recipe = {
    type = "recipe",
    name = "induction-furnace",
    enabled = false,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "electric-furnace", amount = 2},
        {type = "item", name = "iron-plate", amount = 10}
    },
    results = {{type = "item", name = "induction-furnace", amount = 1}}
}

local item = {
    type = "item",
    name = "induction-furnace",
    stack_size = 50,
    icons = {{icon = "__base__/graphics/icons/electric-furnace.png", tint = constants.fulgoran_subway_tint}},
    place_result = "induction-furnace",
    subgroup = "smelting-machine",
    order = "a[items]-ba[electric-furnace]",
}

local tech = {
    type = "technology",
    name = "induction-furnace",
    icons = {
        {icon = "__base__/graphics/icons/electric-furnace.png", icon_size = 64, tint = constants.fulgoran_subway_tint},
        constants.diamond_tech_overlay_icon
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "induction-furnace"
        }
    },
    prerequisites = {"electromagnets", "magnetic-shielding"},
    unit =
    {
        count = 1,
        ingredients =
        {
            { "automation-science-pack", 1 },
        },
        time = 60
    }
}

data:extend{entity, recipe, item, tech}
