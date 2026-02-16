local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")

local constants = require("scripts.constants")
local graphics_tinter = require("__subterranio-base__.utilities.graphics-tinter")

local entity = table.deepcopy(data.raw["thruster"]["thruster"])
entity.name = "heavy-rocket-thruster"
entity.icons = { { icon = entity.icon, tint = constants.vulcanus_lava_tubes_tint } }
entity.minable.result = "heavy-rocket-thruster"
entity.min_performance.effectivity = entity.min_performance.effectivity * 5
entity.max_performance.effectivity = entity.max_performance.effectivity * 5
entity = graphics_tinter.tint(entity, constants.vulcanus_lava_tubes_tint)

local item = {
    type = "item",
    name = "heavy-rocket-thruster",
    icons = { { icon = "__space-age__/graphics/icons/thruster.png", tint = constants.vulcanus_lava_tubes_tint } },
    subgroup = "space-platform",
    order = "fa[thruster]",
    inventory_move_sound = space_age_item_sounds.rocket_inventory_move,
    pick_sound = space_age_item_sounds.rocket_inventory_pickup,
    drop_sound = space_age_item_sounds.rocket_inventory_move,
    place_result = entity.name,
    stack_size = 50,
    weight = 400 * kg
}

local technology = {
    type = "technology",
    name = "heavy-rocket-thruster",
    icons = { { icon = "__space-age__/graphics/technology/space-platform-thruster.png", tint = constants.vulcanus_lava_tubes_tint } },
    prerequisites = { "space-platform-thruster" },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "heavy-rocket-thruster"
        }
    },
    unit = {
        count = 1000,
        ingredients = {
            { "automation-science-pack",  1 },
            { "logistic-science-pack",    1 },
            { "chemical-science-pack",    1 },
            { "space-science-pack",       1 },
            { "metallurgic-science-pack", 1 },
            { "propulsion-science-pack",  1 }
        },
        time = 30
    }
}

local recipe = {
    type = "recipe",
    name = "heavy-rocket-thruster",
    enabled = false,
    energy_required = 600,
    ingredients = {
        { type = "item", name = "thruster",        amount = 3 },
        { type = "item", name = "aluminum-plate",  amount = 20 },
        { type = "item", name = "tungsten-plate",  amount = 10 },
        { type = "item", name = "titanium-plate",  amount = 5 },
        { type = "item", name = "processing-unit", amount = 20 }
    },
    results = {
        { type = "item", name = "heavy-rocket-thruster", amount = 1 },
    }
}

data:extend({ entity, item, technology, recipe })
