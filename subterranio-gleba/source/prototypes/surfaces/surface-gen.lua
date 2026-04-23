local surface_tiles_definitions = require("surface-tiles-definitions")
local graphics_tinter = require("__subterranio-base__/utilities/graphics-tinter")

local surface_gen = {}
local tile_settings = {}
local decoratives_settings = {}
local entity_settings = {}

tile_settings["gleban-cave-wall"] = {}

local deep_gleban_water = table.deepcopy(data.raw["tile"]["water"])
deep_gleban_water.name = "gleban-subterranean-deep-water"
deep_gleban_water.order = "z[subterrain]-a[gleban-subterranean-floor][gleban-subterranean-deep-water]"
deep_gleban_water.autoplace.probability_expression = "gleban_deep_water_noise_expression"
deep_gleban_water.fluid = "water"
deep_gleban_water.allowed_neighbors = { "gleban-subterranean-deep-water" }
deep_gleban_water.layer_group = "water"
deep_gleban_water.layer = 0
deep_gleban_water.map_color = { r = 25, g = 0, b = 50 }
data:extend { deep_gleban_water }
tile_settings[deep_gleban_water.name] = {}

-- Tinted "Cracked lichen" as mycellium
-- ID: "midland-cracked-lichen"
local mycellium_hot = table.deepcopy(data.raw.tile["midland-cracked-lichen"])
mycellium_hot.name = "gleban-subterranean-mycellium-hot"
mycellium_hot.order = "z[subterrain]-a[gleban-subterranean-floor][gleban-subterranean-mycellium]"
-- This is not naturally placed
mycellium_hot.autoplace.probability_expression = 0
mycellium_hot.layer_group = "ground-natural"
mycellium_hot.layer = 0
mycellium_hot.map_color = { r = 100, g = 60, b = 20 }
mycellium_hot.tint = { r = 150, g = 100, b = 50 }
data:extend { mycellium_hot }
tile_settings[mycellium_hot.name] = {}

local mycellium_cold = table.deepcopy(mycellium_hot)
mycellium_cold.name = "gleban-subterranean-mycellium-cold"
data:extend { mycellium_cold }
tile_settings[mycellium_cold.name] = {}

for index, value in ipairs(surface_tiles_definitions.randomized_tiles) do
    local tile = table.deepcopy(data.raw["tile"][value])
    tile.name = "gleban-subterranean-" .. value
    tile.order = "z[subterrain]-a[gleban-subterranean-floor][gleban-subterranean-" .. value .. "]"
    tile.autoplace.probability_expression = "var('gleban_subterranean_" .. value .. "_noise_expression')"
    tile.map_color = { r = 50, g = math.min((255.0 * (index + 1) / #surface_tiles_definitions.randomized_tiles), 255), b = 50 }
    data:extend { tile }
    tile_settings[tile.name] = {}
end

for _, value in pairs(surface_tiles_definitions.randomized_decoratives) do
    local decorative = table.deepcopy(data.raw["optimized-decorative"][value])
    decorative.name = "gleban-subterranean-" .. value
    decorative.order = "z[subterrain]-a[gleban-subterranean-floor][gleban-subterranean-" .. value .. "]"
    decorative.autoplace = {}
    decorative.autoplace.probability_expression = "var('gleban_subterranean_" .. value .. "_noise_expression')"
    data:extend { decorative }
    decoratives_settings[decorative.name] = {}
end

for _, value in pairs(surface_tiles_definitions.randomized_entities) do
    local entity = table.deepcopy(data.raw[value.type][value.name])
    entity.name = "gleban-subterranean-" .. value.name
    entity.order = "z[subterrain]-a[gleban-subterranean-floor][gleban-subterranean-" .. value.name .. "]"
    entity.autoplace = {}
    entity.autoplace.probability_expression = "var('gleban_subterranean_" .. value.name .. "_noise_expression')"
    entity.minable.count = 0
    entity.dying_explosion = nil
    entity.remains_when_mined = nil
    entity.collision_mask = nil
    -- Add some glow to all the "leaves"
    for _, variation in ipairs(entity.variations) do
        if variation.leaves.layers == nil then
            local glow = table.deepcopy(variation.leaves)
            glow.draw_as_glow = true
            variation.leaves = {
                layers = {
                    variation.leaves,
                    glow
                }
            }
        end
    end
    entity.stateless_visualisation_variations = {}
    data:extend { entity }
    entity_settings[entity.name] = {}
end

entity_settings["expansion-resistant-fungi"] = {}
entity_settings["cold-resistant-bacteria"] = {}

for biome_name, biome in pairs(surface_tiles_definitions.biomes) do
    for index, tile_name in ipairs(biome.tiles) do
        local tile = table.deepcopy(data.raw["tile"][tile_name])
        tile.name = "gleban-subterranean-" .. tile.name .. "-" .. biome_name
        tile.order = "z[subterrain]-a[gleban-subterranean-floor][gleban-subterranean-" ..
            tile_name .. "-" .. biome_name .. "]"
        tile.autoplace.probability_expression = "var('gleban_subterranean_" ..
            tile_name .. "-" .. biome_name .. "_noise_expression')"
        tile.map_color = biome.map_color(index, #biome.tiles)
        tile.tint = biome.tint
        data:extend { tile }
        tile_settings[tile.name] = {}
    end

    for _, decorative_name in pairs(biome.decoratives) do
        local decorative = table.deepcopy(data.raw["optimized-decorative"][decorative_name])
        decorative.name = "gleban-subterranean-" .. decorative.name .. "-" .. biome_name
        decorative.order = "z[subterrain]-a[gleban-subterranean-floor][gleban-subterranean-" ..
            decorative_name .. "-" .. biome_name .. "]"
        decorative.autoplace = {}
        decorative.autoplace.probability_expression = "var('gleban_subterranean_" ..
            decorative_name .. "-" .. biome_name .. "_noise_expression')"
        data:extend { decorative }
        decoratives_settings[decorative.name] = {}
    end

    for _, entity_info in pairs(biome.entity) do
        local entity = table.deepcopy(data.raw[entity_info.type][entity_info.name])
        entity = graphics_tinter.tint(entity, biome.tint)
        entity.name = "gleban-subterranean-" .. entity.name .. "-" .. biome_name
        entity.order = "z[subterrain]-a[gleban-subterranean-floor][gleban-subterranean-" ..
            entity_info.name .. "-" .. biome_name .. "]"
        entity.autoplace = {}
        entity.autoplace.probability_expression = "var('gleban_subterranean_" ..
            entity_info.name .. "-" .. biome_name .. "_noise_expression')"
        entity.minable.count = 0
        entity.dying_explosion = nil
        entity.remains_when_mined = nil
        entity.collision_mask = nil
        -- Add some glow to all the "leaves"
        for _, variation in ipairs(entity.variations) do
            if variation.leaves.layers == nil then
                local glow = table.deepcopy(variation.leaves)
                glow.draw_as_glow = true
                variation.leaves = {
                    layers = {
                        variation.leaves,
                        glow
                    }
                }
            end
        end
        entity.stateless_visualisation_variations = {}
        data:extend { entity }
        entity_settings[entity.name] = {}
    end
end

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
                settings = entity_settings
            }
        },
    }
end

return surface_gen
