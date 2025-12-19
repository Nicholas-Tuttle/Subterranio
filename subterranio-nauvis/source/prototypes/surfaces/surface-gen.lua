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
                    ["cave-sand-dune-decal"] = {},
                    ["cave-vulcanus-dune-decal"] = {},
                    ["cave-vulcanus-sand-decal"] = {},
                    ["cave-crater-small"] = {},
                    ["cave-crater-large"] = {},
                    ["cave-small-volcanic-rock"] = {},
                    ["cave-medium-volcanic-rock"] = {},
                    ["cave-tiny-volcanic-rock"] = {},
                    ["cave-tiny-rock-cluster"] = {},
                    ["cave-small-sulfur-rock"] = {},
                    ["cave-tiny-sulfur-rock"] = {},
                    ["cave-sulfur-rock-cluster"] = {},
                    ["cave-waves-decal"] = {},
                    ["cave-black-sceptre"] = {},
                    ["cave-grey-cracked-mud-decal"] = {},
                    ["cave-light-mud-decal"] = {},
                    ["cave-cracked-mud-decal"] = {},
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

surface_gen["subterrain_level_2"] = function()
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
                    ["cave-volcanic-ash-dark"] = {},
                    ["cave-volcanic-folds-warm"] = {},
                    ["cave-volcanic-cracks"] = {},
                    ["cave-volcanic-cracks-warm"] = {},
                    ["cave-volcanic-cracks-hot"] = {},
                    ["cave-volcanic-smooth-stone-warm"] = {},
                    ["cave-volcanic-ash-cracks"] = {},
                    ["cave-wall"] = {}
                }
            },
            ["decorative"] = {
                settings = {
                    ["cave-vulcanus-dune-decal"] = {},
                    ["cave-vulcanus-sand-decal"] = {},
                    ["cave-crater-small"] = {},
                    ["cave-crater-large"] = {},
                    ["cave-small-volcanic-rock"] = {},
                    ["cave-medium-volcanic-rock"] = {},
                    ["cave-small-sulfur-rock"] = {},
                    ["cave-sulfur-rock-cluster"] = {},
                }
            },
            ["entity"] = {
                settings = {
                    ["diamond-ore"] = {},
                    ["subterranean-stone"] = {},
                    ["subterranean-iron-ore"] = {},
                    ["subterranean-copper-ore"] = {},
                    ["huge-subterranean-rock"] = {},
                    ["big-subterranean-rock"] = {},
                }
            }
        }
    }
end

return surface_gen
