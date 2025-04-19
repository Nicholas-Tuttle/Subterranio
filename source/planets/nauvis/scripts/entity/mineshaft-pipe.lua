function built_mineshaft_pipe(event)
    local mineshaft_pipe_entrance = event.entity
    local position = mineshaft_pipe_entrance.position
    local opposite_surface_name = storage.UnlockedMineshaftTargetSurfaceMappings[mineshaft_pipe_entrance.surface.name]

    if not opposite_surface_name then
        return false
    end

    local target_surface = game.planets[opposite_surface_name].create_surface()
    local target_position = {x = position.x, y = position.y}
    target_surface.request_to_generate_chunks(target_position, 1)
    target_surface.force_generate_chunk_requests()

    -- TODO: If there is already a mineshaft_pipe_exit on the other side, just link them
    local mineshaft_pipe_exit = target_surface.create_entity{name = event.entity.name, position = position, force = game.forces.player}

    mineshaft_pipe_entrance.fluidbox.add_linked_connection(0, mineshaft_pipe_exit, 0)
end

function destroyed_mineshaft_pipe(event)
    local position = event.entity.position
    local opposite_surface_name = storage.UnlockedMineshaftTargetSurfaceMappings[event.entity.surface.name]
    if not opposite_surface_name then
        return false
    end

    local mineshaft_pipe_to_destroy = game.surfaces[opposite_surface_name].find_entity(event.entity.name, position)
    if mineshaft_pipe_to_destroy ~= nil then
        mineshaft_pipe_to_destroy.destroy()
    end
end