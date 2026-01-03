local surface_gen = {}

local tiles = {
    "volcanic-soil-dark",
    "volcanic-soil-light",
    "volcanic-ash-soil",
    "volcanic-ash-flats",
    "volcanic-ash-light",
    "volcanic-ash-dark",
    "volcanic-folds",
    "volcanic-folds-flat",
    "volcanic-folds-warm",
    "volcanic-cracks",
    "volcanic-cracks-warm",
    "volcanic-cracks-hot",
    "lava",
    "lava-hot"
}

local tile_settings = {}
for _, value in pairs(tiles) do
    local tile = table.deepcopy(data.raw["tile"][value])
    tile.name = "vulcanus-subterranean-" .. value
    tile.order = "z[subterrain]-a[vulcanus-subterranean-floor][vulcanus-subterranean-" .. value .. "]"
    tile.autoplace.probability_expression = tile.autoplace.probability_expression .. " - (1000 * vulcanus_subterranean_impassable_cliffs_ridge_noise_expression)"
    data:extend {tile}
    tile_settings[tile.name] = {}
end
tile_settings["vulcanus-cave-wall"] = {}

local decoratives = {
    "small-volcanic-rock",
    "medium-volcanic-rock",
    "tiny-volcanic-rock"
}

local decoratives_settings = {}
for _, value in pairs(decoratives) do
    local decorative = table.deepcopy(data.raw["optimized-decorative"][value])
    decorative.name = "vulcanus-subterranean-" .. value
    decorative.order = "z[subterrain]-a[vulcanus-subterranean-floor][vulcanus-subterranean-" .. value .. "]"
    local probability_expression = decorative.autoplace and decorative.autoplace.probability_expression .. " - (1000 * vulcanus_subterranean_impassable_cliffs_ridge_noise_expression)" or 0
    if (probability_expression ~= nil) then
        if (decorative.autoplace == nil) then
            decorative.autoplace = {}
        end
        decorative.autoplace.probability_expression = probability_expression
    end
    data:extend {decorative}
    decoratives_settings[decorative.name] = {}
end

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
        autoplace_settings = {
            ["tile"] = {
                settings = tile_settings
            },
            ["decorative"] = {
                settings = decoratives_settings
            },
            ["entity"] = {
                settings = {
                }
            }
        },
    }
end

return surface_gen
