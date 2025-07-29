local surface_gen = {}

surface_gen["subterrain"] = function()
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
            ["subterranean-coal-autoplace-control"] = {},
            ["subterranean-stone-autoplace-control"] = {},
            ["subterranean-iron-ore-autoplace-control"] = {},
            ["subterranean-copper-ore-autoplace-control"] = {},
            ["subterranean-uranium-ore-autoplace-control"] = {},
            ["diamond-ore-autoplace-control"] = {}
        },
        autoplace_settings = {
            ["tile"] = {
                settings = {
                    ["cave-volcanic-soil-dark"] = {},
                    ["cave-volcanic-soil-light"] = {},
                    ["cave-volcanic-ash-soil"] = {},
                    ["cave-volcanic-ash-flats"] = {},
                    ["cave-volcanic-ash-light"] = {},
                    ["cave-volcanic-ash-dark"] = {},
                    ["cave-volcanic-folds"] = {},
                    ["cave-volcanic-folds-flat"] = {},
                    ["cave-volcanic-folds-warm"] = {},
                    ["cave-volcanic-cracks"] = {},
                    ["cave-volcanic-cracks-warm"] = {},
                    ["cave-volcanic-cracks-hot"] = {},
                    ["cave-volcanic-pumice-stones"] = {},
                    ["cave-volcanic-jagged-ground"] = {},
                    ["cave-volcanic-smooth-stone"] = {},
                    ["cave-volcanic-smooth-stone-warm"] = {},
                    ["cave-volcanic-ash-cracks"] = {},
                    ["cave-wall"] = {}
                }
            },
            ["decorative"] = {
                settings = {
                    ["sand-dune-decal"] = {},
                    ["vulcanus-dune-decal"] = {},
                    ["vulcanus-sand-decal"] = {},
                    ["crater-small"] = {},
                    ["crater-large"] = {},
                    ["small-volcanic-rock"] = {},
                    ["medium-volcanic-rock"] = {},
                    ["tiny-volcanic-rock"] = {},
                    ["tiny-rock-cluster"] = {},
                    ["small-sulfur-rock"] = {},
                    ["tiny-sulfur-rock"] = {},
                    ["sulfur-rock-cluster"] = {},
                    ["waves-decal"] = {},
                    ["black-sceptre"] = {},
                    ["grey-cracked-mud-decal"] = {},
                    ["light-mud-decal"] = {},
                    ["cracked-mud-decal"] = {},
                }
            },
            ["entity"] = {
                settings = {
                    ["diamond-ore"] = {},
                    ["subterranean-coal"] = {},
                    ["subterranean-stone"] = {},
                    ["subterranean-iron-ore"] = {},
                    ["subterranean-copper-ore"] = {},
                    ["subterranean-uranium-ore"] = {},
                    ["huge-subterranean-rock"] = {},
                    ["big-subterranean-rock"] = {},
                }
            }
        }
    }
end

return surface_gen
