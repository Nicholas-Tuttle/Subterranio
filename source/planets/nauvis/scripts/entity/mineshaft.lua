function built_mineshaft(event)
    local player = game.get_player(event.player_index)
    if not player then return false end
    local surface = player.surface
    local surface_name = surface.name

    local opposite_surface_name = storage.MineshaftTargetSurfaceMappings[surface_name]
    if not opposite_surface_name then 
        -- TODO: Internationalize
        game.print("Mineshaft built on " .. surface_name .. ", there is no underground on this surface")
        return nil 
    end

    local unlocked_opposite_surface = storage.UnlockedMineshaftTargetSurfaceMappings[surface_name]
    if unlocked_opposite_surface then
        -- TODO: Internationalize
        game.print("A mineshaft has already been constructed on this surface")
        return true
    end

    -- TODO: Internationalize this and use the actual keybind mapping to print
    game.print("Mineshaft built on " .. surface_name .. ", access to " .. opposite_surface_name .. " available. Use ctrl + enter to teleport between overground and underground")
    storage.UnlockedMineshaftTargetSurfaceMappings[surface_name] = opposite_surface_name
    return true
end

function destroyed_mineshaft(event)
    local player = game.get_player(event.player_index)
    if not player then return false end
    local surface = player.surface
    local surface_name = surface.name
    local surface_mineshafts_count = surface.count_entities_filtered{
        name = "mineshaft",
        limit = 2
    }

    -- Since the entity has not been actually destroyed yet when this event is called (it is in the process of being destroyed)
    -- this is checking if it is the final mineshaft currently on the surface (count of 1). If there are 2 or more immediately
    -- before the mineshaft is mined then don't limit underground access
    if surface_mineshafts_count == 1 then
        -- TODO: Internationalize
        game.print("The final mineshaft on " .. surface_name .. " was destroyed, access to the underground is no longer available")
        storage.UnlockedMineshaftTargetSurfaceMappings[surface_name] = nil
    end

    return false
end

local function determine_mineshaft_direction(player)
    local position = player.position
    local surface = player.surface
    local surface_name = surface.name

    local opposite_surface_name = storage.UnlockedMineshaftTargetSurfaceMappings[surface_name]
    if not opposite_surface_name then return nil end
    local target_surface = game.planets[opposite_surface_name].create_surface()

    local target_position = {x = position.x, y = position.y}
    target_surface.request_to_generate_chunks(target_position, 1)
    target_surface.force_generate_chunk_requests()

    target_position = target_surface.find_non_colliding_position(player.character.name, target_position, 100, 0.5, false)
    if not target_position then return nil end
    return target_surface, target_position
end

subterrain.on_event("subterranean-mineshaft-player-enter", function(event)
    local player = game.get_player(event.player_index)
    if not player then return false end

    local target_surface, target_position = determine_mineshaft_direction(player)

    if not target_surface then return false end
    if not target_position then return false end

    player.teleport(target_position, target_surface, true)

    return true
end)