local base_constants = require("__subterranio-base__.scripts.constants")

local technology = {
    type = "technology",
    name = "heat-resistant-tunnelling-drill-equipment",
    icons = {
        {
            icon = base_constants.tunnelling_drill_equipment_path,
            icon_size = base_constants.tunnelling_drill_equipment_size,
        },
        {
            icon = "__space-age__/graphics/icons/vulcanus.png",
            scale = 0.8,
            icon_size = 64,
            shift = {36, 36}
        }
    },
    effects =
    {
        {
            type = "unlock-space-location",
            space_location = "vulcanus_lava_tubes",
            use_icon_overlay_constant = true
        }
    },
    prerequisites = {
        "tunnelling-drill-equipment", "tungsten-steel", "metallurgic-science-pack"
    },
    research_trigger =
    {
        type = "craft-item",
        item = "tungsten-plate",
        count = 50
    }
}

data:extend { technology }
