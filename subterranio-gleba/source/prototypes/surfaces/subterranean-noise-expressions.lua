-- -0.5 - 0.5 noise
local generic_noise = {
    type = "noise-function",
    name = "gleban_subterranean_generic_noise",
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
    name = "gleban_subterranean_starting_area_generic_noise",
    expression = "gleban_subterranean_generic_noise(x, y, 0.5, 1/20)",
    parameters = { "x", "y" }
}

local starting_area = {
    type = "noise-function",
    name = "gleban_subterranean_starting_area",
    expression = [[
        sqrt(x_perturbed * x_perturbed + y_perturbed * y_perturbed) <= size
    ]],
    local_expressions = {
        perturbation = 40,
        x_perturbed = "x + perturbation * gleban_subterranean_starting_area_generic_noise(x, y)",
        y_perturbed = "y + perturbation * gleban_subterranean_starting_area_generic_noise(x, y)"
    },
    parameters = { "x", "y", "size" }
}

-- the cavern passageways spanning the whole subteranean surface
local ridge_noise_function_base = {
    type = "noise-function",
    name = "gleban_subterranean_impassable_cliffs_ridge_noise",
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
                        input_scale = 1/60,
                        output_scale = 1
                    }
                ) - 0.3
            ),
        0.0, 1.0)
    ]],
    parameters = { "x", "y" }
}

local caverns_generic_noise = {
    type = "noise-function",
    name = "gleban_subterranean_caverns_generic_noise",
    expression = "gleban_subterranean_generic_noise(x, y, 0.25, 1/10)",
    parameters = {"x", "y"}
}

local cavern_perturbation = 10

local biosphere_noise_function = {
    type = "noise-function",
    name = "gleban_subterranean_biosphere_noise",
    expression = [[
        clamp(
            ceil(
                0.25 - voronoi_spot_noise{
                    x = x_perturbed,
                    y = y_perturbed,
                    seed0 = map_seed,
                    seed1 = 1,
                    grid_size = 256,
                    distance_type = "euclidean",
                    jitter = 0.5
                }
            ),
        0.0, 1.0)
    ]],
    local_expressions = {
        perturbation = cavern_perturbation,
        x_perturbed = "x + perturbation * gleban_subterranean_caverns_generic_noise(x, y)",
        y_perturbed = "y + perturbation * gleban_subterranean_caverns_generic_noise(x, y)",
    },
    parameters = { "x", "y" }
}

local ridge_noise_function_with_starting_area = {
    type = "noise-function",
    name = "gleban_subterranean_impassable_cliffs_ridge_noise_with_starting_area",
    expression = [[
        gleban_subterranean_impassable_cliffs_ridge_noise(x, y)
        - gleban_subterranean_starting_area(x, y, 75)
        - 1000 * gleban_subterranean_biosphere_noise(x, y)
    ]],
    parameters = { "x", "y" }
}

local ridge_noise_with_starting_area_expression_base = {
    type = "noise-expression",
    name = "gleban_subterranean_impassable_cliffs_ridge_noise_expression",
    expression = [[
        gleban_subterranean_impassable_cliffs_ridge_noise_with_starting_area(x, y)
    ]],
    parameters = { "x", "y" }
}

-- Green biosphere:
-- Tiles
-- deep-green-water
-- green-water
-- deep-lake
-- blue-marsh
-- green-marsh
-- light-green-marsh
-- "lowland-olive-blubber",
-- "lowland-olive-blubber-2",
-- "lowland-olive-blubber-3",
-- "lowland-pale-green",
-- "midland-turquoise-bark",
-- "midland-turquoise-bark-2",
-- "midland-cracked-lichen",
-- "midland-cracked-lichen-dull",
-- "midland-cracked-lichen-dark",

-- Entities
-- hairy clubnub
-- stingfrond
-- cuttlepop
-- slipstack

-- Decoratives
-- "black-sceptre",
-- "knobbly-roots",
-- "polycephalum-slime",
-- "green-bush-mini",
-- "green-croton",
-- "green-cup",
-- "brown-cup",

data:extend{
    generic_noise,
    starting_area_generic_noise,
    starting_area,
    caverns_generic_noise,
    ridge_noise_function_base,
    biosphere_noise_function,
    ridge_noise_function_with_starting_area,
    ridge_noise_with_starting_area_expression_base
}
