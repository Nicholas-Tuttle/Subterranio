local constants = require("constants")
require("prototypes.surfaces.impassable-cliff-walls-noise-expressions")

local function create_subterranean_ore(name, autoplace_richness_multiplier, min_patch_size, max_patch_size, seed)
    local resource = table.deepcopy(data.raw["resource"][name])
    resource.name = "subterranean-" .. resource.name
    resource.localised_name = {"", "[entity=" .. name .. "]", {"entity-name." .. name}}
    resource.autoplace = {
        probability_expression = "subterranean_" .. string.gsub(name, "-", "_") .. "_noise_expression(x, y)",
        richness_expression = autoplace_richness_multiplier .. " * (sqrt(x * x + y * y) + 2)",
        has_starting_area_placement = false,
        control = "subterranean_" .. name .. "_autoplace_control",
        order = "c"
    }
    resource.hidden_in_factoriopedia = true

    data:extend{
        resource,
        {
            type = "autoplace-control",
            name = "subterranean_" .. name .. "_autoplace_control",
            localised_name = {"", "[entity=" .. name .. "]", {"entity-name." .. name}},
            richness = true,
            order = "a-f",
            category = "resource"
        },
        {
            type = "noise-function",
            name = "subterranean_" .. string.gsub(name, "-", "_") .. "_caverns_spot_noise_expression",
            expression = [[
                subterranean_impassable_cliffs_caverns_spot_noise(x, y, seed, min_patch_size, max_patch_size)
            ]],
            local_expressions = {
                min_patch_size = min_patch_size,
                max_patch_size = max_patch_size,
                seed = seed
            },
            parameters = {"x", "y"}
        },
        {
            type = "noise-function",
            name = "subterranean_" .. string.gsub(name, "-", "_") .. "_caverns_id_noise_expression",
            expression = [[
                subterranean_impassable_cliffs_caverns_id(x, y, seed)
            ]],
            local_expressions = {
                seed = seed
            },
            parameters = {"x", "y"}
        },
        {
            type = "noise-function",
            name = "subterranean_" .. string.gsub(name, "-", "_") .. "_noise_expression",
            expression = [[
                subterranean_impassable_cliffs_caverns_spot_noise(x, y, seed, min_patch_size, max_patch_size)
            ]],
            local_expressions = {
                min_patch_size = min_patch_size,
                max_patch_size = max_patch_size,
                seed = seed
            },
            parameters = {"x", "y"}
        }
    }
end

create_subterranean_ore("coal", 7, constants.coal_ore_min_patch_size, constants.coal_ore_max_patch_size, constants.coal_ore_patch_seed)
create_subterranean_ore("stone", 10, constants.stone_ore_min_patch_size, constants.stone_ore_max_patch_size, constants.stone_ore_patch_seed)
create_subterranean_ore("iron-ore", 5, constants.iron_ore_min_patch_size, constants.iron_ore_max_patch_size, constants.iron_ore_patch_seed)
create_subterranean_ore("copper-ore", 5, constants.copper_ore_min_patch_size, constants.copper_ore_max_patch_size, constants.copper_ore_patch_seed)
create_subterranean_ore("uranium-ore", 5, constants.uranium_ore_min_patch_size, constants.uranium_ore_max_patch_size, constants.uranium_ore_patch_seed)
