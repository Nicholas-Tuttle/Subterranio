local constants = require("source.scripts.constants")

local lerp = {
    type = "noise-function",
    name = "subterranean_lerp",
    expression = [[
        ((1 - percent) * min) + (percent * max)
    ]],
    parameters = {"percent", "min", "max"}
}

-- -0.5 - 0.5 noise
local generic_noise = {
    type = "noise-function",
    name = "subterranean_generic_noise",
    expression = [[
        lerp(multioctave_noise{
            x = x,
            y = y,
            persistence = persistence,
            seed0 = map_seed,
            seed1 = 1,
            octaves = 2,
            input_scale = input_scale,
            output_scale = 1
        }, -0.5, 0.5)
    ]],
    parameters = {"x", "y", "persistence", "input_scale"}
}

-- The big blob of open space at 0, 0
local starting_area_generic_noise = {
    type = "noise-function",
    name = "subterranean_starting_area_generic_noise",
    expression = "subterranean_generic_noise(x, y, 0.5, 1/20)",
    parameters = {"x", "y"}
}

local starting_area = {
    type = "noise-function",
    name = "subterranean_starting_area",
    expression = [[
        sqrt(x_perturbed * x_perturbed + y_perturbed * y_perturbed) <= size
    ]],
    local_expressions = {
        perturbation = 40,
        x_perturbed = "x + perturbation * subterranean_starting_area_generic_noise(x, y)",
        y_perturbed = "y + perturbation * subterranean_starting_area_generic_noise(x, y)"
    },
    parameters = {"x", "y", "size"}
}

-- the cavern passageways spanning the whole subteranean surface
local ridge_noise_function_base = {
    type = "noise-function",
    name = "subterranean_impassable_cliffs_ridge_noise",
    expression = [[
        clamp(abs(multioctave_noise{
            x = x,
            y = y,
            persistence = 0.25,
            seed0 = map_seed,
            seed1 = 1,
            octaves = 2,
            input_scale = 1/30,
            output_scale = 1
        }) - 0.2, 0.0, 1.0)
    ]],
    parameters = {"x", "y"}
}

-- The random blobs that spawn new caverns
local caverns_generic_noise = {
    type = "noise-function",
    name = "subterranean_caverns_generic_noise",
    expression = "subterranean_generic_noise(x, y, 0.25, 1/10)",
    parameters = {"x", "y"}
}

local cavern_perturbation = 10

-- Value between 0-1 for each cavern
local caverns_id = {
    type = "noise-function",
    name = "subterranean_impassable_cliffs_caverns_id",
    expression = [[
        abs(voronoi_cell_id{
            x = x_perturbed,
            y = y_perturbed, 
            seed0 = map_seed,
            seed1 = user_seed,
            grid_size = 200,
            distance_type = "euclidean",
            jitter = 1
        })
    ]],
    local_expressions = {
        perturbation = cavern_perturbation,
        x_perturbed = "x + perturbation * subterranean_caverns_generic_noise(x, y)",
        y_perturbed = "y + perturbation * subterranean_caverns_generic_noise(x, y)",
    },
    parameters = {"x", "y", "user_seed"}
}

local caverns_spot_noise = {
    type = "noise-function",
    name = "subterranean_impassable_cliffs_caverns_spot_noise",
    expression = [[
        cavern_central_cones <= cavern_size_relative_to_grid_size
    ]],
    local_expressions = {
        perturbation = cavern_perturbation,
        x_perturbed = "x + perturbation * subterranean_caverns_generic_noise(x, y)",
        y_perturbed = "y + perturbation * subterranean_caverns_generic_noise(x, y)",
        cavern_central_cones = [[
            abs(voronoi_spot_noise{
                x = x_perturbed,
                y = y_perturbed, 
                seed0 = map_seed,
                seed1 = user_seed,
                grid_size = 200,
                distance_type = "euclidean",
                jitter = 1
            })
        ]],
        -- Use the id to only make some of the caverns appear
        cavern_chance = 0.2,
        cavern_size_relative_to_grid_size = [[
            (subterranean_impassable_cliffs_caverns_id(x, y, user_seed) <= cavern_chance) *
            (
                min_cavern_size + 
                lerp(subterranean_impassable_cliffs_caverns_id(x, y, user_seed), 0, cavern_chance) * 
                (max_cavern_size - min_cavern_size)
            )
        ]]
    },
    parameters = {"x", "y", "user_seed", "min_cavern_size", "max_cavern_size"}
}

-- Spawn cliff walls everywhere except the starting area,
-- carvern spots, and pathways between
-- TODO: This has the base ores hard-coded, can this be more functional to add other ore types easier?
local ridge_noise_expression_base = {
    type = "noise-expression",
    name = "subterranean_impassable_cliffs_ridge_noise_expression",
    expression = [[
        subterranean_impassable_cliffs_ridge_noise(x, y)
        * (1 - subterranean_starting_area(x, y, 150))
        * (1 - subterranean_impassable_cliffs_caverns_spot_noise(x, y, diamond_seed, min_diamond_cavern_size, max_diamond_cavern_size))
        * (1 - subterranean_impassable_cliffs_caverns_spot_noise(x, y, coal_seed, min_coal_cavern_size, max_coal_cavern_size))
        * (1 - subterranean_impassable_cliffs_caverns_spot_noise(x, y, stone_seed, min_stone_cavern_size, max_stone_cavern_size))
        * (1 - subterranean_impassable_cliffs_caverns_spot_noise(x, y, iron_seed, min_iron_cavern_size, max_iron_cavern_size))
        * (1 - subterranean_impassable_cliffs_caverns_spot_noise(x, y, copper_seed, min_copper_cavern_size, max_copper_cavern_size))
        * (1 - subterranean_impassable_cliffs_caverns_spot_noise(x, y, uranium_seed, min_uranium_cavern_size, max_uranium_cavern_size))
    ]],
    local_expressions = {
        diamond_seed = constants.diamond_ore_patch_seed,
        min_diamond_cavern_size = constants.diamond_ore_min_cavern_size,
        max_diamond_cavern_size = constants.diamond_ore_max_cavern_size,
        coal_seed = constants.coal_ore_patch_seed,
        min_coal_cavern_size = constants.coal_ore_min_cavern_size,
        max_coal_cavern_size = constants.coal_ore_max_cavern_size,
        stone_seed = constants.stone_ore_patch_seed,
        min_stone_cavern_size = constants.stone_ore_min_cavern_size,
        max_stone_cavern_size = constants.stone_ore_max_cavern_size,
        iron_seed = constants.iron_ore_patch_seed,
        min_iron_cavern_size = constants.iron_ore_min_cavern_size,
        max_iron_cavern_size = constants.iron_ore_max_cavern_size,
        copper_seed = constants.copper_ore_patch_seed,
        min_copper_cavern_size = constants.copper_ore_min_cavern_size,
        max_copper_cavern_size = constants.copper_ore_max_cavern_size,
        uranium_seed = constants.uranium_ore_patch_seed,
        min_uranium_cavern_size = constants.uranium_ore_min_cavern_size,
        max_uranium_cavern_size = constants.uranium_ore_max_cavern_size
    }
}

data:extend{
    lerp,
    generic_noise,
    starting_area_generic_noise,
    starting_area, 
    ridge_noise_function_base, 
    caverns_generic_noise,
    caverns_id,
    caverns_spot_noise, 
    ridge_noise_expression_base
}