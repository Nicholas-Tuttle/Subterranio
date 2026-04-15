local surface_tiles_definitions = require("surface-tiles-definitions")

local lerp = {
    type = "noise-function",
    name = "gleban_subterranean_lerp",
    expression = [[
        ((1.0 - percent) * min) + (percent * max)
    ]],
    parameters = { "percent", "min", "max" }
}

-- -0.5 - 0.5 noise
local generic_noise = {
    type = "noise-function",
    name = "gleban_subterranean_generic_noise",
    expression = [[
        gleban_subterranean_lerp(multioctave_noise{
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
-- Highest area and up: impassable cliffs
-- Upper middle area: random biosphere tiles and entities
-- The ridge noise to connect the biospheres should be in this range
-- Lower middle area: rings around the oasis water
-- Lowest area: oasis water lakes

-- 10000 * whatever percent of the map should be covered by this type of surface
local max_height = 10000
local impassable_cliff_cutoff = 9000
local upper_middle_area_cutoff = 6000
local lower_middle_area_cutoff = 3000

local passages_height_noise = {
    type = "noise-function",
    name = "gleban_subterranean_passages_noise",
    expression = [[
        gleban_subterranean_lerp(1.0 - (height / 0.3), max_height, upper_middle_area_cutoff + 500)
    ]],
    local_expressions = {
        max_height = max_height,
        upper_middle_area_cutoff = upper_middle_area_cutoff, -- the bottom of the passaages
        height = [[
            abs(multioctave_noise{
                x = x,
                y = y,
                persistence = persistence,
                seed0 = map_seed,
                seed1 = 1,
                octaves = 4,
                input_scale = input_scale,
                output_scale = 1
            })
        ]]
    },
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
        gleban_subterranean_lerp((sqrt(x_perturbed * x_perturbed + y_perturbed * y_perturbed) / size), upper_middle_area_cutoff + 500, impassable_cliff_cutoff)
    ]],
    local_expressions = {
        impassable_cliff_cutoff = impassable_cliff_cutoff,
        upper_middle_area_cutoff = upper_middle_area_cutoff,
        perturbation = 40,
        x_perturbed = "x + perturbation * gleban_subterranean_starting_area_generic_noise(x, y)",
        y_perturbed = "y + perturbation * gleban_subterranean_starting_area_generic_noise(x, y)"
    },
    parameters = { "x", "y", "size" }
}

local cavern_perturbation = 10
local voronoi_grid_size = 256

local biosphere_heights = {
    type = "noise-function",
    name = "gleban_subterranean_biosphere_noise_base",
    expression = [[
        clamp(
            gleban_subterranean_lerp (
                voronoi_spot_noise{
                    x = x_perturbed,
                    y = y_perturbed,
                    seed0 = map_seed,
                    seed1 = 1,
                    grid_size = grid_size,
                    distance_type = "euclidean",
                    jitter = 0.85
                },
                lower_middle_area_cutoff,
                max_height * 3
            ),
            lower_middle_area_cutoff,
            max_height
        )
    ]],
    local_expressions = {
        grid_size = voronoi_grid_size,
        max_height = max_height,
        lower_middle_area_cutoff = lower_middle_area_cutoff,
        impassable_cliff_cutoff = impassable_cliff_cutoff,
        perturbation = cavern_perturbation,
        x_perturbed = "x + perturbation * gleban_subterranean_generic_noise(x, y, 0.25, 1/10)",
        y_perturbed = "y + perturbation * gleban_subterranean_generic_noise(x, y, 0.25, 1/10)",
    },
    parameters = { "x", "y" }
}

local height_function = {
    type = "noise-function",
    name = "gleban_subterranean_height_noise_function",
    expression = [[
        min(
            max (
                (1 - sqrt(x_perturbed * x_perturbed + y_perturbed * y_perturbed) / (starting_area_size * 2)) * (max_height * 4),
                gleban_subterranean_biosphere_noise_base(x, y)
            ),
            gleban_subterranean_passages_noise(x, y, 0.25, 1/20),
            starting_area_height
        )
    ]],
    local_expressions = {
        perturbation = 20,
        x_perturbed = "x + perturbation * gleban_subterranean_starting_area_generic_noise(x, y)",
        y_perturbed = "y + perturbation * gleban_subterranean_starting_area_generic_noise(x, y)",
        starting_area_size = 150,
        starting_area_height = "gleban_subterranean_starting_area(x, y, starting_area_size)",
        max_height = max_height,
        impassable_cliff_cutoff = impassable_cliff_cutoff,
    },
    parameters = { "x", "y" }
}

local impassable_cliff_expression = {
    type = "noise-expression",
    name = "gleban_subterranean_impassable_cliffs_ridge_noise_expression",
    expression = [[
        height > impassable_cliff_cutoff
    ]],
    local_expressions = {
        height = "gleban_subterranean_height_noise_function(x, y)",
        impassable_cliff_cutoff = impassable_cliff_cutoff
    },
    parameters = { "x", "y" }
}

local deep_water_expression = {
    type = "noise-expression",
    name = "gleban_deep_water_noise_expression",
    expression = [[
        height < lower_middle_area_cutoff
    ]],
    local_expressions = {
        height = "gleban_subterranean_height_noise_function(x, y)",
        lower_middle_area_cutoff = lower_middle_area_cutoff
    },
    parameters = { "x", "y" }
}

data:extend {
    lerp,
    generic_noise,
    passages_height_noise,
    starting_area_generic_noise,
    starting_area,
    biosphere_heights,
    height_function,
    impassable_cliff_expression,
    deep_water_expression,
}

for index, value in ipairs(surface_tiles_definitions.randomized_tiles) do
    data:extend {
        {
            type = "noise-expression",
            name = "gleban_subterranean_" .. value .. "_noise_expression",
            expression = [[
                (height >= min_height) - (height > max_height)
            ]],
            local_expressions = {
                height = "gleban_subterranean_height_noise_function(x, y)",
                min_height = index / #surface_tiles_definitions.randomized_tiles * (impassable_cliff_cutoff - upper_middle_area_cutoff) + upper_middle_area_cutoff,
                max_height = (index + 1) / #surface_tiles_definitions.randomized_tiles * (impassable_cliff_cutoff - upper_middle_area_cutoff) + upper_middle_area_cutoff,
            },
            parameters = { "x", "y" }
        }
    }
end

local function abs_layered_multioctave_noise_less_than_density(options1, options2)
    return [[
        abs(multioctave_noise{
            x = x,
            y = y,
            persistence = ]] .. options1.persistence .. [[,
            seed0 = map_seed,
            seed1 = seed1,
            octaves = 2,
            input_scale = ]] .. options1.input_scale .. [[,
            output_scale = 1
        } * multioctave_noise{
            x = x,
            y = y,
            persistence = ]] .. options2.persistence .. [[,
            seed0 = map_seed,
            seed1 = seed1,
            octaves = 2,
            input_scale = ]] .. options2.input_scale .. [[,
            output_scale = 1
        }) < (density * density)
    ]]
end

for index, value in ipairs(surface_tiles_definitions.randomized_decoratives) do
    data:extend {
        {
            type = "noise-expression",
            name = "gleban_subterranean_" .. value .. "_noise_expression",
            expression = [[
                ((height >= min_height) - (height > max_height)) * local_probability
            ]],
            local_expressions = {
                seed1 = index,
                height = "gleban_subterranean_height_noise_function(x, y)",
                density = 0.025,
                local_probability = abs_layered_multioctave_noise_less_than_density(
                    { persistence = 1, input_scale = 2 },
                    { persistence = 0.5, input_scale = 1/40 }
                ),
                min_height = upper_middle_area_cutoff,
                max_height = impassable_cliff_cutoff,
            },
            parameters = { "x", "y" }
        }
    }
end

for index, value in ipairs(surface_tiles_definitions.randomized_entities) do
    data:extend {
        {
            type = "noise-expression",
            name = "gleban_subterranean_" .. value.name .. "_noise_expression",
            expression = [[
                ((height >= min_height) - (height > max_height)) * local_probability
            ]],
            local_expressions = {
                seed1 = index + 1000, -- offset the seed so that entities don't spawn in the same places as decoratives
                height = "gleban_subterranean_height_noise_function(x, y)",
                density = 0.05,
                local_probability = abs_layered_multioctave_noise_less_than_density(
                    { persistence = 1, input_scale = 1/5 },
                    { persistence = 0.5, input_scale = 1/40 }
                ),
                min_height = upper_middle_area_cutoff,
                max_height = impassable_cliff_cutoff,
            },
            parameters = { "x", "y" }
        }
    }
end

local biome_count = 0
for _, _ in pairs(surface_tiles_definitions.biomes) do
    biome_count = biome_count + 1
end

local biome_placement_perturbation = 20

local biome_index = [[
    voronoi_cell_id{
        x = x_perturbed,
        y = y_perturbed,
        seed0 = map_seed,
        seed1 = 1,
        grid_size = ]] .. voronoi_grid_size .. [[,
        distance_type = "euclidean",
        jitter = 0.85
    }
]]

local biome_local_probability = abs_layered_multioctave_noise_less_than_density(
    { persistence = 1, input_scale = 1/5 },
    { persistence = 0.5, input_scale = 1/40 }
)

local x_perturbed = "x + perturbation * gleban_subterranean_generic_noise(x, y, 0.25, 1/10)"
local y_perturbed = "y + perturbation * gleban_subterranean_generic_noise(x, y, 0.25, 1/10)"

local biome_array_index = 0
for biome_name, biome in pairs(surface_tiles_definitions.biomes) do
    local biome_index_min = biome_array_index / biome_count
    local biome_index_max = (biome_array_index + 1) / biome_count
    log("Biome " .. biome_name .. " has index range " .. biome_index_min .. " to " .. biome_index_max)
    for index, tile in ipairs(biome.tiles) do
        data:extend {
            {
                type = "noise-expression",
                name = "gleban_subterranean_" .. tile .. "-" .. biome_name .. "_noise_expression",
                expression = [[
                    ((height >= min_height) - (height > max_height)) * ((biome_index >= biome_index_min) - (biome_index > biome_index_max))
                ]],
                local_expressions = {
                    height = "gleban_subterranean_height_noise_function(x, y)",
                    perturbation = biome_placement_perturbation,
                    x_perturbed = x_perturbed,
                    y_perturbed = y_perturbed,
                    biome_index = biome_index,
                    biome_index_min = biome_index_min,
                    biome_index_max = biome_index_max,
                    min_height = index / #biome.tiles * (upper_middle_area_cutoff - lower_middle_area_cutoff) + lower_middle_area_cutoff,
                    max_height = (index + 1) / #biome.tiles * (upper_middle_area_cutoff - lower_middle_area_cutoff) + lower_middle_area_cutoff,
                },
                parameters = { "x", "y" }
            }
        }
    end

    for index, decorative in ipairs(biome.decoratives) do
        data:extend {
            {
                type = "noise-expression",
                name = "gleban_subterranean_" .. decorative .. "-" .. biome_name .. "_noise_expression",
                expression = [[
                    ((height >= min_height) - (height > max_height)) * ((biome_index >= biome_index_min) - (biome_index > biome_index_max)) * local_probability
                ]],
                local_expressions = {
                    seed1 = index,
                    height = "gleban_subterranean_height_noise_function(x, y)",
                    perturbation = biome_placement_perturbation,
                    x_perturbed = x_perturbed,
                    y_perturbed = y_perturbed,
                    biome_index = biome_index,
                    biome_index_min = biome_index_min,
                    biome_index_max = biome_index_max,
                    min_height = lower_middle_area_cutoff,
                    max_height = upper_middle_area_cutoff,
                    density = 0.05,
                    local_probability = biome_local_probability,
                },
                parameters = { "x", "y" }
            }
        }
    end

    for index, entity_info in ipairs(biome.entity) do
        data:extend {
            {
                type = "noise-expression",
                name = "gleban_subterranean_" .. entity_info.name .. "-" .. biome_name .. "_noise_expression",
                expression = [[
                    ((height >= min_height) - (height > max_height)) * ((biome_index >= biome_index_min) - (biome_index > biome_index_max)) * local_probability
                ]],
                local_expressions = {
                    seed1 = index + 1000,
                    height = "gleban_subterranean_height_noise_function(x, y)",
                    perturbation = biome_placement_perturbation,
                    x_perturbed = x_perturbed,
                    y_perturbed = y_perturbed,
                    biome_index = biome_index,
                    biome_index_min = biome_index_min,
                    biome_index_max = biome_index_max,
                    min_height = lower_middle_area_cutoff,
                    max_height = upper_middle_area_cutoff,
                    density = 0.05,
                    local_probability = biome_local_probability,
                },
                parameters = { "x", "y" }
            }
        }
    end

    biome_array_index = biome_array_index + 1
end
