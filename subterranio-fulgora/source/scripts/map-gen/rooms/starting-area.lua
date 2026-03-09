local consts = require("scripts.map-gen.map-gen-constants")
local chunk_information = require("scripts.map-gen.chunk-information")

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
                position = {x = i, y = j},
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

local function create_entities(bounding_box, surface)
    local left_x = bounding_box.left_top.x
    local right_x = bounding_box.right_bottom.x - 1
    local bottom_y = bounding_box.right_bottom.y - 1
    local top_y = bounding_box.left_top.y

    for i = left_x, right_x, 1 do
        for j = top_y, bottom_y, 1 do
            -- Only make walls on the perimeters
            if (left_x == -32 and i == left_x) or
                (right_x == 31 and i == right_x) or
                (top_y == -32 and j == top_y) or
                (bottom_y == 31 and j == bottom_y) then
                local entity_name = consts.wall_entity_name
                local direction = defines.direction.east

                if (i - left_x == 3) or (i - left_x == 4) or (i - left_x == 27) or (i - left_x == 28) then
                    entity_name = consts.gate_entity_name
                end

                if (j - top_y == 3) or (j - top_y == 4) or (j - top_y == 27) or (j - top_y == 28) then
                    entity_name = consts.gate_entity_name
                    direction = defines.direction.north
                end

                surface.create_entity{
                    name = entity_name,
                    direction = direction,
                    position = { i, j },
                    force = "neutral",
                    create_build_effect_smoke = false,
                    move_stuck_players = true,
                    raise_built = true
                }
            end
        end
    end
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