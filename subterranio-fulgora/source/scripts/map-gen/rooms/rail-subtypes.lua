local consts = require("scripts.map-gen.map-gen-constants")

return {
    four_way_junction = {
        type = consts.room_types.RAILWAY, subtype = "four_way_junction", right_side_connected = true, left_side_connected = true, top_side_connected = true, bottom_side_connected = true
    },
    straight_up_down = {
        type = consts.room_types.RAILWAY, subtype = "straight_up_down", right_side_connected = false, left_side_connected = false, top_side_connected = true, bottom_side_connected = true
    },
    straight_left_right = {
        type = consts.room_types.RAILWAY, subtype = "straight_left_right", right_side_connected = true, left_side_connected = true, top_side_connected = false, bottom_side_connected = false
    },
    curve_bottom_right = {
        type = consts.room_types.RAILWAY, subtype = "curve_bottom_right", right_side_connected = true, left_side_connected = false, top_side_connected = false, bottom_side_connected = true
    },
    curve_bottom_left = {
        type = consts.room_types.RAILWAY, subtype = "curve_bottom_left", right_side_connected = false, left_side_connected = true, top_side_connected = false, bottom_side_connected = true
    },
    curve_top_right = {
        type = consts.room_types.RAILWAY, subtype = "curve_top_right", right_side_connected = true, left_side_connected = false, top_side_connected = true, bottom_side_connected = false
    },
    curve_top_left = {
        type = consts.room_types.RAILWAY, subtype = "curve_top_left", right_side_connected = false, left_side_connected = true, top_side_connected = true, bottom_side_connected = false
    },
    three_way_junction_sides_bottom = {
        type = consts.room_types.RAILWAY, subtype = "three_way_junction_sides_bottom", right_side_connected = true, left_side_connected = true, top_side_connected = false, bottom_side_connected = true
    },
    three_way_junction_sides_top = {
        type = consts.room_types.RAILWAY, subtype = "three_way_junction_sides_top", right_side_connected = true, left_side_connected = true, top_side_connected = true, bottom_side_connected = false
    },
    three_way_junction_ends_right = {
        type = consts.room_types.RAILWAY, subtype = "three_way_junction_ends_right", right_side_connected = true, left_side_connected = false, top_side_connected = true, bottom_side_connected = true
    },
    three_way_junction_ends_left = {
        type = consts.room_types.RAILWAY, subtype = "three_way_junction_ends_left", right_side_connected = false, left_side_connected = true, top_side_connected = true, bottom_side_connected = true
    },
    dead_end_top_entrance = {
        type = consts.room_types.RAILWAY, subtype = "dead_end_top_entrance", right_side_connected = false, left_side_connected = false, top_side_connected = true, bottom_side_connected = false
    },
    dead_end_right_entrance = {
        type = consts.room_types.RAILWAY, subtype = "dead_end_right_entrance", right_side_connected = true, left_side_connected = false, top_side_connected = false, bottom_side_connected = false
    },
    dead_end_bottom_entrance = {
        type = consts.room_types.RAILWAY, subtype = "dead_end_bottom_entrance", right_side_connected = false, left_side_connected = false, top_side_connected = false, bottom_side_connected = true
    },
    dead_end_left_entrance = {
        type = consts.room_types.RAILWAY, subtype = "dead_end_left_entrance", right_side_connected = false, left_side_connected = true, top_side_connected = false, bottom_side_connected = false
    },
    station_top = {
        type = consts.room_types.RAILWAY, subtype = "station_top", right_side_connected = true, left_side_connected = true, top_side_connected = false, bottom_side_connected = false
    },
    station_right = {
        type = consts.room_types.RAILWAY, subtype = "station_right", right_side_connected = false, left_side_connected = false, top_side_connected = true, bottom_side_connected = true
    },
    station_bottom = {
        type = consts.room_types.RAILWAY, subtype = "station_bottom", right_side_connected = true, left_side_connected = true, top_side_connected = false, bottom_side_connected = false
    },
    station_left = {
        type = consts.room_types.RAILWAY, subtype = "station_left", right_side_connected = false, left_side_connected = false, top_side_connected = true, bottom_side_connected = true
    }
}