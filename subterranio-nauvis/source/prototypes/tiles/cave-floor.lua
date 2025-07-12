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
    "volcanic-pumice-stones",
    "volcanic-jagged-ground",
    "volcanic-smooth-stone",
    "volcanic-smooth-stone-warm",
    "volcanic-ash-cracks"
}

for _, value in pairs(tiles) do
    local tile = table.deepcopy(data.raw["tile"][value])
    tile.name = "cave-" .. value
    tile.order = "z[subterrain]-a[cave-floor][cave-" .. value .. "]"
    tile.autoplace.probability_expression = tile.autoplace.probability_expression .. " - (1000 * subterranean_impassable_cliffs_ridge_noise_expression)"
    data:extend {tile}
end
