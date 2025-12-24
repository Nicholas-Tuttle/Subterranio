local constants = require("scripts.constants")

local entity = table.deepcopy(data.raw["asteroid-collector"]["asteroid-collector"])
entity.name = "magnetic-asteroid-collector"
entity.icons = { { icon = entity.icon, tint = constants.fulgoran_subway_tint } }
entity.icon = nil
entity.arm_speed_base = 0.5
entity.arm_speed_quality_scaling = 0.1
entity.arm_angular_speed_cap_base = 0.25
entity.arm_angular_speed_cap_quality_scaling = 0.25

-- entity.graphics_set.below_arm_pictures = nil
-- entity.graphics_set.arm_head_animation = nil
-- entity.graphics_set.arm_head_top_animation = nil
-- entity.graphics_set.arm_link = nil

entity.graphics_set.animation.north.layers[1].tint = constants.fulgoran_subway_tint
entity.graphics_set.animation.east.layers[1].tint = constants.fulgoran_subway_tint
entity.graphics_set.animation.south.layers[1].tint = constants.fulgoran_subway_tint
entity.graphics_set.animation.west.layers[1].tint = constants.fulgoran_subway_tint

local item = {
    type = "item",
    name = "magnetic-asteroid-collector",
    stack_size = 50,
    icons = { { icon = "__space-age__/graphics/icons/asteroid-collector.png", tint = constants.fulgoran_subway_tint } },
    place_result = "magnetic-asteroid-collector",
    subgroup = "space-platform",
    order = "d[magnetic-asteroid-collector]",
}

local recipe = {
    type = "recipe",
    name = "magnetic-asteroid-collector",
    enabled = false,
    energy_requirements = 10,
    ingredients = {
        { type = "item", name = "asteroid-collector", amount = 2 },
        { type = "item", name = "processing-unit",    amount = 10 },
        { type = "item", name = "neodymium-magnet",   amount = 10 },
        { type = "item", name = "holmium-cabling",    amount = 50 },
    },
    results = { { type = "item", name = "magnetic-asteroid-collector", amount = 1 } }
}

local tech = {
    type = "technology",
    name = "magnetic-asteroid-collector",
    icons = {
        { icon = "__space-age__/graphics/icons/asteroid-collector.png", icon_size = 64, tint = constants.fulgoran_subway_tint },
        constants.diamond_tech_overlay_icon
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "magnetic-asteroid-collector"
        }
    },
    prerequisites = { "holmium-cabling", "neodymium-magnets" },
    unit =
    {
        count = 5000,
        ingredients =
        {
            { "automation-science-pack",      1 },
            { "logistic-science-pack",        1 },
            { "chemical-science-pack",        1 },
            { "space-science-pack",           1 },
            -- { "subterranean-science-pack",    1 }, This is in data-updates, only if ST Nauvis is present
            { "electromagnetic-science-pack", 1 },
            { "induction-science-pack",       1 },
        },
        time = 60
    }
}

data:extend { entity, item, recipe, tech }
