local surface_gen = {}

-- local tiles = {
--     "lowland-brown-blubber",
--     "lowland-olive-blubber",
--     "lowland-olive-blubber-2",
--     "lowland-olive-blubber-3",
--     "lowland-pale-green",
--     "lowland-cream-cauliflower",
--     "lowland-cream-cauliflower-2",
--     "lowland-dead-skin",
--     "lowland-dead-skin-2",
--     "lowland-cream-red",
--     "lowland-red-vein",
--     "lowland-red-vein-2",
--     "lowland-red-vein-3",
--     "lowland-red-vein-4",
--     "lowland-red-vein-dead",
--     "midland-turquoise-bark",
--     "midland-turquoise-bark-2",
--     "midland-cracked-lichen",
--     "midland-cracked-lichen-dull",
--     "midland-cracked-lichen-dark",
--     "midland-yellow-crust",
--     "midland-yellow-crust-2",
--     "midland-yellow-crust-3",
--     "midland-yellow-crust-4",
-- }

local tile_settings = {}
-- for _, value in pairs(tiles) do
--     local tile = table.deepcopy(data.raw["tile"][value])
--     tile.name = "gleban-subterranean-" .. value
--     tile.order = "z[subterrain]-a[gleban-subterranean-floor][gleban-subterranean-" .. value .. "]"
--     tile.autoplace.probability_expression = tile.autoplace.probability_expression ..
--         " * gleban_dirt_noise_expression" ..
--         " * (1 - gleban_deep_water_noise_expression)" ..
--         " - (1000 * gleban_subterranean_impassable_cliffs_ridge_noise_expression)"
--     data:extend {tile}
--     tile_settings[tile.name] = {}
-- end
tile_settings["gleban-cave-wall"] = {}

local tiles = {
    "lowland-olive-blubber",
    "lowland-olive-blubber-2",
    "lowland-olive-blubber-3",
    "lowland-brown-blubber",
    "lowland-pale-green",
    "lowland-cream-cauliflower-2",
    "lowland-cream-cauliflower",
    "lowland-dead-skin",
    "lowland-dead-skin-2",
    "lowland-cream-red",
    "lowland-red-vein",
    "lowland-red-vein-2",
    "lowland-red-vein-3",
    "lowland-red-vein-4",
    "lowland-red-vein-dead",
    "lowland-red-infection",
}

for index, value in ipairs(tiles) do
    local tile = table.deepcopy(data.raw["tile"][value])
    tile.name = "gleban-subterranean-" .. value
    tile.order = "z[subterrain]-a[gleban-subterranean-floor][gleban-subterranean-" .. value .. "]"
    tile.autoplace.probability_expression = "var('gleban_subterranean_" .. value .. "_noise_expression')"
    tile.map_color = {r = math.min((255.0 * (index + 1) / #tiles ), 255), g = 0, b = 0}
    data:extend {tile}
    tile_settings[tile.name] = {}
end

local decoratives_settings = {}
-- local decoratives = {
--     "honeycomb-fungus",
--     "honeycomb-fungus-1x1",
--     "honeycomb-fungus-decayed",
--     "mycelium",
--     "black-sceptre",
--     "pink-phalanges",
--     "pink-lichen-decal",
--     "red-lichen-decal",
--     "green-cup",
--     "brown-cup",
--     "polycephalum-slime",
--     "fuchsia-pita",
--     "wispy-lichen",
--     "curly-roots-orange",
--     "knobbly-roots",
--     "knobbly-roots-orange",
--     "green-bush-mini",
--     "green-croton",
-- }

-- local decoratives_settings = {}
-- for _, value in pairs(decoratives) do
--     local decorative = table.deepcopy(data.raw["optimized-decorative"][value])
--     decorative.name = "gleban-subterranean-" .. value
--     decorative.order = "z[subterrain]-a[gleban-subterranean-floor][gleban-subterranean-" .. value .. "]"
--     local probability_expression = decorative.autoplace and decorative.autoplace.probability_expression .. " - (1000 * gleban_subterranean_impassable_cliffs_ridge_noise_expression)" or 0
--     if (probability_expression ~= nil) then
--         if (decorative.autoplace == nil) then
--             decorative.autoplace = {}
--         end
--         decorative.autoplace.probability_expression = probability_expression
--     end
--     data:extend {decorative}
--     decoratives_settings[decorative.name] = {}
-- end

surface_gen["gleban_biospheres"] = function()
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