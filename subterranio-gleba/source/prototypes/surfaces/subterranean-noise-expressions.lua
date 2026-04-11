local lerp = {
    type = "noise-function",
    name = "gleban_subterranean_lerp",
    expression = [[
        ((1.0 - percent) * min) + (percent * max)
    ]],
    parameters = {"percent", "min", "max"}
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
local upper_middle_area_cutoff = 4000
local lower_middle_area_cutoff = 2000

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
                    grid_size = 512,
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
        starting_area_size = 200,
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

local gleban_dirt_noise_expression = {
    type = "noise-expression",
    name = "gleban_dirt_noise_expression",
    expression = [[
        (height >= lower_middle_area_cutoff + 500) - (height > upper_middle_area_cutoff + 500)
    ]],
    local_expressions = {
        height = "gleban_subterranean_height_noise_function(x, y)",
        lower_middle_area_cutoff = lower_middle_area_cutoff,
        upper_middle_area_cutoff = upper_middle_area_cutoff
    },
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
    lerp,
    generic_noise,
    passages_height_noise,
    starting_area_generic_noise,
    starting_area,
    biosphere_heights,
    height_function,
    impassable_cliff_expression,
    deep_water_expression,
    gleban_dirt_noise_expression,
}

local tiles = {
    "lowland-olive-blubber",
    "lowland-olive-blubber-2",
    "lowland-olive-blubber-3",
    "lowland-brown-blubber",
    "lowland-pale-green",
    "lowland-cream-cauliflower",
    "lowland-cream-cauliflower-2",
    "lowland-dead-skin",
    "lowland-dead-skin-2",
    "lowland-cream-red",
    "lowland-red-vein",
    "lowland-red-vein-2",
    "lowland-red-vein-3",
    "lowland-red-vein-4",
    "lowland-red-vein-dead",
    "lowland-red-infection",
}

for index, value in ipairs(tiles) do
    data:extend{
        {
            type = "noise-expression",
            name = "gleban_subterranean_" .. value .. "_noise_expression",
            expression = [[
                (height >= min_height) - (height > max_height)
            ]],
            local_expressions = {
                height = "gleban_subterranean_height_noise_function(x, y)",
                min_height = index / #tiles * (impassable_cliff_cutoff - upper_middle_area_cutoff) + upper_middle_area_cutoff,
                max_height = (index + 1) / #tiles * (impassable_cliff_cutoff - upper_middle_area_cutoff) + upper_middle_area_cutoff,
            },
            parameters = { "x", "y" }
        }
    }
end