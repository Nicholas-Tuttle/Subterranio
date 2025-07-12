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
        },
        autoplace_settings = {
            ["tile"] = {
                settings = {
                    -- ["volcanic-soil-dark"] = {},
                    -- ["volcanic-soil-light"] = {},
                    -- ["volcanic-ash-soil"] = {},
                    -- ["volcanic-ash-flats"] = {},
                    -- ["volcanic-ash-light"] = {},
                    -- ["volcanic-ash-dark"] = {},
                    -- ["volcanic-folds"] = {},
                    -- ["volcanic-folds-flat"] = {},
                    -- ["volcanic-folds-warm"] = {},
                    -- ["volcanic-cracks"] = {},
                    -- ["volcanic-cracks-warm"] = {},
                    -- ["volcanic-cracks-hot"] = {},
                    -- ["volcanic-pumice-stones"] = {},
                    -- ["volcanic-jagged-ground"] = {},
                    -- ["volcanic-smooth-stone"] = {},
                    -- ["volcanic-smooth-stone-warm"] = {},
                    -- ["volcanic-ash-cracks"] = {},
                    ["cave-floor"] = {},
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

-- on_chunk_generated(event { 
--     area :: BoundingBox
--     position :: ChunkPosition
--     surface :: LuaSurface
--     name :: defines.events
--     tick :: uint
-- })
-- set_tiles(tiles, correct_tiles?, remove_colliding_entities?, remove_colliding_decoratives?, raise_event?, player?, undo_index?) 