local base_grid = require("base-grid-filler")
local chunk_information = require("chunk-information")
local starting_area = require("starting-area")
local underground_vault = require("underground-vault")
local map_gen_constants = require("map-gen-constants")

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
        return {
            type = map_gen_constants.room_types.STARTING_AREA,
            spawn_immediately = true,
            spawn_room = function (spawn_bounding_box, spawn_surface)
                starting_area.spawn_room(spawn_bounding_box, spawn_surface)
            end
        }
    end

    -- Fulgoran vault ruins get next priority (this might be filled in already)
    local chunk_info = chunk_information.get_chunk_data(surface.name, chunk_indices.x, chunk_indices.y)
    if chunk_info and chunk_info.type == map_gen_constants.room_types.VAULT then
        return {
            type = map_gen_constants.room_types.VAULT,
            spawn_immediately = true,
            spawn_room = function (spawn_bounding_box, spawn_surface)
                underground_vault.spawn_room(spawn_bounding_box, spawn_surface)
            end
        }
    end

    -- Then check if rails must/can be made

    -- Otherwise randomize between a size 32/16 room
    return {
        type = map_gen_constants.room_types.SIZE_32,
        spawn_immediately = false
    }
end

local function generate_fulgoran_underground(bounding_box, surface)
    clear_tiles(bounding_box, surface)
    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(bounding_box.left_top.x, bounding_box.left_top.y)
    local room = generate_room(chunk_indices, surface)

    chunk_information.set_chunk_data(surface.name, chunk_indices.x, chunk_indices.y, room)

    if (room.spawn_immediately) then
        room.spawn_room(bounding_box, surface)
    end
end

local function mark_fulgoran_vault_locations(bounding_box, surface)
    if (surface.count_entities_filtered{
        area = {{ bounding_box.left_top.x, bounding_box.left_top.y }, { bounding_box.right_bottom.x, bounding_box.right_bottom.y }},
        name = "fulgoran-ruin-vault"
    } >= 1) then
        local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(bounding_box.left_top.x, bounding_box.left_top.y)
        chunk_information.set_chunk_data(surface.name, chunk_indices.x, chunk_indices.y, {
            type = map_gen_constants.room_types.VAULT
        })
    end
end

script.on_event(defines.events.on_chunk_generated, function(event)
    if event.surface.name == "fulgoran_subway" then
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

    -- game.print("Current chunk indices {" .. chunk_indices.x .. "," .. chunk_indices.y .. "}, next chunk indices {" .. next_chunk_indices.x .. "," .. next_chunk_indices.y .. "}")

    base_grid.generate_base_rooms(next_chunk_indices, event.entity.surface, entrance_position)
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
