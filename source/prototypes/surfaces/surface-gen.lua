local surface_gen = {}

-- Things to use
-- Decoratives:
--      Black Sceptre (tube-like white stalagmites)
--      Calcite Stain
--      Rock Decal
--      Pebbles (black)s
--      Large/Huge Cold/Warm Cracks
--      Large Volcanic Stone
--      Cracked Mud Decal
--      Dark Mud Decal
--      Grey cracked mud decal
--      Light Mud Decal
--      Nuclear Ground patch
--      Tiny/Small/Medium Sand/Sulfur/Volcanic Rock
-- Tiles:
--      (Hot) Lava
--      Valcanic Cracks (Hot/Warm)
--      Volcanic Folds (Warm)
--      Volcanic Jagged Ground
--      Volcanic Pumice Stones
--      Volcanic Ash Cracks

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
        },
        autoplace_settings = {
            ["tile"] = {
                settings = {
                    --nauvis tiles
                    ["volcanic-soil-dark"] = {},
                    ["volcanic-soil-light"] = {},
                    ["volcanic-ash-soil"] = {},
                    --end of nauvis tiles
                    ["volcanic-ash-flats"] = {},
                    ["volcanic-ash-light"] = {},
                    ["volcanic-ash-dark"] = {},
                    ["volcanic-cracks"] = {},
                    ["volcanic-cracks-warm"] = {},
                    ["volcanic-folds"] = {},
                    ["volcanic-folds-flat"] = {},
                    --["lava"] = {},
                    --["lava-hot"] = {},
                    ["volcanic-folds-warm"] = {},
                    ["volcanic-pumice-stones"] = {},
                    ["volcanic-cracks-hot"] = {},
                    ["volcanic-jagged-ground"] = {},
                    ["volcanic-smooth-stone"] = {},
                    ["volcanic-smooth-stone-warm"] = {},
                    ["volcanic-ash-cracks"] = {},
                }
            },
            ["decorative"] = {
                settings = {
                    -- nauvis decoratives
                    ["sand-dune-decal"] = {},
                    -- end of nauvis
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
                    --shared
                    ["light-mud-decal"] = {},
                    ["cracked-mud-decal"] = {},
                }
            },
            ["entity"] = {
                settings = {
                    ["huge-subterranean-rock"] = {},
                    ["big-subterranean-rock"] = {},
                    ["crater-cliff"] = {},
                    ["vulcanus-chimney"] = {},
                    ["vulcanus-chimney-faded"] = {},
                    ["vulcanus-chimney-cold"] = {},
                    ["vulcanus-chimney-short"] = {},
                    ["vulcanus-chimney-truncated"] = {},
                }
            }
        }
    }
end

return surface_gen