require("planets.nauvis.scripts.unit.cliff-destroyer-robot")
require("planets.nauvis.scripts.entity.mineshaft-belt")
require("planets.nauvis.scripts.entity.mineshaft")

local cliff_destroyer_filter = {
    "cliff-destroyer-robot"
}

local cliff_destroyer_port_filter = {
    "cliff-destroyer-port"
}

local mineshaft_belt_filter = {
    "mineshaft-belt",
    "fast-mineshaft-belt",
    "express-mineshaft-belt",
    "turbo-mineshaft-belt"
}

local mineshaft_filter = {
    "mineshaft"
}

local combined_filter = {
    {filter = "name", name = "cliff-destroyer-robot"},
    {filter = "name", name = "cliff-destroyer-port"},
    {filter = "name", name = "mineshaft-belt"},
    {filter = "name", name = "fast-mineshaft-belt"},
    {filter = "name", name = "express-mineshaft-belt"},
    {filter = "name", name = "turbo-mineshaft-belt"},
    {filter = "name", name = "mineshaft"},
}

local function on_built(event)
    for _, entity in pairs(cliff_destroyer_filter) do 
        if event.entity.name == entity then
            built_cliff_destroyer_robot(event)
        end
    end

    for _, entity in pairs(cliff_destroyer_port_filter) do
        if event.entity.name == entity then
            cliff_destroyer_port_built(event)
        end
    end

    for _, entity in pairs(mineshaft_belt_filter) do 
        if event.entity.name == entity then
            built_mineshaft_belt(event)
        end
    end

    for _, entity in pairs(mineshaft_filter) do
        if event.entity.name == entity then
            built_mineshaft(event)
        end
    end
end

script.on_event(defines.events.on_built_entity, on_built, combined_filter)
script.on_event(defines.events.on_robot_built_entity, on_built, combined_filter)

local function on_pre_destroyed(event)
    for _, entity in pairs(mineshaft_belt_filter) do 
        if event.entity.name == entity then
            destroyed_mineshaft_belt(event)
        end
    end
end

script.on_event(defines.events.on_pre_player_mined_item, on_pre_destroyed, combined_filter)
script.on_event(defines.events.on_entity_died, on_pre_destroyed, combined_filter)
script.on_event(defines.events.on_robot_pre_mined, on_pre_destroyed, combined_filter)

local function on_destroyed(event)
    for _, entity in pairs(mineshaft_filter) do
        if event.entity.name == entity then
            destroyed_mineshaft(event)
        end
    end
end

script.on_event(defines.events.on_player_mined_entity, on_destroyed, combined_filter)
script.on_event(defines.events.on_robot_mined_entity, on_destroyed, combined_filter)

local function on_spider_command_completed(event)
    cliff_destroyer_robot_completed_command(event)
end

script.on_event(defines.events.on_spider_command_completed, on_spider_command_completed)

local MineshaftTargetSurfaceMappings = {
    nauvis="subterrain",
    subterrain="nauvis",
    vulcanus="vulcanus_subterrain",
    vulcanus_subterrain="vulcanus",
    fulgora="fulgora_subterrain",
    fulgora_subterrain="fulgora",
    gleba="gleba_subterrain",
    gleba_subterrain="gleba",
    aquilo="aquilo_subterrain",
    aquilo_subterrain="aquilo",
}

script.on_init(function()
    MineshaftTargetSurfaceMappings = MineshaftTargetSurfaceMappings
    UnlockedMineshaftTargetSurfaceMappings = {}
end)
