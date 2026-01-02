local surface_gen = {}

surface_gen["vulcanus_lava_tubes"] = function()
    return {
        terrain_segmentation = 1,
        water = 0,
        property_expression_names = {
        },
        cliff_settings = {
        },
        autoplace_controls = {
        },
        autoplace_settings= {
            ["tile"] = {
                settings = {
                }
            },
            ["decorative"] = {
                settings = {
                }
            },
            ["entity"] = {
                settings = {
                }
            }
        },
    }
end

return surface_gen