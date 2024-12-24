data:extend({
    {
        type = "sticker",
        name = "impassable-cliff-sticker",
        order = "s-k",
        animation =
        {
            tint = {0.1, 0.1, 0.1, 0.1},
            width = 152,
            height = 120,
            line_length = 5,
            frame_count = 60,
            shift = {0, -0.4375},
            priority = "high",
            animation_speed = 0.25,
            filename = "__base__/graphics/entity/smoke/smoke.png",
            scale = 0.25
        },
        duration_in_ticks = 120,
        ground_target = true, -- prevent flight
        update_effects =
        {
            {
                time_cooldown = 5, -- ticks
                effect =
                {
                    {
                        type = "create-particle",
                        probability = 1,
                        affects_target = false,
                        show_in_tooltip = false,
                        particle_name = "spark-particle-debris",
                        offset_deviation = { { -0.5, -0.9 }, { 0.5, 0.9 } },
                        initial_height = 1.2,
                        initial_vertical_speed = 0,
                        initial_vertical_speed_deviation = 0.05,
                        speed_from_center = 0.025,
                        speed_from_center_deviation = 0.01,
                        only_when_visible = true
                    }
                }
            }
        }
    }
})