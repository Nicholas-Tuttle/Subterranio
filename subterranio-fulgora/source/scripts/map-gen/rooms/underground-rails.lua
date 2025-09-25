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
    dead_end_top_entrance = {
        type = consts.room_types.RAILWAY, subtype = "dead_end_top_entrance", right_side_open = false, left_side_open = false, top_side_open = true, bottom_side_open = false
    },
    dead_end_right_entrance = {
        type = consts.room_types.RAILWAY, subtype = "dead_end_right_entrance", right_side_open = true, left_side_open = false, top_side_open = false, bottom_side_open = false
    },
    dead_end_bottom_entrance = {
        type = consts.room_types.RAILWAY, subtype = "dead_end_bottom_entrance", right_side_open = false, left_side_open = false, top_side_open = false, bottom_side_open = true
    },
    dead_end_left_entrance = {
        type = consts.room_types.RAILWAY, subtype = "dead_end_left_entrance", right_side_open = false, left_side_open = true, top_side_open = false, bottom_side_open = false
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
    log("Spawning rails of type " .. room_type .. " at bounding box " .. serpent.line(chunk_indices))

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

local left_connected_subtypes = {}
for _, value in pairs(rail_subtypes) do
    if value.right_side_open then
        left_connected_subtypes[value.subtype] = true
    end
end
local function is_left_chunk_connected_rail(chunk_subtype)
    return chunk_subtype and left_connected_subtypes[chunk_subtype] ~= nil
end

local right_connected_subtypes = {}
for _, value in pairs(rail_subtypes) do
    if value.left_side_open then
        right_connected_subtypes[value.subtype] = true
    end
end
local function is_right_chunk_connected_rail(chunk_subtype)
    return chunk_subtype and right_connected_subtypes[chunk_subtype] ~= nil
end

local top_connected_subtypes = {}
for _, value in pairs(rail_subtypes) do
    if value.bottom_side_open then
        top_connected_subtypes[value.subtype] = true
    end
end
local function is_top_chunk_connected_rail(chunk_subtype)
    return chunk_subtype and top_connected_subtypes[chunk_subtype] ~= nil
end

local bottom_connected_subtypes = {}
for _, value in pairs(rail_subtypes) do
    if value.top_side_open then
        bottom_connected_subtypes[value.subtype] = true
    end
end
local function is_bottom_chunk_connected_rail(chunk_subtype)
    return chunk_subtype and bottom_connected_subtypes[chunk_subtype] ~= nil
end

local left_disconnected_subtypes = {}
for _, value in pairs(rail_subtypes) do
    if not value.right_side_open then
        left_disconnected_subtypes[value.subtype] = true
    end
end
local function is_left_chunk_non_connected_rail(chunk_subtype)
    return chunk_subtype and left_disconnected_subtypes[chunk_subtype] ~= nil
end

local right_disconnected_subtypes = {}
for _, value in pairs(rail_subtypes) do
    if not value.left_side_open then
        right_disconnected_subtypes[value.subtype] = true
    end
end
local function is_right_chunk_non_connected_rail(chunk_subtype)
    return chunk_subtype and right_disconnected_subtypes[chunk_subtype] ~= nil
end

local top_disconnected_subtypes = {}
for _, value in pairs(rail_subtypes) do
    if not value.bottom_side_open then
        top_disconnected_subtypes[value.subtype] = true
    end
end
local function is_top_chunk_non_connected_rail(chunk_subtype)
    return chunk_subtype and top_disconnected_subtypes[chunk_subtype] ~= nil
end

local bottom_disconnected_subtypes = {}
for _, value in pairs(rail_subtypes) do
    if not value.top_side_open then
        bottom_disconnected_subtypes[value.subtype] = true
    end
end
local function is_bottom_chunk_non_connected_rail(chunk_subtype)
    return chunk_subtype and bottom_disconnected_subtypes[chunk_subtype] ~= nil
end

-- This doesn't handle the case where a rail thinks it can connect to the adjacent tile but that tile has a station connection.
-- I think the solution is that when a station is made it needs to also generate the room that it is connected to
local function get_connection(chunk_indices)
    local left_chunk = chunk_information.get_chunk_data({ x = chunk_indices.x - 1, y = chunk_indices.y})
    local right_chunk = chunk_information.get_chunk_data({ x = chunk_indices.x + 1, y = chunk_indices.y})
    local top_chunk = chunk_information.get_chunk_data({ x = chunk_indices.x, y = chunk_indices.y - 1})
    local bottom_chunk = chunk_information.get_chunk_data({ x = chunk_indices.x, y = chunk_indices.y + 1})

    local left_chunk_subtype = left_chunk and left_chunk.type and left_chunk.type == consts.room_types.RAILWAY and left_chunk.subtype or nil
    local right_chunk_subtype = right_chunk and right_chunk.type and right_chunk.type == consts.room_types.RAILWAY and right_chunk.subtype or nil
    local top_chunk_subtype = top_chunk and top_chunk.type and top_chunk.type == consts.room_types.RAILWAY and top_chunk.subtype or nil
    local bottom_chunk_subtype = bottom_chunk and bottom_chunk.type and bottom_chunk.type == consts.room_types.RAILWAY and bottom_chunk.subtype or nil

    if left_chunk_subtype == rail_subtypes.station_right.subtype or
        right_chunk_subtype == rail_subtypes.station_left.subtype or
        top_chunk_subtype == rail_subtypes.station_bottom.subtype or
        bottom_chunk_subtype == rail_subtypes.station_top.subtype then
        return nil
    end

    local left_chunk_must_be_connected = is_left_chunk_connected_rail(left_chunk_subtype)
    local left_chunk_cannot_be_connected = is_left_chunk_non_connected_rail(left_chunk_subtype) or (left_chunk and not left_chunk_must_be_connected and left_chunk.type ~= consts.room_types.RAILWAY) or false

    local right_chunk_must_be_connected = is_right_chunk_connected_rail(right_chunk_subtype)
    local right_chunk_cannot_be_connected = is_right_chunk_non_connected_rail(right_chunk_subtype) or (right_chunk and not right_chunk_must_be_connected and right_chunk.type ~= consts.room_types.RAILWAY) or false

    local top_chunk_must_be_connected = is_top_chunk_connected_rail(top_chunk_subtype)
    local top_chunk_cannot_be_connected = is_top_chunk_non_connected_rail(top_chunk_subtype) or (top_chunk and not top_chunk_must_be_connected and top_chunk.type ~= consts.room_types.RAILWAY) or false

    local bottom_chunk_must_be_connected = is_bottom_chunk_connected_rail(bottom_chunk_subtype)
    local bottom_chunk_cannot_be_connected = is_bottom_chunk_non_connected_rail(bottom_chunk_subtype) or (bottom_chunk and not bottom_chunk_must_be_connected and bottom_chunk.type ~= consts.room_types.RAILWAY) or false

    local possible_subtypes = {}
    for _, value in pairs(rail_subtypes) do
        possible_subtypes[value.subtype] = true
    end

    for _, value in pairs(rail_subtypes) do
        if (left_chunk_must_be_connected and not value.left_side_open) or
            (left_chunk_cannot_be_connected and value.left_side_open) or
            (right_chunk_must_be_connected and not value.right_side_open) or
            (right_chunk_cannot_be_connected and value.right_side_open) or
            (top_chunk_must_be_connected and not value.top_side_open) or
            (top_chunk_cannot_be_connected and value.top_side_open) or
            (bottom_chunk_must_be_connected and not value.bottom_side_open) or
            (bottom_chunk_cannot_be_connected and value.bottom_side_open) then
            possible_subtypes[value.subtype] = nil
        end
    end

    if (left_chunk_subtype ~= nil) then
        possible_subtypes[rail_subtypes.station_left.subtype] = nil
    end

    if (right_chunk_subtype ~= nil) then
        possible_subtypes[rail_subtypes.station_right.subtype] = nil
    end

    if (top_chunk_subtype ~= nil) then
        possible_subtypes[rail_subtypes.station_top.subtype] = nil
    end

    if (bottom_chunk_subtype ~= nil) then
        possible_subtypes[rail_subtypes.station_bottom.subtype] = nil
    end

    local possible_keys = {}
    for key, _ in pairs(possible_subtypes) do
        possible_keys[#possible_keys + 1] = key
    end

    local rail_creation_chance = 0.125
    local create_rail = math.random() < rail_creation_chance or left_chunk_must_be_connected or right_chunk_must_be_connected or top_chunk_must_be_connected or bottom_chunk_must_be_connected

    if (#possible_keys > 0 and create_rail) then
        return rail_subtypes[possible_keys[math.random(1, #possible_keys)]]
    else
        return nil
    end
end

local function deepcopy(value)
    local orig_type = type(value)
    local copy
    if orig_type == 'table' then
        copy = {}
        for k, v in pairs(value) do
            copy[deepcopy(k)] = deepcopy(v)
        end
    else
        copy = value
    end
    return copy
end

local function generate_room(chunk_indices)
    local rails = deepcopy(get_connection(chunk_indices))
    chunk_information.set_chunk_data(chunk_indices, rails)
    log("Generated rails at position: " ..serpent.line(chunk_indices) .. ", " .. serpent.line(rails))
    return rails
end

return {
    generate_room = generate_room,
    spawn_room = spawn_room
}
