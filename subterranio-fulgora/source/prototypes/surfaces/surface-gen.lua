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
                    ["subway-out-of-map"] = {},
                    ["subway-fulgoran-paving"] = {}
                }
            },
            ["decorative"] = {
                settings = {
                    ["fulgoran-ruin-tiny"] = {},
                    ["fulgoran-gravewort"] = {},
                    ["urchin-cactus"] = {},
                    ["medium-fulgora-rock"] = {},
                    ["small-fulgora-rock"] = {},
                    ["tiny-fulgora-rock"] = {}
                }
            },
            ["entity"] = {
                settings = {
                    ["scrap"] = {},
                    ["fulgoran-ruin-vault"] = {},
                    ["fulgoran-ruin-attractor"] = {},
                    ["fulgoran-ruin-colossal"] = {},
                    ["fulgoran-ruin-huge"] = {},
                    ["fulgoran-ruin-big"] = {},
                    ["fulgoran-ruin-stonehenge"] = {},
                    ["fulgoran-ruin-medium"] = {},
                    ["fulgoran-ruin-small"] = {},
                    ["fulgurite"] = {},
                    ["big-fulgora-rock"] = {}
                }
            }
        }
    }
end

return surface_gen