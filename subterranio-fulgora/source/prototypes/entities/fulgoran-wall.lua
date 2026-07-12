local graphics_tinter = require("__subterranio-base__/utilities/graphics-tinter")

local cliff_entity = {
    type = "cliff",
    name = "fulgoran-wall-cliff",
    icon = "__base__/graphics/icons/wall.png",
    subgroup = "cliffs",
    cliff_explosive = "fulgoran-wall-explosives",
    grid_offset = { 0.5, 0.5 },
    grid_size = { 1, 1 },
    deconstruction_alternative = "cliff",
    selectable_in_game = false,
    flags = { "placeable-neutral" },
    collision_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    minable = nil,
    map_color = { r = 0.2, g = 0.2, b = 0.2 },
}

local vertical_shift = -2

local north_to_none = {
    layers =
    {
        {
            filename = "__base__/graphics/entity/wall/wall-vertical.png",
            priority = "extra-high",
            width = 64,
            height = 134,
            variation_count = 5,
            line_length = 5,
            repeat_count = 2,
            shift = util.by_pixel(0, -4 + vertical_shift),
            scale = 0.5
        },
        {
            filename = "__base__/graphics/entity/wall/wall-vertical-shadow.png",
            priority = "extra-high",
            width = 98,
            height = 110,
            repeat_count = 10,
            shift = util.by_pixel(10, 17 + vertical_shift),
            draw_as_shadow = true,
            scale = 0.5
        },
        {
            filename = "__base__/graphics/entity/wall/wall-single.png",
            priority = "extra-high",
            width = 64,
            height = 86,
            variation_count = 2,
            line_length = 2,
            repeat_count = 5,
            -- shift = util.by_pixel(0, -5 + vertical_shift),
            shift = util.by_pixel(0, 4 + vertical_shift),
            scale = 0.5
        },
        {
            filename = "__base__/graphics/entity/wall/wall-single-shadow.png",
            priority = "extra-high",
            width = 98,
            height = 60,
            repeat_count = 10,
            -- shift = util.by_pixel(10, 17 + vertical_shift),
            shift = util.by_pixel(10, 26 + vertical_shift),
            draw_as_shadow = true,
            scale = 0.5
        }
    },
}

local vertical_pictures = {
    layers =
    {
        {
            filename = "__base__/graphics/entity/wall/wall-vertical.png",
            priority = "extra-high",
            width = 64,
            height = 134,
            variation_count = 5,
            line_length = 5,
            repeat_count = 2,
            shift = util.by_pixel(0, 8 + vertical_shift),
            scale = 0.5
        },
        {
            filename = "__base__/graphics/entity/wall/wall-vertical-shadow.png",
            priority = "extra-high",
            width = 98,
            height = 110,
            repeat_count = 10,
            shift = util.by_pixel(10, 29 + vertical_shift),
            draw_as_shadow = true,
            scale = 0.5
        }
    },
}

local south_to_none = {
    layers =
    {
        {
            filename = "__base__/graphics/entity/wall/wall-vertical.png",
            priority = "extra-high",
            width = 64,
            height = 134,
            variation_count = 5,
            line_length = 5,
            shift = util.by_pixel(0, -8 + vertical_shift),
            scale = 0.5
        },
        {
            filename = "__base__/graphics/entity/wall/wall-vertical-shadow.png",
            priority = "extra-high",
            width = 98,
            height = 110,
            repeat_count = 5,
            shift = util.by_pixel(10, 13 + vertical_shift),
            draw_as_shadow = true,
            scale = 0.5
        },
        {
            filename = "__base__/graphics/entity/wall/wall-vertical.png",
            priority = "extra-high",
            width = 64,
            height = 134,
            variation_count = 5,
            line_length = 5,
            shift = util.by_pixel(0, 8 + vertical_shift),
            scale = 0.5
        },
        {
            filename = "__base__/graphics/entity/wall/wall-vertical-shadow.png",
            priority = "extra-high",
            width = 98,
            height = 110,
            repeat_count = 5,
            shift = util.by_pixel(10, 29 + vertical_shift),
            draw_as_shadow = true,
            scale = 0.5
        }
    },
}

local horizontal_pictures = {
    layers =
    {
        {
            filename = "__base__/graphics/entity/wall/wall-horizontal.png",
            priority = "extra-high",
            width = 64,
            height = 92,
            variation_count = 6,
            line_length = 6,
            shift = util.by_pixel(0, -2 + vertical_shift),
            scale = 0.5
        },
        {
            filename = "__base__/graphics/entity/wall/wall-horizontal-shadow.png",
            priority = "extra-high",
            width = 124,
            height = 68,
            repeat_count = 6,
            shift = util.by_pixel(14, 15 + vertical_shift),
            draw_as_shadow = true,
            scale = 0.5
        }
    },
}

local corner_right_down_pictures = {
    layers =
    {
        {
            filename = "__base__/graphics/entity/wall/wall-corner-right.png",
            priority = "extra-high",
            width = 64,
            height = 128,
            variation_count = 2,
            line_length = 2,
            shift = util.by_pixel(0, 7 + vertical_shift),
            scale = 0.5
        },
        {
            filename = "__base__/graphics/entity/wall/wall-corner-right-shadow.png",
            priority = "extra-high",
            width = 124,
            height = 120,
            repeat_count = 2,
            shift = util.by_pixel(17, 28 + vertical_shift),
            draw_as_shadow = true,
            scale = 0.5
        }
    },
}

