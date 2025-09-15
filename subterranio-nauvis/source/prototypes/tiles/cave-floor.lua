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
    local decoratives = table.deepcopy(data.raw["optimized-decorative"][value])
    decoratives.name = "cave-" .. value
    decoratives.order = "z[subterrain]-a[cave-floor][cave-" .. value .. "]"
    local probability_expression = decoratives.autoplace and decoratives.autoplace.probability_expression .. " - (1000 * subterranean_impassable_cliffs_ridge_noise_expression)" or 0
    if (probability_expression ~= nil) then
        if (decoratives.autoplace == nil) then
            decoratives.autoplace = {}
        end
        decoratives.autoplace.probability_expression = probability_expression
    end
    data:extend {decoratives}
end
