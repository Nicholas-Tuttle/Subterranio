local constants = require("scripts.constants")

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

local function create_lava_type(name, fluid_name, color_cool, color_hot, noise_expression, hot_noise_expression)
    local lava_settings = table.deepcopy(data.raw["tile"]["lava"])
    lava_settings.name = "vulcanus-subterranean-" .. name .. "-lava"
    lava_settings.order = "z[subterrain]-a[vulcanus-subterranean-floor][vulcanus-subterranean-" .. name .. "-lava]"
    lava_settings.autoplace.probability_expression = noise_expression
    lava_settings.map_color = color_cool
    lava_settings.fluid = fluid_name
    lava_settings.allowed_neighbors = { "vulcanus-subterranean-" .. name .. "-lava-hot" }
    data:extend {lava_settings}
    tile_settings[lava_settings.name] = {}

    local hot_lava_settings = table.deepcopy(data.raw["tile"]["lava-hot"])
    hot_lava_settings.name = "vulcanus-subterranean-" .. name .. "-lava-hot"
    hot_lava_settings.order = "z[subterrain]-a[vulcanus-subterranean-floor][vulcanus-subterranean-" .. name .. "-lava-hot]"
    hot_lava_settings.autoplace.probability_expression = hot_noise_expression
    hot_lava_settings.map_color = color_hot
    hot_lava_settings.fluid = fluid_name
    hot_lava_settings.allowed_neighbors = { "vulcanus-subterranean-" .. name .. "-lava" }
    data:extend {hot_lava_settings}
    tile_settings[hot_lava_settings.name] = {}
end

create_lava_type("titanium", "titanium-rich-lava", constants.titanium_color, constants.hot_titanium_color, "vulcanus_subterranean_titanium_lava_noise_expression", "vulcanus_subterranean_hot_titanium_lava_noise_expression")
create_lava_type("aluminum", "aluminum-rich-lava", constants.aluminum_color, constants.hot_aluminum_color, "vulcanus_subterranean_aluminum_lava_noise_expression", "vulcanus_subterranean_hot_aluminum_lava_noise_expression")

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
