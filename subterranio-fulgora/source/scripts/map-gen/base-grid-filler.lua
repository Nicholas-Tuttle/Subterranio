local base_room_16 = require("base-room-size-sixteen")
local base_room_32 = require("base-room-size-thirty-two")
local chunk_information = require("chunk-information")
local consts = require("map-gen-constants")

local function generate_base_rooms(next_chunk_indices, surface, entrance_position)
    -- game.print("Generating base room at chunk indices: " .. serpent.line(next_chunk_indices))

    local chunk_info = chunk_information.get_chunk_data(surface.name, next_chunk_indices.x, next_chunk_indices.y)

    -- game.print("Chunk info: " .. serpent.line(chunk_info))

    if chunk_info ~= nil then
        if chunk_info.type == consts.room_types.STARTING_AREA or chunk_info.type == consts.room_types.SIZE_32 then
            return
        elseif not base_room_16.new_room_needed(surface, next_chunk_indices, entrance_position) then
            return
        end
    end

    -- game.print("Chunk info is nil, creating a new chunk")

    local grid_size = 0
    if (chunk_info == nil) then
        math.randomseed(next_chunk_indices.x, next_chunk_indices.y)
        local grid_size_random = math.random()
        grid_size = 16
        -- if grid_size_random >= 0.9 then
        if grid_size_random >= 0 then
            grid_size = 32
        end
    else
        if (chunk_info.type == consts.room_types.SIZE_16) then
            grid_size = 16
        elseif (chunk_info.type == consts.room_types.SIZE_32 or chunk_info.type == consts.room_types.STARTING_AREA) then
            grid_size = 32
        else
            game.print("ERROR - trying to generate a room in a pre-existing chunk for an unknown size")
        end
    end

    if grid_size == 32 then
        local chunk_bounding_box = chunk_information.bounding_box_from_chunk_indices(next_chunk_indices)
        base_room_32.generate_room(chunk_bounding_box, surface)
    elseif grid_size == 16 then
        base_room_16.generate_room(next_chunk_indices, surface, entrance_position)
    end
end

return {
    generate_base_rooms = generate_base_rooms
}
