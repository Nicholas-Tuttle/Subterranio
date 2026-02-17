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

    if (entity.surface.name ~= "vulcanus_lava_tubes") then
        return
    end

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

local on_tick_spawn_chance = 1 / 60 / 60 / 2 -- 1 in 2 minutes on average

local function on_tick(event)
    if (math.random() < on_tick_spawn_chance) then
        -- TODO: Find a better way to find a spawn position. Potentially scan over chunks and count the number of entities, then favor chunks with fewer/more entities.
        local spawn_jitter_x = math.random(-64, 64)
        local spawn_jitter_y = math.random(-64, 64)
        local spawn_position = game.surfaces["vulcanus_lava_tubes"].find_non_colliding_position("infant-demolisher", { spawn_jitter_x, spawn_jitter_y }, 64, 4)
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