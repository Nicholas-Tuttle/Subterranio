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

local decoratives = {
    "sand-dune-decal",
    "vulcanus-dune-decal",
    "vulcanus-sand-decal",
    "crater-small",
    "crater-large",
    "small-volcanic-rock",
    "medium-volcanic-rock",
    "tiny-volcanic-rock",
    "tiny-rock-cluster",
    "small-sulfur-rock",
    "tiny-sulfur-rock",
    "sulfur-rock-cluster",
    "waves-decal",
    "black-sceptre",
    "grey-cracked-mud-decal",
    "light-mud-decal",
    "cracked-mud-decal"
}

for _, value in pairs(decoratives) do
    local decorative = table.deepcopy(data.raw["optimized-decorative"][value])
    decorative.name = "cave-" .. value
    decorative.order = "z[subterrain]-a[cave-floor][cave-" .. value .. "]"
    local probability_expression = decorative.autoplace and decorative.autoplace.probability_expression .. " - (1000 * subterranean_impassable_cliffs_ridge_noise_expression)" or 0
    if (probability_expression ~= nil) then
        if (decorative.autoplace == nil) then
            decorative.autoplace = {}
        end
        decorative.autoplace.probability_expression = probability_expression
    end
    data:extend {decorative}
end
