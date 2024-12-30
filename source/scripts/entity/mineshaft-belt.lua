local function built_mineshaft(event)
    local mineshaft_belt_entrance = event.entity
    local position = mineshaft_belt_entrance.position
    local opposite_surface_name = (mineshaft_belt_entrance.surface.name == "nauvis" and "subterrain" or "nauvis")
    
    -- TODO: Make sure the other surface has open area where trying to build
    -- TODO: Can this show a camera view UI of the other surface?

    local target_surface = game.planets[opposite_surface_name].create_surface()
    local target_position = {x = position.x, y = position.y}
    target_surface.request_to_generate_chunks(target_position, 1)
    target_surface.force_generate_chunk_requests()

    local mineshaft_belt_exit = target_surface.create_entity{name = event.entity.name, position = position, force = game.forces.player}

    mineshaft_belt_entrance.linked_belt_type = "input"
    mineshaft_belt_exit.linked_belt_type = "output"
    mineshaft_belt_entrance.connect_linked_belts(mineshaft_belt_exit)
end

local function destroyed_mineshaft(event)

    local position = event.entity.position
    local opposite_surface_name = (event.entity.surface.name == "nauvis" and "subterrain" or "nauvis")
    local mineshaft_to_destroy = game.surfaces[opposite_surface_name].find_entity(event.entity.name, position)
    if mineshaft_to_destroy ~= nil then
        mineshaft_to_destroy.destroy()
    end
end

local mineshaft_belt_filter = {
    {filter = "name", name = "mineshaft-belt"},
    {filter = "name", name = "fast-mineshaft-belt"},
    {filter = "name", name = "express-mineshaft-belt"},
    {filter = "name", name = "turbo-mineshaft-belt"}
}

script.on_event(defines.events.on_built_entity, built_mineshaft, mineshaft_belt_filter)
script.on_event(defines.events.on_robot_built_entity, built_mineshaft, mineshaft_belt_filter)
script.on_event(defines.events.on_pre_player_mined_item , destroyed_mineshaft, mineshaft_belt_filter)
script.on_event(defines.events.on_entity_died , destroyed_mineshaft, mineshaft_belt_filter)
script.on_event(defines.events.on_robot_pre_mined  , destroyed_mineshaft, mineshaft_belt_filter)