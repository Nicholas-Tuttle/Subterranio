local consts = require("scripts.map-gen.map-gen-constants")
local blueprints = require("scripts.map-gen.blueprints")
local chunk_information = require("scripts.map-gen.chunk-information")

local rail_subtypes = {
    four_way_junction = {
        type = consts.room_types.RAILWAY, subtype = "four_way_junction", right_side_open = true, left_side_open = true, top_side_open = true, bottom_side_open = true
    },
    straight_up_down = {
        type = consts.room_types.RAILWAY, subtype = "straight_up_down", right_side_open = false, left_side_open = false, top_side_open = true, bottom_side_open = true
    },
    straight_left_right = {
        type = consts.room_types.RAILWAY, subtype = "straight_left_right", right_side_open = true, left_side_open = true, top_side_open = false, bottom_side_open = false
    },
    curve_bottom_right = {
        type = consts.room_types.RAILWAY, subtype = "curve_bottom_right", right_side_open = true, left_side_open = false, top_side_open = false, bottom_side_open = true
    },
    curve_bottom_left = {
        type = consts.room_types.RAILWAY, subtype = "curve_bottom_left", right_side_open = false, left_side_open = true, top_side_open = false, bottom_side_open = true
    },
    curve_top_right = {
        type = consts.room_types.RAILWAY, subtype = "curve_top_right", right_side_open = true, left_side_open = false, top_side_open = true, bottom_side_open = false
    },
    curve_top_left = {
        type = consts.room_types.RAILWAY, subtype = "curve_top_left", right_side_open = false, left_side_open = true, top_side_open = true, bottom_side_open = false
    },
    three_way_junction_sides_bottom = {
        type = consts.room_types.RAILWAY, subtype = "three_way_junction_sides_bottom", right_side_open = true, left_side_open = true, top_side_open = false, bottom_side_open = true
    },
    three_way_junction_sides_top = {
        type = consts.room_types.RAILWAY, subtype = "three_way_junction_sides_top", right_side_open = true, left_side_open = true, top_side_open = true, bottom_side_open = false
    },
    three_way_junction_ends_right = {
        type = consts.room_types.RAILWAY, subtype = "three_way_junction_ends_right", right_side_open = true, left_side_open = false, top_side_open = true, bottom_side_open = true
    },
    three_way_junction_ends_left = {
        type = consts.room_types.RAILWAY, subtype = "three_way_junction_ends_left", right_side_open = false, left_side_open = true, top_side_open = true, bottom_side_open = true
    },
    dead_end_top = {
        type = consts.room_types.RAILWAY, subtype = "dead_end_top", right_side_open = false, left_side_open = false, top_side_open = true, bottom_side_open = false
    },
    dead_end_right = {
        type = consts.room_types.RAILWAY, subtype = "dead_end_right", right_side_open = true, left_side_open = false, top_side_open = false, bottom_side_open = false
    },
    dead_end_bottom = {
        type = consts.room_types.RAILWAY, subtype = "dead_end_bottom", right_side_open = false, left_side_open = false, top_side_open = false, bottom_side_open = true
    },
    dead_end_left = {
        type = consts.room_types.RAILWAY, subtype = "dead_end_left", right_side_open = false, left_side_open = true, top_side_open = false, bottom_side_open = false
    },
    station_top = {
        type = consts.room_types.RAILWAY, subtype = "station_top", right_side_open = true, left_side_open = true, top_side_open = false, bottom_side_open = false
    },
    station_right = {
        type = consts.room_types.RAILWAY, subtype = "station_right", right_side_open = false, left_side_open = false, top_side_open = true, bottom_side_open = true
    },
    station_bottom = {
        type = consts.room_types.RAILWAY, subtype = "station_bottom", right_side_open = true, left_side_open = true, top_side_open = false, bottom_side_open = false
    },
    station_left = {
        type = consts.room_types.RAILWAY, subtype = "station_left", right_side_open = false, left_side_open = false, top_side_open = true, bottom_side_open = true
    }
}

