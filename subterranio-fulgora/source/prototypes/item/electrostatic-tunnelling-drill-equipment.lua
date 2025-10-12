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
    research_trigger =
    {
        type = "craft-item",
        item = "electrostatic-shielding",
        count = 50
    }
}

data:extend{technology}