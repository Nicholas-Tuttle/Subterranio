local item_sounds = require("__base__.prototypes.item_sounds")
local constants = require("scripts.constants")
local graphics_tinter = require("__subterranio-base__/utilities/graphics-tinter")

local item = {
    type = "capsule",
    name = "fulgoran-wall-explosives",
    icons = { { icon = "__base__/graphics/icons/cliff-explosives.png", tint = constants.fulgoran_subway_tint } },
    flags = { "hide-from-bonus-gui" },
    capsule_action =
    {
        type = "destroy-cliffs",
        radius = 1.5,
        attack_parameters =
        {
            type = "projectile",
            activation_type = "throw",
            ammo_category = "grenade",
            cooldown = 30,
            projectile_creation_distance = 0.6,
            range = 10,
            ammo_type =
            {
                target_type = "position",
                action =
                {
                    type = "direct",
                    action_delivery =
                    {
                        type = "projectile",
                        projectile = "fulgoran-wall-explosives",
                        starting_speed = 0.3
                    }
                }
            }
        }
    },
    subgroup = "terrain",
    order = "d[fulgoran-cliff-explosives]",
    inventory_move_sound = item_sounds.explosive_inventory_move,
    pick_sound = item_sounds.explosive_inventory_pickup,
    drop_sound = item_sounds.explosive_inventory_move,
    stack_size = 20
}

local projectile = table.deepcopy(data.raw["projectile"]["cliff-explosives"])
projectile.name = "fulgoran-wall-explosives"
projectile = graphics_tinter.tint(projectile, constants.fulgoran_subway_tint)

local recipe = {
    type = "recipe",
    name = "fulgoran-wall-explosives",
    enabled = false,
    energy_required = 8,
    ingredients =
    {
        { type = "item", name = "cliff-explosives", amount = 1 },
        { type = "item", name = "boron-powder",     amount = 1 }
    },
    results = { { type = "item", name = "fulgoran-wall-explosives", amount = 1 } }
}

local tech = {
    type = "technology",
    name = "fulgoran-wall-explosives",
    icons = { { icon = "__base__/graphics/technology/cliff-explosives.png", tint = constants.fulgoran_subway_tint, icon_size = 256 } },
    icon_size = 256,
    prerequisites = { "cliff-explosives" },
    unit =
    {
        count = 200,
        ingredients =
        {
            { "automation-science-pack",      1 },
            { "logistic-science-pack",        1 },
            { "chemical-science-pack",        1 },
            { "space-science-pack",           1 },
            { "metallurgic-science-pack",     1 },
            { "electromagnetic-science-pack", 1 },
            { "induction-science-pack",       1 }
        },
        time = 15
    },
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "fulgoran-wall-explosives"
        },
        {
            type = "cliff-deconstruction-enabled",
            modifier = true
        }
    }
}
tech = graphics_tinter.tint(tech, constants.fulgoran_subway_tint)

data:extend { item, projectile, recipe, tech }
