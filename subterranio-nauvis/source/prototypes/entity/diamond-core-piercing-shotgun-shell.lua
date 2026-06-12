local constants = require("constants")

local projectile = table.deepcopy(data.raw["projectile"]["piercing-shotgun-pellet"])
projectile.name = "diamond-core-piercing-shotgun-pellet"
projectile.action = {
    type = "direct",
    action_delivery =
    {
        type = "instant",
        target_effects =
        {
            {
                type = "damage",
                damage = { amount = 40, type = "physical" }
            }
        }
    }
}

local item = table.deepcopy(data.raw["ammo"]["piercing-shotgun-shell"])
item.name = "diamond-core-piercing-shotgun-shell"
item.order = "b[shotgun]-ba[diamond-tipped-piercing]"
item.pictures = nil
item.icon = nil
item.icons = { { icon = "__base__/graphics/icons/piercing-shotgun-shell.png", tint = constants.diamond_tint_icon_color } }
item.ammo_type = {
    action =
    {
        {
            type = "direct",
            action_delivery =
            {
                type = "instant",
                source_effects =
                {
                    {
                        type = "create-explosion",
                        entity_name = "explosion-gunshot"
                    }
                }
            }
        },
        {
            type = "direct",
            repeat_count = 16,
            action_delivery =
            {
                type = "projectile",
                projectile = "diamond-core-piercing-shotgun-pellet",
                starting_speed = 1,
                starting_speed_deviation = 0.1,
                direction_deviation = 0.3,
                range_deviation = 0.3,
                max_range = 15
            }
        }
    }
}

local recipe = {
    type = "recipe",
    name = "diamond-core-piercing-shotgun-shell",
    enabled = false,
    energy_required = 16,
    ingredients = {
        { type = "item", name = "piercing-shotgun-shell", amount = 1 },
        { type = "item", name = "diamond-shard",          amount = 4 }
    },
    results = { { type = "item", name = "diamond-core-piercing-shotgun-shell", amount = 1 } }
}

local tech = {
    type = "technology",
    name = "diamond-core-piercing-shotgun-shell",
    icons = {
        { icon = "__base__/graphics/icons/piercing-shotgun-shell.png", tint = constants.diamond_tint_icon_color },
        constants.diamond_tech_overlay_icon
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "diamond-core-piercing-shotgun-shell"
        }

    },
    prerequisites = { "subterranean-science-pack", "military-4" },
    unit =
    {
        count = 1000,
        ingredients =
        {
            { "automation-science-pack",   1 },
            { "logistic-science-pack",     1 },
            { "military-science-pack",     1 },
            { "chemical-science-pack",     1 },
            { "utility-science-pack",      1 },
            { "subterranean-science-pack", 1 }
        },
        time = 60
    }
}

data:extend { projectile, item, recipe, tech }
