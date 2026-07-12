local consts = require("scripts.map-gen.map-gen-constants")
local chunk_information = require("scripts.map-gen.chunk-information")
local layout_utils = require("scripts.map-gen.rooms.layout-utils")

local function create_tiles(bounding_box, surface)
    local left_x = bounding_box.left_top.x
    local right_x = bounding_box.right_bottom.x
    local bottom_y = bounding_box.right_bottom.y
    local top_y = bounding_box.left_top.y

    local tiles = {}
    local index = 0
    for i = left_x, right_x - 1, 1 do
        for j = top_y, bottom_y - 1, 1 do
            tiles[index] = {
                position = { x = i, y = j },
                name = "tutorial-grid"
            }
            index = index + 1
        end
    end

    local correct_tiles = true
    local remove_colliding_entities = true
    local remove_colliding_decoratives = true
    surface.set_tiles(tiles, correct_tiles, remove_colliding_entities, remove_colliding_decoratives)
end

local gate_definitions = {
    left = {
        { x = 0, y = 3, direction = defines.direction.north },
        { x = 0, y = 4, direction = defines.direction.north },
        { x = 0, y = 27, direction = defines.direction.north },
        { x = 0, y = 28, direction = defines.direction.north }
    },
    right = {
        { x = 31, y = 3, direction = defines.direction.north },
        { x = 31, y = 4, direction = defines.direction.north },
        { x = 31, y = 27, direction = defines.direction.north },
        { x = 31, y = 28, direction = defines.direction.north }
    },
    bottom = {
        { x = 3, y = 31, direction = defines.direction.east },
        { x = 4, y = 31, direction = defines.direction.east },
        { x = 27, y = 31, direction = defines.direction.east },
        { x = 28, y = 31, direction = defines.direction.east }
    },
    top = {
        { x = 3, y = 0, direction = defines.direction.east },
        { x = 4, y = 0, direction = defines.direction.east },
        { x = 27, y = 0, direction = defines.direction.east },
        { x = 28, y = 0, direction = defines.direction.east }
    }
}

local function build_room_layout(left_x, right_x, top_y, bottom_y)
    local wall_definitions = {}

    local function add_wall(position, orientation)
        for index, definition in ipairs(wall_definitions) do
            if definition.position.x == position.x and definition.position.y == position.y then
                wall_definitions[index] = {
                    position = position,
                    orientation = orientation
                }
                return
            end
        end

        wall_definitions[#wall_definitions + 1] = {
            position = position,
            orientation = orientation
        }
    end

    local active_sides = {}
    if left_x == -32 then
        active_sides.left = true
    end
    if right_x == 31 then
        active_sides.right = true
    end
    if top_y == -32 then
        active_sides.top = true
    end
    if bottom_y == 31 then
        active_sides.bottom = true
    end

    if active_sides.left then
        for y = top_y, bottom_y, 1 do
            if not ((active_sides.top and y == top_y) or (active_sides.bottom and y == bottom_y)) then
                add_wall({ x = left_x, y = y }, "north-to-south")
            end
        end
    end

    if active_sides.right then
        for y = top_y, bottom_y, 1 do
            if not ((active_sides.top and y == top_y) or (active_sides.bottom and y == bottom_y)) then
                add_wall({ x = right_x, y = y }, "north-to-south")
            end
        end
    end

    if active_sides.top then
        for x = left_x, right_x, 1 do
            if not ((active_sides.left and x == left_x) or (active_sides.right and x == right_x)) then
                add_wall({ x = x, y = top_y }, "west-to-east")
            end
        end
    end

    if active_sides.bottom then
        for x = left_x, right_x, 1 do
            if not ((active_sides.left and x == left_x) or (active_sides.right and x == right_x)) then
                add_wall({ x = x, y = bottom_y }, "west-to-east")
            end
        end
    end

    if active_sides.left and active_sides.top then
        add_wall({ x = left_x, y = top_y }, "south-to-east")
    end
    if active_sides.right and active_sides.top then
        add_wall({ x = right_x, y = top_y }, "south-to-west")
    end
    if active_sides.left and active_sides.bottom then
        add_wall({ x = left_x, y = bottom_y }, "north-to-east")
    end
    if active_sides.right and active_sides.bottom then
        add_wall({ x = right_x, y = bottom_y }, "north-to-west")
    end

    local room_gate_definitions = {}
    for _, side in ipairs({ "left", "right", "bottom", "top" }) do
        room_gate_definitions[side] = {}
        for _, definition in ipairs(gate_definitions[side] or {}) do
            room_gate_definitions[side][#room_gate_definitions[side] + 1] = {
                position = { x = left_x + definition.x, y = top_y + definition.y },
                direction = definition.direction
            }
        end
    end

    return wall_definitions, room_gate_definitions, function(side)
        return active_sides[side]
    end
end

local function create_entities(bounding_box, surface)
    local left_x = bounding_box.left_top.x
    local right_x = bounding_box.right_bottom.x - 1
    local bottom_y = bounding_box.right_bottom.y - 1
    local top_y = bounding_box.left_top.y

    local wall_definitions, room_gate_definitions, should_place_gate = build_room_layout(left_x, right_x, top_y, bottom_y)
    layout_utils.build_and_place_room_layout(surface, wall_definitions, room_gate_definitions, should_place_gate)
end

local function spawn_room(bounding_box, surface)
    create_tiles(bounding_box, surface)
    create_entities(bounding_box, surface)
end

local function generate_room(chunk_indices)
    local right_side_connected = false
    local left_side_connected = false
    local bottom_side_connected = false
    local top_side_connected = false

    if chunk_indices.x < 0 then
        right_side_connected = true
    else
        left_side_connected = true
    end

    if chunk_indices.y < 0 then
        bottom_side_connected = true
    else
        top_side_connected = true
    end

    return {
        type = consts.room_types.STARTING_AREA,
        right_side_connected = right_side_connected,
        left_side_connected = left_side_connected,
        bottom_side_connected = bottom_side_connected,
        top_side_connected = top_side_connected
    }
end

local function fulgoran_gate_destroyed(destroyed_entity_position)
    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(destroyed_entity_position.x, destroyed_entity_position.y)
    local x_offset = math.floor(destroyed_entity_position.x - chunk_indices.x * 32)
    local y_offset = math.floor(destroyed_entity_position.y - chunk_indices.y * 32)

    if (x_offset == 0) then
        return {
            x = chunk_indices.x - 1,
            y = chunk_indices.y
        }
    elseif (x_offset == 31) then
        return {
            x = chunk_indices.x + 1,
            y = chunk_indices.y
        }
    elseif (y_offset == 0) then
        return {
            x = chunk_indices.x,
            y = chunk_indices.y - 1
        }
    elseif (y_offset == 31) then
        return {
            x = chunk_indices.x,
            y = chunk_indices.y + 1
        }
    else
        return chunk_indices
    end
end

return {
    generate_room = generate_room,
    spawn_room = spawn_room,
    fulgoran_gate_destroyed = fulgoran_gate_destroyed
}