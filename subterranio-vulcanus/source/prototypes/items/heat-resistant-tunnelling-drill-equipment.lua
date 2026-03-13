local base_constants = require("__subterranio-base__.scripts.constants")

local technology = {
    type = "technology",
    name = "heat-resistant-tunnelling-drill-equipment",
    icon = base_constants.tunnelling_drill_equipment_path,
    icon_size = base_constants.tunnelling_drill_equipment_size,
    effects =
    {
        {
            type = "unlock-space-location",
            space_location = "vulcanus_lava_tubes",
            use_icon_overlay_constant = true
        }
    },
    prerequisites = {
        "tungsten-steel", "metallurgic-science-pack"
    },
    research_trigger =
    {
        type = "craft-item",
        item = "tungsten-plate",
        count = 50
    }
}

data:extend{technology}