local corner_left_down_pictures = {
    layers =
    {
        {
            filename = "__base__/graphics/entity/wall/wall-corner-left.png",
            priority = "extra-high",
            width = 64,
            height = 134,
            variation_count = 2,
            line_length = 2,
            shift = util.by_pixel(0, 7 + vertical_shift),
            scale = 0.5
        },
        {
            filename = "__base__/graphics/entity/wall/wall-corner-left-shadow.png",
            priority = "extra-high",
            width = 102,
            height = 120,
            repeat_count = 2,
            shift = util.by_pixel(9, 28 + vertical_shift),
            draw_as_shadow = true,
            scale = 0.5
        }
    },
}

local corner_right_up_pictures = {
    layers =
    {
        {
            filename = "__base__/graphics/entity/wall/wall-ending-left.png",
            priority = "extra-high",
            width = 64,
            height = 92,
            variation_count = 2,
            line_length = 2,
            shift = util.by_pixel(0, -3 + vertical_shift),
            scale = 0.5
        },
        {
            filename = "__base__/graphics/entity/wall/wall-ending-left-shadow.png",
            priority = "extra-high",
            width = 102,
            height = 68,
            repeat_count = 2,
            shift = util.by_pixel(9, 15 + vertical_shift),
            draw_as_shadow = true,
            scale = 0.5
        }
    },
}

local corner_left_up_pictures = {
    layers =
    {
        {
            filename = "__base__/graphics/entity/wall/wall-ending-right.png",
            priority = "extra-high",
            width = 64,
            height = 92,
            variation_count = 2,
            line_length = 2,
            shift = util.by_pixel(0, -3 + vertical_shift),
            scale = 0.5
        },
        {
            filename = "__base__/graphics/entity/wall/wall-ending-right-shadow.png",
            priority = "extra-high",
            width = 124,
            height = 68,
            repeat_count = 2,
            shift = util.by_pixel(17, 15 + vertical_shift),
            draw_as_shadow = true,
            scale = 0.5
        }
    },
}

local collision_bounding_box = {
    { -0.5, -0.5 }, { 0.5, 0.5 }
}
local render_layer = "object"

cliff_entity.orientations = {
    west_to_east = {
        collision_bounding_box = collision_bounding_box,
        pictures = horizontal_pictures,
        render_layer = render_layer,
    },
    north_to_south = {
        collision_bounding_box = collision_bounding_box,
        pictures = vertical_pictures,
        render_layer = render_layer,
    },
    east_to_west = {
        collision_bounding_box = collision_bounding_box,
        pictures = horizontal_pictures,
        render_layer = render_layer,
    },
    south_to_north = {
        collision_bounding_box = collision_bounding_box,
        pictures = vertical_pictures,
        render_layer = render_layer,
    },
    west_to_north = {
        collision_bounding_box = collision_bounding_box,
        pictures = corner_right_up_pictures,
        render_layer = render_layer,
    },
    north_to_east = {
        collision_bounding_box = collision_bounding_box,
        pictures = corner_left_up_pictures,
        render_layer = render_layer,
    },
    east_to_south = {
        collision_bounding_box = collision_bounding_box,
        pictures = corner_right_down_pictures,
        render_layer = render_layer,
    },
    south_to_west = {
        collision_bounding_box = collision_bounding_box,
        pictures = corner_left_down_pictures,
        render_layer = render_layer,
    },
    west_to_south = {
        collision_bounding_box = collision_bounding_box,
        pictures = corner_left_down_pictures,
        render_layer = render_layer,
    },
    north_to_west = {
        collision_bounding_box = collision_bounding_box,
        pictures = corner_right_up_pictures,
        render_layer = render_layer,
    },
    east_to_north = {
        collision_bounding_box = collision_bounding_box,
        pictures = corner_left_up_pictures,
        render_layer = render_layer,
    },
    south_to_east = {
        collision_bounding_box = collision_bounding_box,
        pictures = corner_right_down_pictures,
        render_layer = render_layer,
    },
    west_to_none = {
        collision_bounding_box = collision_bounding_box,
        pictures = horizontal_pictures,
        render_layer = render_layer,
    },
    none_to_east = {
        collision_bounding_box = collision_bounding_box,
        pictures = horizontal_pictures,
        render_layer = render_layer,
    },
    north_to_none = {
        collision_bounding_box = collision_bounding_box,
        pictures = north_to_none,
        render_layer = render_layer,
    },
    none_to_south = {
        collision_bounding_box = collision_bounding_box,
        pictures = vertical_pictures,
        render_layer = render_layer,
    },
    east_to_none = {
        collision_bounding_box = collision_bounding_box,
        pictures = horizontal_pictures,
        render_layer = render_layer,
    },
    none_to_west = {
        collision_bounding_box = collision_bounding_box,
        pictures = horizontal_pictures,
        render_layer = render_layer,
    },
    south_to_none = {
        collision_bounding_box = collision_bounding_box,
        pictures = south_to_none,
        render_layer = render_layer,
    },
    none_to_north = {
        collision_bounding_box = collision_bounding_box,
        pictures = north_to_none,
        render_layer = render_layer,
    },
}

cliff_entity = graphics_tinter.tint(cliff_entity, { r = 0.7, g = 0.5, b = 0.5, a = 1 })

data:extend {
    cliff_entity
}