local function spawn_room(bounding_box, surface)
    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(bounding_box.left_top.x, bounding_box.left_top.y)
    local room = chunk_information.get_chunk_data(chunk_indices)
    if room == nil or room.subtype == nil then
        game.print("Could not retrieve underground rail information to spawn room")
        return
    end

    local room_type = room.subtype
    -- game.print("Spawning rails of type " .. room_type .. " at bounding box " .. serpent.line(chunk_indices))

    blueprints.generate(bounding_box, surface, "rails_" .. room_type, {
        ["concrete"] = "fulgoran-rock",
        ["refined-concrete"] = "fulgoran-sand",
        ["refined-hazard-concrete-right"] = "fulgoran-paving",
        ["refined-hazard-concrete-left"] = "fulgoran-paving"
    }, {
        ["stone-wall"] = "fulgoran-wall",
        ["gate"] = "fulgoran-gate",
        ["small-lamp"] = "fulgoran-lamp"
    })
end

local function is_left_chunk_connected_rail(chunk_subtype)
    if chunk_subtype == nil then
        return false
    end

    local connected_subtypes = {
        [rail_subtypes.four_way_junction.subtype] = true,
        [rail_subtypes.straight_left_right.subtype] = true,
        [rail_subtypes.curve_bottom_right.subtype] = true,
        [rail_subtypes.curve_top_right.subtype] = true,
        [rail_subtypes.three_way_junction_sides_bottom.subtype] = true,
        [rail_subtypes.three_way_junction_sides_top.subtype] = true,
        [rail_subtypes.three_way_junction_ends_right.subtype] = true,
        [rail_subtypes.dead_end_right.subtype] = true,
        [rail_subtypes.station_top.subtype] = true,
        [rail_subtypes.station_bottom.subtype] = true,
    }

    return connected_subtypes[chunk_subtype] ~= nil
end

local function is_right_chunk_connected_rail(chunk_subtype)
    if chunk_subtype == nil then
        return false
    end

    local connected_subtypes = {
        [rail_subtypes.four_way_junction.subtype] = true,
        [rail_subtypes.straight_left_right.subtype] = true,
        [rail_subtypes.curve_bottom_left.subtype] = true,
        [rail_subtypes.curve_top_left.subtype] = true,
        [rail_subtypes.three_way_junction_sides_bottom.subtype] = true,
        [rail_subtypes.three_way_junction_sides_top.subtype] = true,
        [rail_subtypes.three_way_junction_ends_left.subtype] = true,
        [rail_subtypes.dead_end_left.subtype] = true,
        [rail_subtypes.station_top.subtype] = true,
        [rail_subtypes.station_bottom.subtype] = true,
    }

    return connected_subtypes[chunk_subtype] ~= nil
end

local function is_top_chunk_connected_rail(chunk_subtype)
    if chunk_subtype == nil then
        return false
    end

    local connected_subtypes = {
        [rail_subtypes.four_way_junction.subtype] = true,
        [rail_subtypes.straight_up_down.subtype] = true,
        [rail_subtypes.curve_bottom_right.subtype] = true,
        [rail_subtypes.curve_bottom_left.subtype] = true,
        [rail_subtypes.three_way_junction_sides_bottom.subtype] = true,
        [rail_subtypes.three_way_junction_ends_right.subtype] = true,
        [rail_subtypes.three_way_junction_ends_left.subtype] = true,
        [rail_subtypes.dead_end_bottom.subtype] = true,
        [rail_subtypes.station_left.subtype] = true,
        [rail_subtypes.station_right.subtype] = true,
    }

    return connected_subtypes[chunk_subtype] ~= nil
end

