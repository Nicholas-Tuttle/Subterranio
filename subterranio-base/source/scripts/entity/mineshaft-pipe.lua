local surface_target_resolution = require("surface-target-resolution")

local destination_pipe_names = {
    ["mineshaft-pipe-up"] = "mineshaft-pipe-down",
    ["mineshaft-pipe-down"] = "mineshaft-pipe-up",
}

local function get_destination_surface(mineshaft_pipe_entrance)
    local destination_surface_name = nil
    if string.find(mineshaft_pipe_entrance.name, "up") then
        destination_surface_name = surface_target_resolution.get_next_higher_surface(mineshaft_pipe_entrance.surface.name)
    else
        destination_surface_name = surface_target_resolution.get_next_lower_surface(mineshaft_pipe_entrance.surface.name)
    end
    return destination_surface_name
end

local function built_mineshaft_pipe(event)
    local mineshaft_pipe_entrance = event.entity
    local position = mineshaft_pipe_entrance.position
    local opposite_surface_name = get_destination_surface(mineshaft_pipe_entrance)

    if not opposite_surface_name then
        return false
    end

    local target_surface = game.planets[opposite_surface_name].create_surface()
    local target_position = {x = position.x, y = position.y}
    target_surface.request_to_generate_chunks(target_position, 1)
    target_surface.force_generate_chunk_requests()

    local exits = target_surface.find_entities_filtered{name = destination_pipe_names[event.entity.name], position = position, force = game.forces.player}
    local mineshaft_pipe_exit = nil
    if exits and #exits == 1 then
        mineshaft_pipe_exit = exits[1]
    else
        mineshaft_pipe_exit = target_surface.create_entity{name = destination_pipe_names[event.entity.name], position = position, force = game.forces.player}
    end

    mineshaft_pipe_entrance.fluidbox.add_linked_connection(0, mineshaft_pipe_exit, 0)
end

local function destroyed_mineshaft_pipe(event)
    local position = event.entity.position
    local opposite_surface_name = get_destination_surface(event.entity)

    if not opposite_surface_name then
        return false
    end

    local mineshaft_pipes_to_destroy = game.surfaces[opposite_surface_name].find_entities_filtered{name = destination_pipe_names[event.entity.name], position = position, force = game.forces.player}
    if mineshaft_pipes_to_destroy and #mineshaft_pipes_to_destroy == 1 then
        mineshaft_pipes_to_destroy[1].destroy()
    end
end

return {
    built_mineshaft_pipe = built_mineshaft_pipe,
    destroyed_mineshaft_pipe = destroyed_mineshaft_pipe
}
