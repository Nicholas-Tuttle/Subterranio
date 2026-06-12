local constants = require("constants")

local item = table.deepcopy(data.raw["ammo"]["uranium-rounds-magazine"])
item.name = "diamond-core-uranium-rounds-magazine"
item.order = "a[basic-clips]-ca[diamond-tipped-uranium-rounds-magazine]"
item.pictures = nil
item.icon = nil
item.icons = { { icon = "__base__/graphics/icons/firearm-magazine.png", tint = constants.diamond_tint_icon_color } }

item.ammo_type =
{
    action =
    {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            source_effects =
            {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
            },
            target_effects =
            {
                {
                    type = "create-entity",
                    entity_name = "explosion-hit",
                    offsets = { { 0, 1 } },
                    offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } }
                },
                {
                    type = "damage",
                    damage = { amount = 60, type = "physical" }
                },
                {
                    type = "activate-impact",
                    deliver_category = "bullet"
                }
            }
        }
    }
}

local recipe = {
    type = "recipe",
    name = "diamond-core-uranium-rounds-magazine",
    enabled = false,
    energy_required = 20,
    ingredients = {
        { type = "item", name = "uranium-rounds-magazine", amount = 1 },
        { type = "item", name = "diamond-shard",           amount = 4 }
    },
    results = { { type = "item", name = "diamond-core-uranium-rounds-magazine", amount = 1 } }
}

local tech = {
    type = "technology",
    name = "diamond-core-uranium-rounds-magazine",
    icons = {
        { icon = "__base__/graphics/icons/firearm-magazine.png", tint = constants.diamond_tint_icon_color },
        constants.diamond_tech_overlay_icon
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "diamond-core-uranium-rounds-magazine"
        }

    },
    prerequisites = { "subterranean-science-pack", "uranium-ammo" },
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

data:extend { item, recipe, tech }
