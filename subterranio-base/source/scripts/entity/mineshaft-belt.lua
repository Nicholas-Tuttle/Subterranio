local surface_target_resolution = require("surface-target-resolution")

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

local function get_destination_surface(mineshaft_belt_entrance)
    local destination_surface_name = nil
    if string.find(mineshaft_belt_entrance.name, "up") then
        destination_surface_name = surface_target_resolution.get_next_higher_surface(mineshaft_belt_entrance.surface.name)
    else
        destination_surface_name = surface_target_resolution.get_next_lower_surface(mineshaft_belt_entrance.surface.name)
    end
    return destination_surface_name
end

local function built_mineshaft_belt(event)
    local mineshaft_belt_entrance = event.entity
    local position = mineshaft_belt_entrance.position
    local direction = mineshaft_belt_entrance.direction
    local destination_surface_name = get_destination_surface(mineshaft_belt_entrance)

    if not destination_surface_name then
        return false
    end

    local target_surface = game.planets[destination_surface_name].create_surface()
    local target_position = {x = position.x, y = position.y}
    target_surface.request_to_generate_chunks(target_position, 1)
    target_surface.force_generate_chunk_requests()

    local exits = target_surface.find_entities_filtered{name = destination_belt_names[event.entity.name], position = position, force = game.forces.player}
    local mineshaft_belt_exit = nil
    if exits and #exits == 1 then
        mineshaft_belt_exit = exits[1]
    else
        local opposite_direction = {
            [defines.direction.north] = defines.direction.south,
            [defines.direction.south] = defines.direction.north,
            [defines.direction.east] = defines.direction.west,
            [defines.direction.west] = defines.direction.east
        }

        mineshaft_belt_exit = target_surface.create_entity{name = destination_belt_names[event.entity.name], position = position, direction = opposite_direction[direction], force = game.forces.player}
    end

    mineshaft_belt_entrance.linked_belt_type = "input"

    if (mineshaft_belt_exit == nil) then
        game.print("Could not find or create mineshaft belt exit")
        return false
    end

    mineshaft_belt_exit.linked_belt_type = "output"
    mineshaft_belt_entrance.connect_linked_belts(mineshaft_belt_exit)
end

local function destroyed_mineshaft_belt(event)
    local mineshaft_belt_entrance = event.entity
    local position = mineshaft_belt_entrance.position
    local destination_surface_name = get_destination_surface(mineshaft_belt_entrance)

    if not destination_surface_name then
        return false
    end

    local mineshafts_to_destroy = game.surfaces[destination_surface_name].find_entities_filtered{name = destination_belt_names[event.entity.name], position = position, force = game.forces.player}
    if mineshafts_to_destroy and #mineshafts_to_destroy == 1 then
        mineshafts_to_destroy[1].destroy()
    end
end

return {
    built_mineshaft_belt = built_mineshaft_belt,
    destroyed_mineshaft_belt = destroyed_mineshaft_belt
}