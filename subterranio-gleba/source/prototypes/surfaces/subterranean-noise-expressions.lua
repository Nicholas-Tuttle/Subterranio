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

-- Height map for different parts
-- Highest area: impassable cliffs
-- Middle area: random biosphere tiles and entities
-- Lower area: rings around the oasis water
-- Lowest area: oasis water lakes

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
local cavern_size = 0.25
local cavern_lake_size = 0.2

local boisphere_noise_function_base = {
    type = "noise-function",
    name = "gleban_subterranean_biosphere_noise_base",
    expression = [[
        voronoi_spot_noise{
            x = x_perturbed,
            y = y_perturbed,
            seed0 = map_seed,
            seed1 = 1,
            grid_size = 256,
            distance_type = "euclidean",
            jitter = 0.75
        }
    ]],
    local_expressions = {
        perturbation = cavern_perturbation,
        x_perturbed = "x + perturbation * gleban_subterranean_caverns_generic_noise(x, y)",
        y_perturbed = "y + perturbation * gleban_subterranean_caverns_generic_noise(x, y)",
    },
    parameters = { "x", "y" }
}

local biosphere_noise_function = {
    type = "noise-function",
    name = "gleban_subterranean_biosphere_noise",
    expression = [[
        clamp(
            ceil(
                cavern_size - gleban_subterranean_biosphere_noise_base(x, y)
            ),
        0.0, 1.0)
    ]],
    local_expressions = {
        cavern_size = cavern_size,
    },
    parameters = { "x", "y" }
}

local gleban_deep_water_noise = {
    type = "noise-function",
    name = "gleban_deep_water_noise",
    expression = [[
        clamp(
            ceil(
                cavern_size * cavern_lake_size - gleban_subterranean_biosphere_noise_base(x, y)
            ),
        0.0, 1.0)
    ]],
    local_expressions = {
        cavern_size = cavern_size,
        cavern_lake_size = cavern_lake_size,
    },
    parameters = { "x", "y" }
}

local gleban_deep_water_noise_expression = {
    type = "noise-expression",
    name = "gleban_deep_water_noise_expression",
    expression = [[
        gleban_deep_water_noise(x, y)
    ]],
    parameters = { "x", "y" }
}

local gleban_dirt_noise_function = {
    type = "noise-function",
    name = "gleban_dirt_noise_function",
    expression = [[
        1 
        + gleban_subterranean_biosphere_noise(x, y)
        + gleban_subterranean_starting_area(x, y, 75)
        - clamp(
            ceil(
                gleban_deep_water_noise(x, y)
                + gleban_subterranean_impassable_cliffs_ridge_noise(x, y)
            ),
        0.0, 1.0)
    ]],
    parameters = { "x", "y" }
}

local gleban_dirt_noise_expression = {
    type = "noise-expression",
    name = "gleban_dirt_noise_expression",
    expression = [[
        gleban_dirt_noise_function(x, y) - gleban_deep_water_noise(x, y)
    ]],
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
    boisphere_noise_function_base,
    biosphere_noise_function,
    gleban_deep_water_noise,
    gleban_deep_water_noise_expression,
    gleban_dirt_noise_function,
    gleban_dirt_noise_expression,
    ridge_noise_function_with_starting_area,
    ridge_noise_with_starting_area_expression_base
}
