function built_mineshaft_belt(event)
    local mineshaft_belt_entrance = event.entity
    local position = mineshaft_belt_entrance.position
    local direction = mineshaft_belt_entrance.direction
    local opposite_surface_names = get_exit_surface_options(mineshaft_belt_entrance.surface.name)

    if not opposite_surface_names or #opposite_surface_names > 1 then
        game.print("There are 0 or >1 options for the mineshaft belt exit, bailing since handling this hasn't been implemented yet!")
        return false
    end

    local target_surface = game.planets[opposite_surface_names[1]].create_surface()
    local target_position = {x = position.x, y = position.y}
    target_surface.request_to_generate_chunks(target_position, 1)
    target_surface.force_generate_chunk_requests()

    local opposite_direction = {}
    opposite_direction[defines.direction.north]=defines.direction.south
    opposite_direction[defines.direction.south]=defines.direction.north
    opposite_direction[defines.direction.east]=defines.direction.west
    opposite_direction[defines.direction.west]=defines.direction.east

    local mineshaft_belt_exit = target_surface.create_entity{name = event.entity.name, position = position, direction = opposite_direction[direction], force = game.forces.player}

    mineshaft_belt_entrance.linked_belt_type = "input"
    mineshaft_belt_exit.linked_belt_type = "output"
    mineshaft_belt_entrance.connect_linked_belts(mineshaft_belt_exit)
end

function destroyed_mineshaft_belt(event)
    local mineshaft_belt_entrance = event.entity
    local position = mineshaft_belt_entrance.position
    local opposite_surface_names = get_exit_surface_options(mineshaft_belt_entrance.surface.name)
    
    if not opposite_surface_names or #opposite_surface_names > 1 then
        game.print("There are 0 or >1 options for the mineshaft belt exit, bailing since handling this hasn't been implemented yet!")
        return false
    end

    local mineshaft_to_destroy = game.surfaces[opposite_surface_names[1]].find_entity(event.entity.name, position)
    if mineshaft_to_destroy ~= nil then
        mineshaft_to_destroy.destroy()
    end
end
