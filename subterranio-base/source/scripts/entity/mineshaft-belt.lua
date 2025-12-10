local destination_belt_names = {
    ["mineshaft-belt-up"] = "mineshaft-belt-down",
    ["fast-mineshaft-belt-up"] = "fast-mineshaft-belt-down",
    ["express-mineshaft-belt-up"] = "express-mineshaft-belt-down",
    ["turbo-mineshaft-belt-up"] = "turbo-mineshaft-belt-down",
    ["mineshaft-belt-down"] = "mineshaft-belt-up",
    ["fast-mineshaft-belt-down"] = "fast-mineshaft-belt-up",
    ["express-mineshaft-belt-down"] = "express-mineshaft-belt-up",
    ["turbo-mineshaft-belt-down"] = "turbo-mineshaft-belt-up"
}

function built_upward_mineshaft_belt(event)
    local mineshaft_belt_entrance = event.entity
    local position = mineshaft_belt_entrance.position
    local direction = mineshaft_belt_entrance.direction
    local destination_surface_name = get_next_higher_surface(mineshaft_belt_entrance.surface.name)

    if not destination_surface_name then
        game.print("There are no options for the mineshaft belt exit")
        return false
    end

    local target_surface = game.planets[destination_surface_name].create_surface()
    local target_position = {x = position.x, y = position.y}
    target_surface.request_to_generate_chunks(target_position, 1)
    target_surface.force_generate_chunk_requests()

    local opposite_direction = {}
    opposite_direction[defines.direction.north]=defines.direction.south
    opposite_direction[defines.direction.south]=defines.direction.north
    opposite_direction[defines.direction.east]=defines.direction.west
    opposite_direction[defines.direction.west]=defines.direction.east

    local mineshaft_belt_exit = target_surface.create_entity{name = destination_belt_names[event.entity.name], position = position, direction = opposite_direction[direction], force = game.forces.player}

    mineshaft_belt_entrance.linked_belt_type = "input"

    if (mineshaft_belt_exit == nil) then
        return false
    end

    mineshaft_belt_exit.linked_belt_type = "output"
    mineshaft_belt_entrance.connect_linked_belts(mineshaft_belt_exit)
end

function destroyed_upward_mineshaft_belt(event)
    local mineshaft_belt_entrance = event.entity
    local position = mineshaft_belt_entrance.position
    local destination_surface_name = get_next_higher_surface(mineshaft_belt_entrance.surface.name)

    if not destination_surface_name then
        return false
    end

    local mineshaft_to_destroy = game.surfaces[destination_surface_name].find_entity(destination_belt_names[event.entity.name], position)
    if mineshaft_to_destroy ~= nil then
        mineshaft_to_destroy.destroy()
    end
end

function built_downward_mineshaft_belt(event)
    local mineshaft_belt_entrance = event.entity
    local position = mineshaft_belt_entrance.position
    local direction = mineshaft_belt_entrance.direction
    local destination_surface_name = get_next_lower_surface(mineshaft_belt_entrance.surface.name)

    if not destination_surface_name then
        game.print("There are no options for the mineshaft belt exit")
        return false
    end

    local target_surface = game.planets[destination_surface_name].create_surface()
    local target_position = {x = position.x, y = position.y}
    target_surface.request_to_generate_chunks(target_position, 1)
    target_surface.force_generate_chunk_requests()

    local opposite_direction = {}
    opposite_direction[defines.direction.north]=defines.direction.south
    opposite_direction[defines.direction.south]=defines.direction.north
    opposite_direction[defines.direction.east]=defines.direction.west
    opposite_direction[defines.direction.west]=defines.direction.east

    local mineshaft_belt_exit = target_surface.create_entity{name = destination_belt_names[event.entity.name], position = position, direction = opposite_direction[direction], force = game.forces.player}

    mineshaft_belt_entrance.linked_belt_type = "input"

    if (mineshaft_belt_exit == nil) then
        return false
    end

    mineshaft_belt_exit.linked_belt_type = "output"
    mineshaft_belt_entrance.connect_linked_belts(mineshaft_belt_exit)
end

function destroyed_downward_mineshaft_belt(event)
    local mineshaft_belt_entrance = event.entity
    local position = mineshaft_belt_entrance.position
    local destination_surface_name = get_next_lower_surface(mineshaft_belt_entrance.surface.name)

    if not destination_surface_name then
        return false
    end

    local mineshaft_to_destroy = game.surfaces[destination_surface_name].find_entity(destination_belt_names[event.entity.name], position)
    if mineshaft_to_destroy ~= nil then
        mineshaft_to_destroy.destroy()
    end
end
