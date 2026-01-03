local constants = require("scripts.constants")

data:extend{{
    type = "fluid",
    name = "aluminum-rich-lava",
    subgroup = "fluid",
    default_temperature = 1500,
    max_temperature = 2000,
    heat_capacity = "0.01kJ",
    base_color = constants.aluminum_color,
    flow_color = constants.hot_aluminum_color,
    icons = {
        {
            icon = "__space-age__/graphics/icons/fluid/lava.png",
            tint = constants.aluminum_color
        }
    },
    order = "b[new-fluid]-b[vulcanus]-c[aluminum-rich-lava]",
    auto_barrel = false,
}}
