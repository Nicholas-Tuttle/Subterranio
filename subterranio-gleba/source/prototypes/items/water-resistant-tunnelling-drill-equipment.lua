local base_constants = require("__subterranio-base__.scripts.constants")

local technology = {
    type = "technology",
    name = "water-resistant-tunnelling-drill-equipment",
    icons = {
        {
            icon = base_constants.tunnelling_drill_equipment_path,
            icon_size = base_constants.tunnelling_drill_equipment_size
        },
        {
            icon = "__space-age__/graphics/icons/gleba.png",
            scale = 0.8,
            icon_size = 64,
            shift = {36, 36}
        }
    },
    effects =
    {
        {
            type = "unlock-space-location",
            space_location = "gleban_biospheres",
            use_icon_overlay_constant = true
        }
    },
    prerequisites = {
        "tunnelling-drill-equipment", "carbon-fiber"
    },
    research_trigger =
    {
        type = "craft-item",
        item = "carbon-fiber",
        count = 50
    }
}

data:extend{technology}