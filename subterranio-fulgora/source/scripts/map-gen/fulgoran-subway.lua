local base_grid_filler = require("base-grid-filler")
local chunk_information = require("chunk-information")
local map_gen_constants = require("scripts.map-gen.map-gen-constants")
local starting_area = require("rooms.starting-area")
local underground_vault = require("rooms.underground-vault")
local base_room_16 = require("base-room-size-sixteen")
local base_room_32 = require("base-room-size-thirty-two")

local function clear_tiles(bounding_box, surface)
    local tiles = {}
    local index = 0
    for i = bounding_box.left_top.x, bounding_box.right_bottom.x - 1, 1 do
        for j = bounding_box.left_top.y, bounding_box.right_bottom.y - 1, 1 do
            tiles[index] = {
                position = { x = i, y = j },
                name = "out-of-map"
            }
            index = index + 1
        end
    end
    local correct_tiles = true
    local remove_colliding_entities = true
    local remove_colliding_decoratives = true
    surface.set_tiles(tiles, correct_tiles, remove_colliding_entities, remove_colliding_decoratives)
end

local function generate_room(chunk_indices, surface)
    -- Starting area gets top priority
    if ((chunk_indices.x == -1 or chunk_indices.x == 0) and (chunk_indices.y == -1 or chunk_indices.y == 0)) then
        return starting_area.generate_room(chunk_indices)
    end

    -- Fulgoran vault ruins get next priority (this might be filled in already)
    local chunk_info = chunk_information.get_chunk_data(surface.name, chunk_indices.x, chunk_indices.y)
    if chunk_info and chunk_info.type == map_gen_constants.room_types.VAULT then
        return underground_vault.generate_room()
    end

    -- Then check if rails must/can be made

    -- Otherwise randomize between a size 32/16 room
    return base_room_32.generate_room()
end

local function generate_fulgoran_underground(bounding_box, surface)
    clear_tiles(bounding_box, surface)
    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(bounding_box.left_top.x, bounding_box.left_top.y)
    local room = generate_room(chunk_indices, surface)
    chunk_information.set_chunk_data(surface.name, chunk_indices.x, chunk_indices.y, room)
end

local function mark_fulgoran_vault_locations(bounding_box, surface)
    -- NOTE: Fulgoran vaults can cross chunk boundaries
    if (surface.count_entities_filtered{
        area = {{ bounding_box.left_top.x, bounding_box.left_top.y }, { bounding_box.right_bottom.x, bounding_box.right_bottom.y }},
        name = "fulgoran-ruin-vault"
    } >= 1) then
        local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(bounding_box.left_top.x, bounding_box.left_top.y)
        chunk_information.set_chunk_data("fulgoran_subway", chunk_indices.x, chunk_indices.y, {
            type = map_gen_constants.room_types.VAULT
        })
    end
end

local function force_generate_fulgoran_surface(position)
    local target_surface = game.planets["fulgora"].create_surface()
    local target_position = {x = position.x, y = position.y}
    target_surface.request_to_generate_chunks(target_position, 1)
    target_surface.force_generate_chunk_requests()
end

script.on_event(defines.events.on_chunk_generated, function(event)
    if event.surface.name == "fulgoran_subway" then
        force_generate_fulgoran_surface(event.area.left_top)
        generate_fulgoran_underground(event.area, event.surface)
    elseif event.surface.name == "fulgora" then
        mark_fulgoran_vault_locations(event.area, event.surface)
    end
end)

local function get_destination_chunk_indicies(chunk_indices, position)
    local x_offset = math.floor(position.x - chunk_indices.x * 32)
    local y_offset = math.floor(position.y - chunk_indices.y * 32)

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

script.on_event(defines.events.on_entity_died, function (event)
    local entrance_position = {
        x = math.floor(event.entity.position.x),
        y = math.floor(event.entity.position.y)
    }
    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(entrance_position.x, entrance_position.y)
    local next_chunk_indices = get_destination_chunk_indicies(chunk_indices, entrance_position)

    if (chunk_indices.x == next_chunk_indices.x and chunk_indices.y == next_chunk_indices.y) then
        return
    end

    local room = chunk_information.get_chunk_data(event.entity.surface.name, chunk_indices.x, chunk_indices.y)
    if (room ~= nil) then
        if (next_chunk_indices.x > chunk_indices.x) then
            room.right_side_open = true
        elseif (next_chunk_indices.x < chunk_indices.x) then
            room.left_side_open = true
        elseif (next_chunk_indices.y < chunk_indices.y) then
            room.top_side_open = true
        else
            room.bottom_side_open = true
        end
    else
        game.print("Chunk data at indices " .. serpent.line(chunk_indices) .. " is nil")
    end

    base_grid_filler.spawn_room(event.entity.surface, next_chunk_indices)
end,
{
    { filter = "name", name = "fulgoran-gate", force = "neutral" }
})

script.on_event(defines.events.script_raised_built, function(event)
    local entity = event.entity
    if (entity.name == "fulgoran-gate") then
        entity.active = false
    end

    if (entity.name == "fulgoran-wall") then
        entity.destructible = false
    end

    entity.minable_flag = false
    entity.operable = false
end,
{
    { filter = "name", name = "fulgoran-gate", force = "neutral" },
    { filter = "name", name = "fulgoran-wall", force = "neutral" }
})

local function pre_tunnelling_callback(surface_name, target_position)
    if (surface_name ~= "fulgoran_subway") then
        return
    end

    -- game.print("Fulgora pre tunnelling function:" .. surface_name .. " " .. serpent.line(target_position))
    
    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(target_position.x, target_position.y)
    local surface = game.surfaces[surface_name]
    base_grid_filler.spawn_room(surface, chunk_indices)
end

return {
    pre_tunnelling_callback = pre_tunnelling_callback
}