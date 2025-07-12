data:extend {{
    type = "noise-expression",
    name = "cave_starting_area",
    expression = "300"
}}

data:extend {{
    type = "noise-function",
    name = "cave_elevation_bonus",
    expression = [[
        (1 - distance_from_0_0(xx, yy) / cave_starting_area)
    ]],
    parameters = {"xx", "yy"}
}}

data:extend {{
    type = "noise-function",
    name = "cave_surface_moisture",
    expression = [[
        abs(multioctave_noise{
            x = x,
            y = y,
            persistence = 0.25,
            seed0 = map_seed,
            seed1 = 1,
            octaves = 2,
            input_scale = 1/1300,
            output_scale = 1
        })
    ]],
    parameters = {"xx", "yy"}
}}

data:extend {{
    type = "noise-function",
    name = "distance_from_0_0",
    expression = "sqrt(xx * xx + yy * yy)",
    parameters = {"xx", "yy"}
}}

data:extend {{
    type = "noise-function",
    name = "cave_elevation",
    expression = [[
        1 - (1 - min(1, elevation) + 0.1 ) ^ 3 + elevation/3
    ]],
    local_expressions = {
        xx = "xxx - 38",
        yy = "yyy + 14",
        elevation = [[
            if(
                distance_from_0_0(xx, yy) < cave_starting_area,
                cave_surface_moisture(xx, yy) + cave_elevation_bonus(xx, yy),
                cave_surface_moisture(xx, yy)
            )
        ]]
    },
    parameters = {"xxx", "yyy"}
}}

data:extend {{
    type = "noise-expression",
    name = "cave_surface_elevation",
    expression = "cave_elevation(x, y)"
}}