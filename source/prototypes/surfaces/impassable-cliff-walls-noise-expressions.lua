local lerp = {
    type = "noise-function",
    name = "subterranean_lerp",
    expression = [[
        ((1 - percent) * min) + (percent * max)
    ]],
    parameters = {"percent", "min", "max"}
}

-- The big blob of open space at 0, 0
local starting_area_generic_noise = {
    type = "noise-function",
    name = "subterranean_starting_area_generic_noise",
    expression = [[
        multioctave_noise{
            x = x,
            y = y,
            persistence = 0.5,
            seed0 = map_seed,
            seed1 = 1,
            octaves = 2,
            input_scale = 1/20,
            output_scale = 1
        }
    ]],
    parameters = {"x", "y"}
}

local starting_area = {
    type = "noise-function",
    name = "subterranean_starting_area",
    expression = [[
        sqrt(x_perturbed * x_perturbed + y_perturbed * y_perturbed) <= 150
    ]],
    local_expressions = {
        perturbation = 40,
        x_perturbed = "x + perturbation * subterranean_starting_area_generic_noise(x, y)",
        y_perturbed = "y + perturbation * subterranean_starting_area_generic_noise(x, y)"
    },
    parameters = {"x", "y"}
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
    expression = [[
        multioctave_noise{
            x = x,
            y = y,
            persistence = 0.25,
            seed0 = map_seed,
            seed1 = 1,
            octaves = 2,
            input_scale = 1/10,
            output_scale = 1
        }
    ]],
    parameters = {"x", "y"}
}

-- Value between 0-1 for each cavern
local caverns_voronoi_settings = [[
    x = x_perturbed,
    y = y_perturbed, 
    seed0 = map_seed,
    seed1 = 1,
    grid_size = 400,
    distance_type = "euclidean",
    jitter = 1
]]

local caverns_id = {
    type = "noise-function",
    name = "subterranean_impassable_cliffs_caverns_id",
    expression = [[
        abs(voronoi_cell_id{
            ]] .. caverns_voronoi_settings .. [[
        })
    ]],
    local_expressions = {
        perturbation = 20,
        x_perturbed = "x + perturbation * subterranean_caverns_generic_noise(x, y)",
        y_perturbed = "y + perturbation * subterranean_caverns_generic_noise(x, y)",
    },
    parameters = {"x", "y"}
}

local caverns_spot_noise = {
    type = "noise-function",
    name = "subterranean_impassable_cliffs_caverns_spot_noise",
    expression = [[
        cavern_central_cones <= cavern_size_relative_to_grid_size
    ]],
    local_expressions = {
        perturbation = 20,
        x_perturbed = "x + perturbation * subterranean_caverns_generic_noise(x, y)",
        y_perturbed = "y + perturbation * subterranean_caverns_generic_noise(x, y)",
        cavern_central_cones = [[
            abs(voronoi_spot_noise{
                ]] .. caverns_voronoi_settings .. [[
            })
        ]],
        -- Use the id to only make some of the caverns appear
        cavern_chance = 0.5,
        min_cavern_size = 0.15,
        max_cavern_size = 0.5,
        cavern_size_relative_to_grid_size = [[
            (subterranean_impassable_cliffs_caverns_id(x, y) <= cavern_chance) *
            (
                min_cavern_size + 
                lerp(subterranean_impassable_cliffs_caverns_id(x, y), 0, cavern_chance) * 
                (max_cavern_size - min_cavern_size)
            )
        ]]
    },
    parameters = {"x", "y"}
}

-- Spawn cliff walls everywhere except the starting area,
-- carvern spots, and pathways between
local ridge_noise_expression_base = {
    type = "noise-expression",
    name = "subterranean_impassable_cliffs_ridge_noise_expression",
    expression = [[
        subterranean_impassable_cliffs_ridge_noise(x, y)
        * (1 - subterranean_starting_area(x, y))
        * (1 - subterranean_impassable_cliffs_caverns_spot_noise(x, y))
    ]]
}

local ridge_noise_function_temp = {
    type = "noise-expression",
    name = "subterranean_impassable_cliffs_ridge_noise_expression_temp",
    expression = [[
        subterranean_impassable_cliffs_caverns_spot_noise(x, y)
    ]]
}

data:extend{
    lerp,
    starting_area_generic_noise,
    starting_area, 
    ridge_noise_function_base, 
    caverns_generic_noise,
    caverns_id,
    caverns_spot_noise, 
    ridge_noise_expression_base,
    ridge_noise_function_temp
}