local noise_expression = {
    type = "noise-expression",
    name = "subway_floor_noise_expression",
    expression = [[
        0.01 - voronoi_pyramid_noise{
            x = x,
            y = y,
            seed0 = map_seed,
            seed1 = 1,
            grid_size = 100,
            distance_type = "chebyshev",
            jitter = 1.0
        }
    ]]
}

data:extend{noise_expression}
