
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
    parameters = {"x", "y", "persistence", "input_scale"}
}

-- The big blob of open space at 0, 0
local starting_area_generic_noise = {
    type = "noise-function",
    name = "vulcanus_subterranean_starting_area_generic_noise",
    expression = "vulcanus_subterranean_generic_noise(x, y, 0.5, 1/20)",
    parameters = {"x", "y"}
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
    parameters = {"x", "y", "size"}
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

local ridge_noise_expression_base = {
    type = "noise-expression",
    name = "vulcanus_subterranean_impassable_cliffs_ridge_noise_expression",
    expression = [[
        vulcanus_subterranean_impassable_cliffs_ridge_noise(x, y)
        - vulcanus_subterranean_starting_area(x, y, 75)
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

local lava_noise_expression_base = {
    type = "noise-expression",
    name = "vulcanus_subterranean_lava_noise_expression",
    expression = [[
        vulcanus_subterranean_lava_noise(x, y) - vulcanus_subterranean_hot_lava_noise(x, y)
    ]],
    parameters = { "x", "y" }
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

local hot_lava_noise_expression_base = {
    type = "noise-expression",
    name = "vulcanus_subterranean_hot_lava_noise_expression",
    expression = [[
        vulcanus_subterranean_hot_lava_noise(x, y)
    ]],
    parameters = { "x", "y" }
}

data:extend {
    generic_noise,
    starting_area_generic_noise,
    starting_area,
    ridge_noise_function_base,
    ridge_noise_expression_base,
    lava_noise_function_base,
    lava_noise_expression_base,
    hot_lava_noise_function_base,
    hot_lava_noise_expression_base
}
