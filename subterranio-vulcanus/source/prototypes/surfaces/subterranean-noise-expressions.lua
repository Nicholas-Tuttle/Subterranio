-- -0.5 - 0.5 noise
local generic_noise = {
    type = "noise-function",
    name = "vulcanus_subterranean_generic_noise",
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
    parameters = { "x", "y", "persistence", "input_scale" }
}

-- The big blob of open space at 0, 0
local starting_area_generic_noise = {
    type = "noise-function",
    name = "vulcanus_subterranean_starting_area_generic_noise",
    expression = "vulcanus_subterranean_generic_noise(x, y, 0.5, 1/20)",
    parameters = { "x", "y" }
}

local starting_area = {
    type = "noise-function",
    name = "vulcanus_subterranean_starting_area",
    expression = [[
        sqrt(x_perturbed * x_perturbed + y_perturbed * y_perturbed) <= size
    ]],
    local_expressions = {
        perturbation = 40,
        x_perturbed = "x + perturbation * vulcanus_subterranean_starting_area_generic_noise(x, y)",
        y_perturbed = "y + perturbation * vulcanus_subterranean_starting_area_generic_noise(x, y)"
    },
    parameters = { "x", "y", "size" }
}

-- the cavern passageways spanning the whole subteranean surface
local ridge_noise_function_base = {
    type = "noise-function",
    name = "vulcanus_subterranean_impassable_cliffs_ridge_noise",
    expression = [[
        clamp(
            ceil(
                abs(multioctave_noise{
                        x = x,
                        y = y,
                        persistence = 0.25,
                        seed0 = map_seed,
                        seed1 = 1,
                        octaves = 2,
                        input_scale = 1/30,
                        output_scale = 1
                    }
                ) - 0.3
            ),
        0.0, 1.0)
    ]],
    parameters = { "x", "y" }
}

local ridge_noise_function_with_starting_area = {
    type = "noise-function",
    name = "vulcanus_subterranean_impassable_cliffs_ridge_noise_with_starting_area",
    expression = [[
        vulcanus_subterranean_impassable_cliffs_ridge_noise(x, y)
        - vulcanus_subterranean_starting_area(x, y, 75)
    ]],
    parameters = { "x", "y" }
}

local ridge_noise_with_starting_area_expression_base = {
    type = "noise-expression",
    name = "vulcanus_subterranean_impassable_cliffs_ridge_noise_expression",
    expression = [[
        vulcanus_subterranean_impassable_cliffs_ridge_noise_with_starting_area(x, y)
    ]],
    parameters = { "x", "y" }
}

local lava_noise_function_base = {
    type = "noise-function",
    name = "vulcanus_subterranean_lava_noise",
    expression = [[
        clamp(
            ceil(
                0.15 - abs(multioctave_noise{
                        x = x,
                        y = y,
                        persistence = 0.25,
                        seed0 = map_seed,
                        seed1 = 1,
                        octaves = 2,
                        input_scale = 1/30,
                        output_scale = 1
                    }
                )
            ),
        0.0, 1.0)
    ]],
    parameters = { "x", "y" }
}

local lava_drips_function_base = {
    type = "noise-function",
    name = "vulcanus_subterranean_lava_drips_noise",
    expression = [[
        clamp(
            ceil(
                0.02 - abs(multioctave_noise{
                        x = x,
                        y = y,
                        persistence = 0.25,
                        seed0 = map_seed,
                        seed1 = user_seed,
                        octaves = 2,
                        input_scale = 1/10,
                        output_scale = 1
                    }
                )
            ),
        0.0, 1.0)
    ]],
    parameters = { "x", "y", "user_seed" }
}

local hot_lava_noise_function_base = {
    type = "noise-function",
    name = "vulcanus_subterranean_hot_lava_noise",
    expression = [[
        clamp(
            ceil(
                0.05 - abs(multioctave_noise{
                        x = x,
                        y = y,
                        persistence = 0.25,
                        seed0 = map_seed,
                        seed1 = 1,
                        octaves = 2,
                        input_scale = 1/30,
                        output_scale = 1
                    }
                )
            ),
        0.0, 1.0)
    ]],
    parameters = { "x", "y" }
}

-- The random blobs that spawn new caverns
local caverns_generic_noise = {
    type = "noise-function",
    name = "vulcanus_subterranean_caverns_generic_noise",
    expression = "subterranean_generic_noise(x, y, 0.25, 1/10)",
    parameters = { "x", "y" }
}

local cavern_perturbation = 10

-- Value between 0-1 for each cavern
local caverns_id = {
    type = "noise-function",
    name = "vulcanus_subterranean_impassable_cliffs_caverns_id",
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
        x_perturbed = "x + perturbation * vulcanus_subterranean_caverns_generic_noise(x, y)",
        y_perturbed = "y + perturbation * vulcanus_subterranean_caverns_generic_noise(x, y)",
    },
    parameters = { "x", "y", "user_seed" }
}

