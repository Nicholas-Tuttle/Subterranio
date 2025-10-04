local constants = require("scripts.constants")

local technology = {
    type = "technology",
    name = "electrostatic-tunnelling-drill-equipment",
    icon = "__subterranio-base__/graphics/item/tunnelling-drill-equipment.png",
    icon_size = constants.diamond_image_size,
    effects =
    {
        {
            type = "unlock-space-location",
            space_location = "fulgoran_subway",
            use_icon_overlay_constant = true
        }
    },
    prerequisites = {
        "electrostatic-shielding"
    },
    unit =
    {
        count = 100,
        ingredients =
        {
            { "automation-science-pack",        1 },
            { "logistic-science-pack",          1 },
            { "chemical-science-pack",          1 },
            { "electromagnetic-science-pack",   1 }
        },
        time = 30
    }
}

data:extend{technology}