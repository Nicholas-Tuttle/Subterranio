local base_grid_filler = require("base-grid-filler")
local chunk_information = require("scripts.map-gen.chunk-information")
local map_gen_constants = require("scripts.map-gen.map-gen-constants")
local starting_area = require("rooms.starting-area")
local underground_vault = require("rooms.underground-vault")
local underground_rails = require("scripts.map-gen.rooms.underground-rails")
local base_room_32 = require("base-room-size-thirty-two")

local function generate_room(chunk_indices)
    -- Starting area gets top priority
    if ((chunk_indices.x == -1 or chunk_indices.x == 0) and (chunk_indices.y == -1 or chunk_indices.y == 0)) then
        return starting_area.generate_room(chunk_indices)
    end

    -- Fulgoran vault ruins get next priority (this might be filled in already)
    local chunk_info = chunk_information.get_chunk_data(chunk_indices)
    if chunk_info and chunk_info.type == map_gen_constants.room_types.VAULT then
        return underground_vault.generate_room()
    end

    -- Then check if rails must/can be made
    local rails = underground_rails.generate_room(chunk_indices)
    if rails ~= nil then
        return rails
    end

    -- Otherwise randomize between a size 32/16 room
    return base_room_32.generate_room()
end

local function spawn_room_if_needed(chunk_indices, surface)
    local left_chunk = chunk_information.get_chunk_data({ x = chunk_indices.x - 1, y = chunk_indices.y})
    local right_chunk = chunk_information.get_chunk_data({ x = chunk_indices.x + 1, y = chunk_indices.y})
    local top_chunk = chunk_information.get_chunk_data({ x = chunk_indices.x, y = chunk_indices.y - 1})
    local bottom_chunk = chunk_information.get_chunk_data({ x = chunk_indices.x, y = chunk_indices.y + 1})

    if (left_chunk and left_chunk.right_side_connected and left_chunk.spawned) or (right_chunk and right_chunk.left_side_connected and right_chunk.spawned) or
    (top_chunk and top_chunk.bottom_side_connected and top_chunk.spawned) or (bottom_chunk and bottom_chunk.top_side_connected and bottom_chunk.spawned) then
        base_grid_filler.spawn_room(surface, chunk_indices)
    end
end

local function generate_fulgoran_underground(bounding_box, surface)
    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(bounding_box.left_top.x, bounding_box.left_top.y)
    local room = generate_room(chunk_indices)
    spawn_room_if_needed(chunk_indices, surface)
    chunk_information.set_chunk_data(chunk_indices, room)
    log("Generated room at chunk indices: " .. serpent.line(chunk_indices) .. " with data: " .. serpent.line(room))
end

local function mark_fulgoran_vault_locations(bounding_box, surface)
    -- NOTE: Fulgoran vaults can cross chunk boundaries
    if (surface.count_entities_filtered{
        area = {{ bounding_box.left_top.x, bounding_box.left_top.y }, { bounding_box.right_bottom.x, bounding_box.right_bottom.y }},
        name = "fulgoran-ruin-vault"
    } >= 1) then
        local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(bounding_box.left_top.x, bounding_box.left_top.y)
        chunk_information.set_chunk_data(chunk_indices, {
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
        mark_fulgoran_vault_locations(event.area, event.surface)
        generate_fulgoran_underground(event.area, event.surface)
    elseif event.surface.name == "fulgora" then
        mark_fulgoran_vault_locations(event.area, event.surface)
    end
end)

script.on_event(defines.events.on_entity_died, function (event)
    local destroyed_entity_position = {
        x = math.floor(event.entity.position.x),
        y = math.floor(event.entity.position.y)
    }
    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(destroyed_entity_position.x, destroyed_entity_position.y)
    local chunk = chunk_information.get_chunk_data(chunk_indices)

    if chunk == nil then
        return
    end

    local next_chunk_indices = nil
    if chunk.type == map_gen_constants.room_types.STARTING_AREA then
        next_chunk_indices = starting_area.fulgoran_gate_destroyed(destroyed_entity_position)
    elseif chunk.type == map_gen_constants.room_types.VAULT then
        next_chunk_indices = underground_vault.fulgoran_gate_destroyed(destroyed_entity_position)
    elseif chunk.type == map_gen_constants.room_types.SIZE_32 then
        next_chunk_indices = base_room_32.fulgoran_gate_destroyed(destroyed_entity_position)
    elseif chunk.type == map_gen_constants.room_types.RAILWAY then
        next_chunk_indices = underground_rails.fulgoran_gate_destroyed(destroyed_entity_position)
    end

    if next_chunk_indices == nil then
        return
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

    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(target_position.x, target_position.y)
    local surface = game.surfaces[surface_name]
    base_grid_filler.spawn_room(surface, chunk_indices)
end

return {
    pre_tunnelling_callback = pre_tunnelling_callback
}