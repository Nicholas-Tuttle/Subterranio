local constants = require("constants")

local item = table.deepcopy(data.raw["ammo"]["uranium-rounds-magazine"])
item.name = "diamond-core-uranium-rounds-magazine"

if (item.ammo_type ~= nil and item.ammo_type.action ~= nil and item.ammo_type.action.action_delivery ~= nil
    and item.ammo_type.action.action_delivery.target_effects ~= nil and #item.ammo_type.action.action_delivery.target_effects >= 2
    and item.ammo_type.action.action_delivery.target_effects[2].damage ~= nil and item.ammo_type.action.action_delivery.target_effects[2].damage.amount ~= nil) then
        item.ammo_type.action.action_delivery.target_effects[2].damage.amount = item.ammo_type.action.action_delivery.target_effects[2].damage.amount * 2.5
else
    item.ammo_type.action.action_delivery.target_effects[2].damage.amount = 60
end

item.order = "a[basic-clips]-ca[diamond-tipped-uranium-rounds-magazine]"

item.pictures = nil
item.icon = nil
item.icons = {{icon = "__base__/graphics/icons/firearm-magazine.png", tint = constants.diamond_tint_icon_color}}

local recipe = {
    type = "recipe",
    name = "diamond-core-uranium-rounds-magazine",
    enabled = false,
    energy_requirements = 20,
    ingredients = {
        {type = "item", name = "uranium-rounds-magazine", amount = 1},
        {type = "item", name = "diamond-shard", amount = 4}
    },
    results = {{type = "item", name = "diamond-core-uranium-rounds-magazine", amount = 1}}
}

local tech = {
    type = "technology",
    name = "diamond-core-uranium-rounds-magazine",
    icons = {
        {icon = "__base__/graphics/icons/firearm-magazine.png", tint = constants.diamond_tint_icon_color},
        constants.diamond_tech_overlay_icon
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "diamond-core-uranium-rounds-magazine"
        }

    },
    prerequisites = {"subterranean-science-pack", "uranium-ammo"},
    unit =
    {
        count = 1000,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "military-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "subterranean-science-pack", 1 }
        },
        time = 60
    }
}

data:extend{item, recipe, tech}
