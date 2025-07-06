local item = table.deepcopy(data.raw["ammo"]["uranium-rounds-magazine"])
item.name = "diamond-core-uranium-rounds-magazine"
item.ammo_type.action.action_delivery.target_effects[2].damage.amount = item.ammo_type.action.action_delivery.target_effects[2].damage.amount * 2.5
item.order = "a[basic-clips]-ca[diamond-tipped-uranium-rounds-magazine]"

local constants = require("constants")

item.pictures.layers[1].tint = constants.diamond_tint_color
item.pictures.layers[1].tint_as_overlay = constants.diamond_tint_as_overlay

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

data:extend{item, recipe}
