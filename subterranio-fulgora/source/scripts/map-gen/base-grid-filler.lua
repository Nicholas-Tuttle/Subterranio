local starting_area = require("rooms.starting-area")
local underground_vault = require("rooms.underground-vault")
local underground_rails = require("rooms.underground-rails")
local base_room_32 = require("rooms.base-room-size-thirty-two")
local chunk_information = require("scripts.map-gen.chunk-information")
local consts = require("scripts.map-gen.map-gen-constants")

local function spawn_room(surface, chunk_indices)
    local chunks_to_spawn = {chunk_indices}
    local index = 1
    local max_index = index + 1
    while index < max_index do
        local indices = chunks_to_spawn[index]
        if indices ~= nil then
            local room = chunk_information.get_chunk_data(indices)
            -- game.print(serpent.block(room))
            if room ~= nil and room.type ~= nil and (room.spawned == nil or not room.spawned) then
                local bounding_box = chunk_information.bounding_box_from_chunk_indices(indices)
                if room.type == consts.room_types.STARTING_AREA then
                    starting_area.spawn_room(bounding_box, surface)
                elseif room.type == consts.room_types.VAULT then
                    underground_vault.spawn_room(bounding_box, surface)
                elseif room.type == consts.room_types.RAILWAY then
                    underground_rails.spawn_room(bounding_box, surface)
                elseif room.type == consts.room_types.SIZE_32 then
                    base_room_32.spawn_room(bounding_box, surface)
                else
                    game.print("Would have spawned some other room")
                end

                if (room.right_side_connected) then
                    -- game.print("Spawning right side chunk for origin " .. serpent.line(indices))
                    chunks_to_spawn[max_index] = { x = indices.x + 1, y = indices.y }
                    max_index = max_index + 1
                end

                if (room.left_side_connected) then
                    -- game.print("Spawning left side chunk for origin " .. serpent.line(indices))
                    chunks_to_spawn[max_index] = { x = indices.x - 1, y = indices.y }
                    max_index = max_index + 1
                end

                if (room.top_side_connected) then
                    -- game.print("Spawning top side chunk for origin " .. serpent.line(indices))
                    chunks_to_spawn[max_index] = { x = indices.x, y = indices.y - 1 }
                    max_index = max_index + 1
                end

                if (room.bottom_side_connected) then
                    -- game.print("Spawning bottom side chunk for origin " .. serpent.line(indices))
                    chunks_to_spawn[max_index] = { x = indices.x, y = indices.y + 1 }
                    max_index = max_index + 1
                end

                room.spawned = true
                chunk_information.set_chunk_data(indices, room)
            else
                -- game.print("Skipping room at indices ".. serpent.line(indices) .." spawn: " .. (room and serpent.line(room) or "nil"))
            end
        else
            game.print("Chunk indices at index " .. index .. " was nil")
        end

        index = index + 1
    end
end

return {
    spawn_room = spawn_room
}
