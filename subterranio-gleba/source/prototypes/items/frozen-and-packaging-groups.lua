local group = {
    type = "item-group",
    name = "packaging-and-frozen",
    order = "ca",
    order_in_recipe = "0",
    icons = {
        { icon = "__base__/graphics/icons/iron-chest.png",         icon_size = 64 },
        { icon = "__core__/graphics/icons/alerts/frozen-icon.png", icon_size = 64, scale = 0.3, shift = { -13, 13 } },
        { icon = "__base__/graphics/icons/signal/signal-fire.png", icon_size = 64, scale = 0.3, shift = { 13, 13 }, tint = { r = 255, g = 0, b = 0 } },
    },
}

local subgroup = {
    type = "item-subgroup",
    name = "packaging-and-frozen",
    group = "packaging-and-frozen",
    order = "0000",
}

data:extend({ group, subgroup })
