local technology = {
    type = "technology",
    name = "heat-resistant-tunnelling-drill-equipment",
    icon = "__subterranio-base__/graphics/item/tunnelling-drill-equipment.png",
    icon_size = 512,
    effects =
    {
        {
            type = "unlock-space-location",
            space_location = "vulcanus_lava_tubes",
            use_icon_overlay_constant = true
        }
    },
    prerequisites = {
        "tungsten-steel"
    },
    research_trigger =
    {
        type = "craft-item",
        item = "tungsten-plate",
        count = 50
    }
}

data:extend{technology}