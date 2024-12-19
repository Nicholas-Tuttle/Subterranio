local surface_gen = {}

surface_gen["cave"] = function()
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
                }
            },
            ["decorative"] = {
                settings = {
                    -- nauvis decoratives
                    ["v-red-pita"] = {},
                    ["sand-dune-decal"] = {},
                    -- end of nauvis
                    ["vulcanus-dune-decal"] = {},
                    ["vulcanus-sand-decal"] = {},
                    ["crater-small"] = {},
                    ["crater-large"] = {},
                    ["pumice-relief-decal"] = {},
                    ["small-volcanic-rock"] = {},
                    ["medium-volcanic-rock"] = {},
                    ["tiny-volcanic-rock"] = {},
                    ["tiny-rock-cluster"] = {},
                    ["small-sulfur-rock"] = {},
                    ["tiny-sulfur-rock"] = {},
                    ["sulfur-rock-cluster"] = {},
                    ["waves-decal"] = {},

                    ["yellow-lettuce-lichen-1x1"] = {},
                    ["yellow-lettuce-lichen-3x3"] = {},
                    ["yellow-lettuce-lichen-6x6"] = {},
                    ["yellow-lettuce-lichen-cups-1x1"] = {},
                    ["yellow-lettuce-lichen-cups-3x3"] = {},
                    ["yellow-lettuce-lichen-cups-6x6"] = {},
                    ["honeycomb-fungus"] = {},
                    ["honeycomb-fungus-1x1"] = {},
                    ["honeycomb-fungus-decayed"] = {},
                    ["split-gill-1x1"] = {},
                    ["split-gill-2x2"] = {},
                    ["split-gill-red-1x1"] = {},
                    ["split-gill-red-2x2"] = {},
                    ["veins"] = {},
                    ["veins-small"] = {},
                    ["mycelium"] = {},
                    ["coral-water"] = {},
                    ["coral-land"] = {},
                    ["black-sceptre"] = {},
                    ["pink-phalanges"] = {},
                    ["pink-lichen-decal"] = {},
                    ["brown-cup"] = {},
                    ["blood-grape"] = {},
                    ["blood-grape-vibrant"] = {},
                    ["brambles"] = {},
                    ["polycephalum-slime"] = {},
                    ["polycephalum-balloon"] = {},
                    ["fuchsia-pita"] = {},
                    ["wispy-lichen"] = {},
                    ["grey-cracked-mud-decal"] = {},
                    ["barnacles-decal"] = {},
                    ["nerve-roots-dense"] = {},
                    ["nerve-roots-sparse"] = {},
                    --shared
                    ["light-mud-decal"] = {},
                    ["cracked-mud-decal"] = {},
                    ["red-desert-bush"] = {},
                    ["white-desert-bush"] = {},
                    ["red-pita"] = {},
                    ["green-bush-mini"] = {},
                    ["green-croton"] = {},
                    ["green-pita"] = {},
                    ["green-pita-mini"] = {},
                    ["lichen-decal"] = {},
                    ["shroom-decal"] = {},
                }
            }
        }
    }
end

return surface_gen