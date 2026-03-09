local surface_gen = {}

surface_gen["fulgoran_subway"] = function()
    return {
        terrain_segmentation = 1,
        water = 0,
        property_expression_names = {
            elevation = "cave_surface_elevation",
            temperature = "temperature_basic",
            moisture = "cave_surface_moisture",
            aux = "aux_basic",
            cliffiness = "10",
            cliff_elevation = "cliff_elevation_from_elevation",
        },
        cliff_settings = {
        },
        autoplace_controls = {
        },
        autoplace_settings = {
            ["tile"] = {
                settings = {
                    ["subway-out-of-map"] = {}
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
        }
    }
end

return surface_gen