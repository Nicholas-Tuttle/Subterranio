
-- the cavern passageways spanning the whole subteranean surface
local ridge_noise_function_base = {
    type = "noise-function",
    name = "vulcanus_subterranean_impassable_cliffs_ridge_noise",
    expression = [[
        clamp(ceil(abs(multioctave_noise{
            x = x,
            y = y,
            persistence = 0.25,
            seed0 = map_seed,
            seed1 = 1,
            octaves = 2,
            input_scale = 1/30,
            output_scale = 1
        }) - 0.1), 0.0, 1.0)
    ]],
    parameters = {"x", "y"}
}

local ridge_noise_expression_base = {
    type = "noise-expression",
    name = "vulcanus_subterranean_impassable_cliffs_ridge_noise_expression",
    expression = [[
        subterranean_impassable_cliffs_ridge_noise(x, y) 
    ]],
    parameters = {"x", "y"}
}

data:extend {ridge_noise_function_base, ridge_noise_expression_base}