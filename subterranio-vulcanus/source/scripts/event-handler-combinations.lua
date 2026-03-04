local chunk_information = require("scripts.chunk-information")

local schedule = {}
local function schedule_infant_demolisher_spawn(tick, position)
    local effect_delay_ticks = 0
    local spawn_delay_ticks = 60 * 1.5
    local effect_tick = tick + effect_delay_ticks
    local spawn_tick = tick + spawn_delay_ticks

    schedule[effect_tick] = {
        event = "effect",
        position = position
    }

    schedule[spawn_tick] = {
        event = "spawn",
        position = position
    }
end

local function spawn_infant_demolisher_effects(surface, position)
    -- big-demolisher-expanding-ash-cloud-1 - The circle of ash and the sound
    surface.create_entity({ name = "big-demolisher-expanding-ash-cloud-1", position = position, force = "enemy" })
    -- big-demolisher-erupting-fissure - The big lava explosion and damage
    surface.create_entity({ name = "big-demolisher-fissure", position = position, force = "enemy" })
end

local function spawn_infant_demolisher(surface, position)
    surface.create_entity({ name = "infant-demolisher", position = position, force = "enemy" })
end

local empty_chunks = {}

local on_built_chance = 1 / 4
-- These are really annoying to build with the rail planner so specifically allowlist rails
local allowlisted_entities = {
    ["rail"] = true,
    ["straight-rail"] = true,
    ["curved-rail-a"] = true,
    ["curved-rail-b"] = true,
    ["half-diagonal-rail"] = true,
    ["rail-ramp"] = true,
    ["rail-support"] = true,
    ["elevated-rail"] = true,
    ["elevated-straight-rail"] = true,
    ["elevated-curved-rail-a"] = true,
    ["elevated-curved-rail-b"] = true,
    ["elevated-half-diagonal-rail"] = true,
}

local function on_built(event)
    local entity = event.entity
    local position = event.entity.position

    if (entity.surface.name ~= "vulcanus_lava_tubes") then
        return
    end

    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(position.x, position.y)
    local chunk_info = chunk_information.get_chunk_data(chunk_indices)
    if (chunk_info) then
        chunk_info.entity_count = chunk_info.entity_count + 1
        empty_chunks[chunk_indices] = nil
    end
    chunk_information.set_chunk_data(chunk_information.chunk_indices_from_raw_coordinates(position.x, position.y), chunk_info)

    if (allowlisted_entities[entity.name]) then
        return
    end

    local position = entity.position
    local surface = entity.surface
    local radius = math.random(8, 16)
    local nearby_entities_count = surface.count_entities_filtered({ position = position, radius = radius, force = "player" })
    local roll = math.random()

    -- If this is the first entity built then potentially spawn an infant demolisher
    if (nearby_entities_count <= 1 and roll < on_built_chance) then
        schedule_infant_demolisher_spawn(event.tick, position)
    end
end

script.on_event(defines.events.on_built_entity, on_built)
script.on_event(defines.events.on_robot_built_entity, on_built)

local function on_pre_destroyed(event)
    local entity = event.entity
    local position = event.entity.position

    if (entity.surface.name ~= "vulcanus_lava_tubes") then
        return
    end

    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(position.x, position.y)
    local chunk_info = chunk_information.get_chunk_data(chunk_indices)
    if (chunk_info) then
        chunk_info.entity_count = chunk_info.entity_count - 1
        if (chunk_info.entity_count <= 0) then
            empty_chunks[chunk_indices] = true
        end
    end
    chunk_information.set_chunk_data(chunk_information.chunk_indices_from_raw_coordinates(position.x, position.y), chunk_info)
end

script.on_event(defines.events.on_pre_player_mined_item, on_pre_destroyed)
script.on_event(defines.events.on_entity_died, on_pre_destroyed)
script.on_event(defines.events.on_robot_pre_mined, on_pre_destroyed)

local on_tick_spawn_chance = 1 / 60 / 30 -- 1 in 30 seconds on average

local function tableKeys(tbl)
    local keys = {}
    for k, _ in pairs(tbl) do
        table.insert(keys, k)
    end
    return keys
end

local function on_tick(event)
    -- if (event.tick % 600 == 0) then
    --     game.print("Empty chunks: " .. serpent.line(empty_chunks))
    -- end

    if (math.random() < on_tick_spawn_chance) then
        local keys = tableKeys(empty_chunks)
        -- game.print("Considering spawning infant demolisher, empty chunks: " .. serpent.line(keys))
        if (#keys == 0) then
            return
        end
        local index = math.random(#keys)
        local chunk_indices = keys[index]
        local bounding_box = chunk_information.bounding_box_from_chunk_indices(chunk_indices)
        local x = (bounding_box.left_top.x + bounding_box.right_bottom.x) / 2
        local y = (bounding_box.left_top.y + bounding_box.right_bottom.y) / 2
        -- game.print("Scheduling infant demolisher spawn in chunk " .. serpent.line(chunk_indices) .. " at coordinates " .. x .. ", " .. y)
        local spawn_position = game.surfaces["vulcanus_lava_tubes"].find_non_colliding_position("infant-demolisher", { x, y }, 32, 2)
        if (spawn_position == nil) then
            return
        end
        game.print("Spawning infant demolisher at " .. spawn_position.x .. ", " .. spawn_position.y)
        schedule_infant_demolisher_spawn(event.tick, spawn_position)
    end

    if (schedule[event.tick]) then
        local position = schedule[event.tick].position
        if (schedule[event.tick].event == "effect") then
            spawn_infant_demolisher_effects(game.surfaces["vulcanus_lava_tubes"], position)
        elseif (schedule[event.tick].event == "spawn") then
            spawn_infant_demolisher(game.surfaces["vulcanus_lava_tubes"], position)
        end
        schedule[event.tick] = nil
    end
end

script.on_event(defines.events.on_tick, on_tick)

script.on_event(defines.events.on_chunk_generated, function(event)
    if event.surface.name == "vulcanus_lava_tubes" then
        -- game.print("Chunk generated at " .. event.area.left_top.x .. ", " .. event.area.left_top.y)
        local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(event.area.left_top.x, event.area.left_top.y)
        chunk_information.set_chunk_data(chunk_indices, {
            entity_count = 0
        })
        -- game.print("Setting chunk info for chunk " .. serpent.line(chunk_indices))
        empty_chunks[chunk_indices] = true
    end
end)
