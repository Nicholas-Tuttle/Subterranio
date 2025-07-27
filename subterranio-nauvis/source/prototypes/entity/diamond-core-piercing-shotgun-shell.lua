local constants = require("constants")

local projectile = table.deepcopy(data.raw["projectile"]["piercing-shotgun-pellet"])
projectile.name = "diamond-core-piercing-shotgun-pellet"
projectile.action.action_delivery.target_effects.damage.amount = projectile.action.action_delivery.target_effects.damage.amount * 5

local item = table.deepcopy(data.raw["ammo"]["piercing-shotgun-shell"])
item.name = "diamond-core-piercing-shotgun-shell"
item.ammo_type.action[2].action_delivery.projectile = "diamond-core-piercing-shotgun-pellet"
item.order = "b[shotgun]-ba[diamond-tipped-piercing]"

item.pictures = nil
item.icon = nil
item.icons = {{icon = "__base__/graphics/icons/piercing-shotgun-shell.png", tint = constants.diamond_tint_icon_color}}

local recipe = {
    type = "recipe",
    name = "diamond-core-piercing-shotgun-shell",
    enabled = false,
    energy_requirements = 16,
    ingredients = {
        {type = "item", name = "piercing-shotgun-shell", amount = 1},
        {type = "item", name = "diamond-shard", amount = 4}
    },
    results = {{type = "item", name = "diamond-core-piercing-shotgun-shell", amount = 1}}
}

data:extend{projectile, item, recipe}