local function is_bottom_chunk_connected_rail(chunk_subtype)
    if chunk_subtype == nil then
        return false
    end

    local connected_subtypes = {
        [rail_subtypes.four_way_junction.subtype] = true,
        [rail_subtypes.straight_up_down.subtype] = true,
        [rail_subtypes.curve_top_right.subtype] = true,
        [rail_subtypes.curve_top_left.subtype] = true,
        [rail_subtypes.three_way_junction_sides_top.subtype] = true,
        [rail_subtypes.three_way_junction_ends_right.subtype] = true,
        [rail_subtypes.three_way_junction_ends_left.subtype] = true,
        [rail_subtypes.dead_end_top.subtype] = true,
        [rail_subtypes.station_left.subtype] = true,
        [rail_subtypes.station_right.subtype] = true,
    }

    return connected_subtypes[chunk_subtype] ~= nil
end

local function get_four_way_connection()
    return rail_subtypes.four_way_junction
end

local function get_three_or_four_way_connection(
                left_chunk_is_connected_non_rail,
                right_chunk_is_connected_non_rail,
                top_chunk_is_connected_non_rail,
                bottom_chunk_is_connected_non_rail)
    if not left_chunk_is_connected_non_rail and not right_chunk_is_connected_non_rail and not top_chunk_is_connected_non_rail and not bottom_chunk_is_connected_non_rail then
        return rail_subtypes.four_way_junction
    end

    if left_chunk_is_connected_non_rail then
        return rail_subtypes.three_way_junction_ends_right
    end

    if right_chunk_is_connected_non_rail then
        return rail_subtypes.three_way_junction_ends_left
    end

    if top_chunk_is_connected_non_rail then
        return rail_subtypes.three_way_junction_sides_bottom
    end

    return rail_subtypes.three_way_junction_ends_top
end

local function get_three_way_connection(
                left_chunk,
                right_chunk,
                top_chunk,
                bottom_chunk,
                left_chunk_is_connected_non_rail,
                right_chunk_is_connected_non_rail,
                top_chunk_is_connected_non_rail,
                bottom_chunk_is_connected_non_rail)
    if left_chunk == nil or left_chunk_is_connected_non_rail then
        return rail_subtypes.three_way_junction_ends_right
    end

    if right_chunk == nil or right_chunk_is_connected_non_rail then
        return rail_subtypes.three_way_junction_ends_left
    end

    if top_chunk == nil or top_chunk_is_connected_non_rail then
        return rail_subtypes.three_way_junction_sides_bottom
    end

    if bottom_chunk == nil or bottom_chunk_is_connected_non_rail then
        return rail_subtypes.three_way_junction_ends_top
    end

    game.print("Error when generating three-way rail connection")
    return nil
end

