local constants = require("scripts.constants")
local graphics_tinter = require("__subterranio-base__.utilities.graphics-tinter")

local entity = table.deepcopy(data.raw["ammo-turret"]["gun-turret"])
entity.name = "autocannon-turret"
entity.icons = { { icon = entity.icon, tint = constants.vulcanus_lava_tubes_tint } }
entity.icon = nil
entity.minable.result = "autocannon-turret"
entity.max_health = 2000
entity.rotation_speed = 0.005
entity.attack_parameters.ammo_category = "autocannon-shell"
entity.attack_parameters.cooldown = 30
entity.attack_parameters.health_penalty = 0
entity.attack_parameters.range = 54
entity = graphics_tinter.tint(entity, constants.vulcanus_lava_tubes_tint)

local item = {
    type = "item",
    name = "autocannon-turret",
    stack_size = 10,
    icons = { { icon = "__base__/graphics/icons/gun-turret.png", tint = constants.vulcanus_lava_tubes_tint } },
    place_result = "autocannon-turret",
    subgroup = "defensive-structure",
    order = "b[turret]-c[autocannon-turret]",
}

local ammo_item = {
    type = "ammo",
    name = "autocannon-shell",
    stack_size = 200,
    icons = { { icon = "__base__/graphics/icons/piercing-rounds-magazine.png", tint = constants.vulcanus_lava_tubes_tint } },
    ammo_type =
    {
        category = "autocannon-shell",
        target_type = "direction",
        action =
        {
            type = "direct",
            action_delivery =
            {
                type = "projectile",
                projectile = "autocannon-shell-projectile",
                starting_speed = 8,
                direction_deviation = 0,
                range_deviation = 0,
                max_range = 54
            }
        }
    },
    ammo_category = "autocannon-shell",
    magazine_size = 5,
    subgroup = "ammo",
    order = "a[basic-clips]-c[autocannon-shell]",
}

local ammo_projectile = table.deepcopy(data.raw["projectile"]["cannon-projectile"])
ammo_projectile.name = "autocannon-shell-projectile"
ammo_projectile.piercing_damage = 5000
ammo_projectile.action.action_delivery.target_effects[1].damage.amount = 5000

local recipe = {
    type = "recipe",
    name = "autocannon-turret",
    icons = { { icon = "__base__/graphics/icons/gun-turret.png", tint = constants.vulcanus_lava_tubes_tint } },
    subgroup = "defensive-structure",
    order = "b[turret]-c[autocannon-turret]",
    enabled = false,
    energy_required = 10,
    ingredients = {
        { type = "item", name = "steel-plate",          amount = 50 },
        { type = "item", name = "titanium-plate",       amount = 30 },
        { type = "item", name = "aluminum-plate",      amount = 30 },
        { type = "item", name = "processing-unit",     amount = 20 },
        { type = "item", name = "electric-engine-unit", amount = 10 },
    },
    results = {
        { type = "item", name = "autocannon-turret", amount = 1 },
    }
}

local ammo_recipe = {
    type = "recipe",
    name = "autocannon-shell",
    icons = { { icon = "__base__/graphics/icons/piercing-rounds-magazine.png", tint = constants.vulcanus_lava_tubes_tint } },
    subgroup = "ammo",
    order = "a[basic-clips]-c[autocannon-shell]",
    enabled = false,
    energy_required = 5,
    ingredients = {
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "titanium-plate", amount = 1 },
        { type = "item", name = "aluminum-plate", amount = 1 },
        { type = "item", name = "explosives", amount = 1 },
    },
    results = {
        { type = "item", name = "autocannon-shell", amount = 1 },
    }
}

local technology = {
    type = "technology",
    name = "autocannon-turret",
    icons = { { icon = entity.icons[1].icon, tint = constants.vulcanus_lava_tubes_tint } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "autocannon-turret"
        },
        {
            type = "unlock-recipe",
            recipe = "autocannon-shell"
        },
    },
    prerequisites = { "titanium-cutting", "aluminum-cutting" },
    unit =
    {
        count = 2000,
        ingredients = {
            { "automation-science-pack",  1 },
            { "logistic-science-pack",    1 },
            { "military-science-pack",    1 },
            { "chemical-science-pack",    1 },
            { "space-science-pack",       1 },
            { "metallurgic-science-pack", 1 },
            { "propulsion-science-pack",  1 },
        },
        time = 60
    }
}

local ammo_category = table.deepcopy(data.raw["ammo-category"]["bullet"])
ammo_category.name = "autocannon-shell"
ammo_category.icons = { { icon = ammo_category.icon, tint = constants.vulcanus_lava_tubes_tint } }
ammo_category.icon = nil

data:extend({ entity, item, recipe, ammo_recipe, ammo_item, ammo_projectile, technology, ammo_category })
