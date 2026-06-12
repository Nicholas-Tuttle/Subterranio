local chunk_information = require("scripts.chunk-information")

local hostile_territory = nil
local scanned_surface_for_hostile_territory = false

local function scan_surface_for_empty_chunks(surface)
    if scanned_surface_for_hostile_territory then
        return
    end

    if hostile_territory ~= nil then
        hostile_territory.destroy()
    end

    local empty_chunks = {}
    for chunk in surface.get_chunks() do
        local entity_count = surface.count_entities_filtered({
            area = chunk.area,
            force = "player"
        })
        if not entity_count or entity_count == 0 then
            empty_chunks[#empty_chunks + 1] = { chunk.x, chunk.y }
        end
    end

    if #empty_chunks > 0 then
        hostile_territory = surface.create_territory {
            chunks = empty_chunks
        }
    end

    if hostile_territory ~= nil then
        local segmented_units = surface.get_segmented_units()
        for _, unit in ipairs(segmented_units) do
            unit.territory = hostile_territory
        end
    end

    scanned_surface_for_hostile_territory = true
end

local function get_or_create_hostile_territory(surface)
    if hostile_territory == nil then
        local territories = surface.get_territories()
        hostile_territory = territories and territories[1]
    end
    if hostile_territory == nil then
        scan_surface_for_empty_chunks(surface)
    end
end

local function set_hostile_territory_chunk(surface, chunk_indices)
    get_or_create_hostile_territory(surface)
    if hostile_territory == nil then
        hostile_territory = surface.create_territory {
            chunks = { chunk_indices }
        }
    else
        surface.set_territory_for_chunks({ chunk_indices }, hostile_territory)
    end
end

local schedule = {}
local function schedule_infant_demolisher_spawn(tick, position)
    local effect_delay_ticks = 0
    local spawn_delay_ticks = 60 * 2
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
    get_or_create_hostile_territory(surface)
    surface.create_segmented_unit({ name = "infant-demolisher", position = position, force = "enemy", territory = hostile_territory })
end

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
    end
    local chunk_indicies = chunk_information.chunk_indices_from_raw_coordinates(position.x, position.y)
    chunk_information.set_chunk_data(chunk_indicies, chunk_info)

    if (allowlisted_entities[entity.name]) then
        return
    end

    if entity.surface.get_territory_for_chunk(chunk_indices) ~= nil then
        schedule_infant_demolisher_spawn(event.tick, position)
    end

    entity.surface.set_territory_for_chunks({ chunk_indicies }, nil)
end

script.on_event(defines.events.on_built_entity, on_built)
script.on_event(defines.events.on_robot_built_entity, on_built)

local function on_pre_destroyed(event)
    local entity = event.entity
    local position = event.entity.position

    if event.entity.force ~= "player" then
        return
    end

    if (entity.surface.name ~= "vulcanus_lava_tubes") then
        return
    end

    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(position.x, position.y)
    local chunk_info = chunk_information.get_chunk_data(chunk_indices)
    if (chunk_info) then
        chunk_info.entity_count = chunk_info.entity_count - 1
        if (chunk_info.entity_count <= 0) then
            set_hostile_territory_chunk(entity.surface, chunk_indices)
        end
    end
    chunk_information.set_chunk_data(chunk_information.chunk_indices_from_raw_coordinates(position.x, position.y), chunk_info)
end

script.on_event(defines.events.on_pre_player_mined_item, on_pre_destroyed)
script.on_event(defines.events.on_robot_pre_mined, on_pre_destroyed)

local on_tick_spawn_chance = 1 / 60 / 30 -- 1 in 30 seconds on average
local max_infant_demolisher_count = 10

local function on_tick(event)
    if ((storage.infant_demolisher_count == nil or storage.infant_demolisher_count < max_infant_demolisher_count) and math.random() < on_tick_spawn_chance) then
        local surface = game.surfaces["vulcanus_lava_tubes"]

        get_or_create_hostile_territory(surface)
        local hostile_chunks = hostile_territory and hostile_territory.get_chunks()
        if hostile_chunks then
            local index = math.random(#hostile_chunks)
            local chunk_indices = hostile_chunks[index]
            local bounding_box = chunk_information.bounding_box_from_chunk_indices(chunk_indices)
            local x = (bounding_box.left_top.x + bounding_box.right_bottom.x) / 2
            local y = (bounding_box.left_top.y + bounding_box.right_bottom.y) / 2
            -- game.print("Scheduling infant demolisher spawn in chunk " .. serpent.line(chunk_indices) .. " at coordinates " .. x .. ", " .. y)
            local spawn_position = surface.find_non_colliding_position("infant-demolisher", { x, y }, 32, 2)
            if (spawn_position == nil) then
                return
            end
            -- game.print("Spawning infant demolisher at " .. spawn_position.x .. ", " .. spawn_position.y)

            if (storage.infant_demolisher_count == nil) then
                storage.infant_demolisher_count = 1
            else
                storage.infant_demolisher_count = storage.infant_demolisher_count + 1
            end

            -- game.print("Increased storage.infant_demolisher_count to " .. storage.infant_demolisher_count)

            schedule_infant_demolisher_spawn(event.tick, spawn_position)
        end
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
        local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(event.area.left_top.x,
            event.area.left_top.y)
        chunk_information.set_chunk_data(chunk_indices, {
            entity_count = 0
        })

        set_hostile_territory_chunk(event.surface, chunk_indices)
    end
end)

script.on_event(defines.events.on_segmented_unit_died, function(event)
    if (event.segmented_unit.surface.name ~= "vulcanus_lava_tubes") then
        return
    end

    if (storage.infant_demolisher_count ~= nil and storage.infant_demolisher_count > 0) then
        storage.infant_demolisher_count = storage.infant_demolisher_count - 1
    end

    -- game.print("Reduced storage.infant_demolisher_count to " .. storage.infant_demolisher_count)
end, {
    { filter = "name", name = "infant-demolisher" }
})