-- TODO: this needs to check if there are non-connected adjacent rails and adjust spawns to not put an entrance pointing that way 
local function get_two_or_three_way_connection(
                left_chunk,
                right_chunk,
                top_chunk,
                bottom_chunk,
                left_chunk_is_connected_non_rail,
                right_chunk_is_connected_non_rail,
                top_chunk_is_connected_non_rail,
                bottom_chunk_is_connected_non_rail)
    local station_threshold = 0.2
    local straight_threshold = 0.6
    local rand = math.random()
    if left_chunk ~= nil and left_chunk_is_connected_non_rail then
        if right_chunk_is_connected_non_rail then
            if rand < station_threshold then
                return rail_subtypes.station_right
            else
                return rail_subtypes.straight_up_down
            end
        end

        if top_chunk_is_connected_non_rail then
            return rail_subtypes.curve_bottom_right
        end

        if bottom_chunk_is_connected_non_rail then
            return rail_subtypes.curve_top_right
        end

        if rand < station_threshold then
            return rail_subtypes.station_left
        elseif rand < straight_threshold then
            return rail_subtypes.straight_up_down
        else
            return rail_subtypes.three_way_junction_ends_right
        end
    end

    if right_chunk ~= nil and right_chunk_is_connected_non_rail then
        if left_chunk_is_connected_non_rail then
            if rand < station_threshold then
                return rail_subtypes.straight_up_down
            else
                return rail_subtypes.station_left
            end
        end

        if top_chunk_is_connected_non_rail then
            return rail_subtypes.curve_bottom_left
        end

        if bottom_chunk_is_connected_non_rail then
            return rail_subtypes.curve_top_left
        end

        if rand < station_threshold then
            return rail_subtypes.station_right
        elseif rand < straight_threshold then
            return rail_subtypes.straight_up_down
        else
            return rail_subtypes.three_way_junction_ends_left
        end
    end

    if top_chunk ~= nil and top_chunk_is_connected_non_rail then
        if left_chunk_is_connected_non_rail then
            return rail_subtypes.curve_bottom_right
        end

        if right_chunk_is_connected_non_rail then
            return rail_subtypes.curve_bottom_left
        end

        if bottom_chunk_is_connected_non_rail then
            if rand < station_threshold then
                return rail_subtypes.station_bottom
            else
                return rail_subtypes.straight_left_right
            end
        end

        if rand < station_threshold then
            return rail_subtypes.station_top
        elseif rand < straight_threshold then
            return rail_subtypes.straight_left_right
        else
            return rail_subtypes.three_way_junction_sides_bottom
        end
    end

    if bottom_chunk ~= nil and bottom_chunk_is_connected_non_rail then
        if left_chunk_is_connected_non_rail then
            return rail_subtypes.curve_top_right
        end

        if right_chunk_is_connected_non_rail then
            return rail_subtypes.curve_top_left
        end

        if top_chunk_is_connected_non_rail then
            if rand < station_threshold then
                return rail_subtypes.station_top
            else
                return rail_subtypes.straight_left_right
            end
        end

        if rand < station_threshold then
            return rail_subtypes.station_bottom
        elseif rand < straight_threshold then
            return rail_subtypes.straight_left_right
        else
            return rail_subtypes.three_way_junction_ends_top
        end
    end

    local options = {
        rail_subtypes.straight_up_down,
        rail_subtypes.straight_left_right,
        rail_subtypes.curve_bottom_right,
        rail_subtypes.curve_bottom_left,
        rail_subtypes.curve_top_right,
        rail_subtypes.curve_top_left,
        rail_subtypes.three_way_junction_sides_bottom,
        rail_subtypes.three_way_junction_sides_top,
        rail_subtypes.three_way_junction_ends_right,
        rail_subtypes.three_way_junction_ends_left,
        rail_subtypes.station_top,
        rail_subtypes.station_right,
        rail_subtypes.station_bottom,
        rail_subtypes.station_left,
    }

    local index = math.random(1, #options)
    -- game.print("Returning new rail origin node with type " .. serpent.line(options[index]))
    return options[index]
end

local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for k, v in pairs(orig) do
            copy[deepcopy(k)] = deepcopy(v)
        end
    else
        copy = orig
    end
    return copy
end

local function generate_room(chunk_indices, surface)
    -- Check the non-diagonal adjacent cells for rails
    -- If there are any incoming, this has to be a rail
    -- If there are only non-rails this can't be a rail
    -- Otherwise this could be a rail, or not
    -- If possible, have at least 1 exit
    -- At most, have 3 exits unless there are 4 incoming rails, then 4

    local left_chunk = chunk_information.get_chunk_data({ x = chunk_indices.x - 1, y = chunk_indices.y})
    local right_chunk = chunk_information.get_chunk_data({ x = chunk_indices.x + 1, y = chunk_indices.y})
    local top_chunk = chunk_information.get_chunk_data({ x = chunk_indices.x, y = chunk_indices.y - 1})
    local bottom_chunk = chunk_information.get_chunk_data({ x = chunk_indices.x, y = chunk_indices.y + 1})

    local left_chunk_subtype = left_chunk and left_chunk.type and left_chunk.type == consts.room_types.RAILWAY and left_chunk.subtype or nil
    local right_chunk_subtype = right_chunk and right_chunk.type and right_chunk.type == consts.room_types.RAILWAY and right_chunk.subtype or nil
    local top_chunk_subtype = top_chunk and top_chunk.type and top_chunk.type == consts.room_types.RAILWAY and top_chunk.subtype or nil
    local bottom_chunk_subtype = bottom_chunk and bottom_chunk.type and bottom_chunk.type == consts.room_types.RAILWAY and bottom_chunk.subtype or nil

    local left_chunk_is_connected_rail = is_left_chunk_connected_rail(left_chunk_subtype)
    local right_chunk_is_connected_rail = is_right_chunk_connected_rail(right_chunk_subtype)
    local top_chunk_is_connected_rail = is_top_chunk_connected_rail(top_chunk_subtype)
    local bottom_chunk_is_connected_rail = is_bottom_chunk_connected_rail(bottom_chunk_subtype)

    local left_chunk_is_connected_non_rail = (left_chunk and not left_chunk_is_connected_rail) or false
    local right_chunk_is_connected_non_rail = right_chunk and not right_chunk_is_connected_rail or false
    local top_chunk_is_connected_non_rail = top_chunk and not top_chunk_is_connected_rail or false
    local bottom_chunk_is_connected_non_rail = bottom_chunk and not bottom_chunk_is_connected_rail or false

    local must_be_rail = left_chunk_is_connected_rail or right_chunk_is_connected_rail or top_chunk_is_connected_rail or bottom_chunk_is_connected_rail
    if must_be_rail then
        local incoming_rail_count = (left_chunk_is_connected_rail and 1 or 0) +
            (right_chunk_is_connected_rail and 1 or 0) +
            (right_chunk_is_connected_rail and 1 or 0) +
            (bottom_chunk_is_connected_rail and 1 or 0)

        local rails

        if incoming_rail_count == 4 then
            -- game.print("Returning 4 way rail connection")
            rails = deepcopy(get_four_way_connection())
        elseif incoming_rail_count == 3 then
            -- game.print("Returning 3 or 4 way rail connection")
            rails = deepcopy(get_three_or_four_way_connection(
                left_chunk_is_connected_non_rail,
                right_chunk_is_connected_non_rail,
                top_chunk_is_connected_non_rail,
                bottom_chunk_is_connected_non_rail))
        elseif incoming_rail_count == 2 then
            -- game.print("Returning 3 way rail connection")
            rails = deepcopy(get_three_way_connection(
                left_chunk,
                right_chunk,
                top_chunk,
                bottom_chunk,
                left_chunk_is_connected_non_rail,
                right_chunk_is_connected_non_rail,
                top_chunk_is_connected_non_rail,
                bottom_chunk_is_connected_non_rail))
        else
            -- game.print("Returning 2 or 3 way rail connection")
            rails = deepcopy(get_two_or_three_way_connection(
                left_chunk,
                right_chunk,
                top_chunk,
                bottom_chunk,
                left_chunk_is_connected_non_rail,
                right_chunk_is_connected_non_rail,
                top_chunk_is_connected_non_rail,
                bottom_chunk_is_connected_non_rail))
        end

        chunk_information.set_chunk_data(chunk_indices, rails)
        return rails
    end

    local cannot_be_rail = left_chunk_is_connected_non_rail and right_chunk_is_connected_non_rail and top_chunk_is_connected_non_rail and bottom_chunk_is_connected_non_rail
    if cannot_be_rail then
        game.print("Rail segment at position " .. serpent.line(chunk_indices) .. " cannot be generated, returning nil")
        return nil
    end

    local rail_creation_chance = 0.125
    local create_rail = math.random() < rail_creation_chance

    if not create_rail then
        -- game.print("Random selection is not creating a rail at position " .. serpent.line(chunk_indices))
        return nil
    end

    local rails = deepcopy(get_two_or_three_way_connection(
        left_chunk_is_connected_non_rail,
        right_chunk_is_connected_non_rail,
        top_chunk_is_connected_non_rail,
        bottom_chunk_is_connected_non_rail))
    chunk_information.set_chunk_data(chunk_indices, rails)
    return rails
end

return {
    generate_room = generate_room,
    spawn_room = spawn_room
}