local caverns_spot_noise = {
    type = "noise-function",
    name = "vulcanus_subterranean_caverns_spot_noise",
    expression = [[
        cavern_central_cones <= cavern_size_relative_to_grid_size
    ]],
    local_expressions = {
        perturbation = cavern_perturbation,
        x_perturbed = "x + perturbation * vulcanus_subterranean_caverns_generic_noise(x, y)",
        y_perturbed = "y + perturbation * vulcanus_subterranean_caverns_generic_noise(x, y)",
        cavern_central_cones = [[
            abs(voronoi_spot_noise{
                x = x_perturbed,
                y = y_perturbed,
                seed0 = map_seed,
                seed1 = user_seed,
                grid_size = 400,
                distance_type = "euclidean",
                jitter = 1
            })
        ]],
        -- Use the id to only make some of the caverns appear
        -- 0.2 at normal frequency (1.0), 0.7 at highest (6.0)
        cavern_chance = [[
            0.2 + 0.5 * ((autoplace_frequency_setting - 1) / (6 - 1))
        ]],
        cavern_size_relative_to_grid_size = [[
            (vulcanus_subterranean_impassable_cliffs_caverns_id(x, y, user_seed) <= cavern_chance) *
            (
                min_cavern_size * autoplace_size_setting +
                lerp(vulcanus_subterranean_impassable_cliffs_caverns_id(x, y, user_seed), 0, cavern_chance) *
                ((max_cavern_size - min_cavern_size) * autoplace_size_setting)
            )
        ]]
    },
    parameters = { "x", "y", "user_seed", "min_cavern_size", "max_cavern_size", "autoplace_size_setting", "autoplace_frequency_setting" }
}

local min_cavern_size = 1
local max_cavern_size = 2

local titanium_lava_noise_expression_base = {
    type = "noise-expression",
    name = "vulcanus_subterranean_titanium_lava_noise_expression",
    expression = [[
        vulcanus_subterranean_lava_noise(x, y) * vulcanus_subterranean_caverns_spot_noise(x, y, 1, min_cavern_size, max_cavern_size, 1, 1)
        - vulcanus_subterranean_hot_lava_noise(x, y)
    ]],
    local_expressions = {
        min_cavern_size = min_cavern_size,
        max_cavern_size = max_cavern_size
    },
    parameters = { "x", "y" }
}

local hot_titanium_lava_noise_expression_base = {
    type = "noise-expression",
    name = "vulcanus_subterranean_hot_titanium_lava_noise_expression",
    expression = [[
        (
            vulcanus_subterranean_hot_lava_noise(x, y) * vulcanus_subterranean_caverns_spot_noise(x, y, 1, min_cavern_size, max_cavern_size, 1, 1)
            + vulcanus_subterranean_lava_drips_noise(x, y, 1)
        ) 
        * (1 - vulcanus_subterranean_impassable_cliffs_ridge_noise_with_starting_area(x, y))
    ]],
    local_expressions = {
        min_cavern_size = min_cavern_size,
        max_cavern_size = max_cavern_size
    },
    parameters = { "x", "y" }
}

local aluminum_lava_noise_expression_base = {
    type = "noise-expression",
    name = "vulcanus_subterranean_aluminum_lava_noise_expression",
    expression = [[
        vulcanus_subterranean_lava_noise(x, y) * vulcanus_subterranean_caverns_spot_noise(x, y, 2, min_cavern_size, max_cavern_size, 1, 1)
        - vulcanus_subterranean_hot_lava_noise(x, y)
    ]],
    local_expressions = {
        min_cavern_size = min_cavern_size,
        max_cavern_size = max_cavern_size
    },
    parameters = { "x", "y" }
}

local hot_aluminum_lava_noise_expression_base = {
    type = "noise-expression",
    name = "vulcanus_subterranean_hot_aluminum_lava_noise_expression",
    expression = [[
        (
            vulcanus_subterranean_hot_lava_noise(x, y) * vulcanus_subterranean_caverns_spot_noise(x, y, 2, min_cavern_size, max_cavern_size, 1, 1)
            + vulcanus_subterranean_lava_drips_noise(x, y, 2)
        ) 
        * (1 - vulcanus_subterranean_impassable_cliffs_ridge_noise_with_starting_area(x, y))
    ]],
    local_expressions = {
        min_cavern_size = min_cavern_size,
        max_cavern_size = max_cavern_size
    },
    parameters = { "x", "y" }
}

data:extend {
    generic_noise,
    starting_area_generic_noise,
    starting_area,
    ridge_noise_function_base,
    ridge_noise_function_with_starting_area,
    ridge_noise_with_starting_area_expression_base,
    lava_noise_function_base,
    lava_drips_function_base,
    hot_lava_noise_function_base,
    caverns_generic_noise,
    caverns_id,
    caverns_spot_noise,
    titanium_lava_noise_expression_base,
    hot_titanium_lava_noise_expression_base,
    aluminum_lava_noise_expression_base,
    hot_aluminum_lava_noise_expression_base
}
