local food_farm = require("size-sixteen-rooms.food-farm")
local chunk_information = require("chunk-information")
local consts = require("map-gen-constants")

local function create_tiles(bounding_box, surface, tile_name)
    local left_x = bounding_box.left_top.x
    local right_x = bounding_box.right_bottom.x - 1
    local bottom_y = bounding_box.right_bottom.y - 1
    local top_y = bounding_box.left_top.y

    local tiles = {}
    local index = 0

    for i = left_x, right_x, 1 do
        for j = top_y, bottom_y, 1 do
            tiles[index] = {
                position = {x = i, y = j},
                name = tile_name
            }
            index = index + 1
        end
    end
    local correct_tiles = true
    local remove_colliding_entities = true
    local remove_colliding_decoratives = true 
    surface.set_tiles(tiles, correct_tiles, remove_colliding_entities, remove_colliding_decoratives)
end

local function create_entities(bounding_box, surface, entrance_position)
    local left_x = bounding_box.left_top.x
    local right_x = bounding_box.right_bottom.x - 1
    local bottom_y = bounding_box.right_bottom.y - 1
    local top_y = bounding_box.left_top.y

    local gate_creation_chance = 0.65
    local create_gate_1 = math.random() <= gate_creation_chance or true
    local create_gate_2 = math.random() <= gate_creation_chance or true
    local create_gate_3 = math.random() <= gate_creation_chance or true
    local create_gate_4 = math.random() <= gate_creation_chance or true

    for i = left_x, right_x, 1 do
        for j = top_y, bottom_y, 1 do
            -- Only make walls on the perimeters
            if i == left_x or i == right_x or j == top_y or j == bottom_y then
                local entity_name = consts.wall_entity_name
                local direction = defines.direction.east

                if (create_gate_1 and (i % 32 == 3 or i % 32 == 4)) or (create_gate_2 and (i % 32 == 27 or i % 32 == 28)) then
                    entity_name = consts.gate_entity_name
                end

                if (create_gate_3 and (j % 32 == 3 or j % 32 == 4)) or (create_gate_4 and (j % 32 == 27 or j % 32 == 28)) then
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

local function get_entrance_subroom_name(entrance_position)
    if (entrance_position.x % 32 >= 16) then
        if (entrance_position.y % 32 >= 16) then
            return "bottom-right"
        else
            return "top-right"
        end
    else
        if (entrance_position.y % 32 >= 16) then
            return "bottom-left"
        else
            return "top-left"
        end
    end
end

local function get_destination_subroom_name(entrance_room_name, entrance_position)
    if (entrance_room_name == "top-left") then
        if (entrance_position.x % 32 > 8 or entrance_position.x % 32 == 0) then
            return "top-right"
        else
            return "bottom-left"
        end
    elseif (entrance_room_name == "top-right") then
        if (entrance_position.x % 32 < 24 or entrance_position.x % 32 == 31) then
            return "top-left"
        else
            return "bottom-right"
        end
    elseif (entrance_room_name == "bottom-left") then
        if (entrance_position.x % 32 > 8 or entrance_position.x % 32 == 0) then
            return "bottom-right"
        else
            return "top-left"
        end
    else
        if (entrance_position.x % 32 < 24 or entrance_position.x % 32 == 31) then
            return "bottom-left"
        else
            return "top-right"
        end
    end
end

local function generate_room(chunk_indices, surface, entrance_position)
    local chunk_bounding_box = chunk_information.bounding_box_from_chunk_indices(chunk_indices)
    local chunk_data = chunk_information.get_chunk_data(surface.name, chunk_indices.x, chunk_indices.y)
    if (chunk_data == nil) then
        chunk_data = {
            type = consts.room_types.SIZE_16,
            subrooms = {}
        }
    end

    local entrance_room_name = get_entrance_subroom_name(entrance_position)
    local destination_room_name = get_destination_subroom_name(entrance_room_name, entrance_position)

    -- game.print("generate_room - Entering from " .. entrance_room_name .. " room and heading into " .. destination_room_name .. " room")

    local room_name_to_offset_index = {
        ["top-left"] = 0,
        ["top-right"] = 1,
        ["bottom-left"] = 2,
        ["bottom-right"] = 3
    }

    local offset_index = room_name_to_offset_index[destination_room_name]

    local left_x_offset = math.floor(((offset_index) % 2)) * 16
    local top_y_offset = math.floor(((offset_index) / 2)) * 16
    local bounding_box = {
        left_top = {
            x = chunk_bounding_box.left_top.x + left_x_offset,
            y = chunk_bounding_box.left_top.y + top_y_offset
        },
        right_bottom = {
            x = chunk_bounding_box.left_top.x + left_x_offset + 16,
            y = chunk_bounding_box.left_top.y + top_y_offset + 16
        }
    }

    create_tiles(bounding_box, surface, "tutorial-grid")
    create_entities(bounding_box, surface, entrance_position)
    if math.random() <= 1.0 then
        food_farm.generate(bounding_box, surface)
    end

    chunk_data.subrooms[destination_room_name] = {}
    chunk_information.set_chunk_data(surface.name, chunk_indices.x, chunk_indices.y, chunk_data)
end

local function new_room_needed(surface, next_chunk_indices, entrance_position)
    local chunk_data = chunk_information.get_chunk_data(surface.name, next_chunk_indices.x, next_chunk_indices.y)
    if (chunk_data == nil) then
        return true
    end

    local entrance_room_name = get_entrance_subroom_name(entrance_position)
    local destination_room_name = get_destination_subroom_name(entrance_room_name, entrance_position)
    -- game.print("new_room_needed - Entering from " .. entrance_room_name .. " room and heading into " .. destination_room_name .. " room")

    return chunk_data.subrooms[destination_room_name] == nil
end

return {
    generate_room = generate_room,
    new_room_needed = new_room_needed
}
