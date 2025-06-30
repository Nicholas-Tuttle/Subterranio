local function determine_mineshaft_direction(player)
    local position = player.position
    local surface = player.surface
    local surface_name = surface.name

    local opposite_surface_name = storage.MineshaftTargetSurfaceMappings[surface_name]
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
    local armor_inventory = player.get_inventory(defines.inventory.character_armor)
    if not armor_inventory then return false end
    local armor_stack = armor_inventory[1]
    if not armor_stack or not armor_stack.valid_for_read then return false end
    local equipment_grid = armor_stack.grid
    if not equipment_grid or not equipment_grid.find("tunnelling-drill-equipment") then return false end

    local target_surface, target_position = determine_mineshaft_direction(player)

    if not target_surface then return false end
    if not target_position then return false end

    player.teleport(target_position, target_surface, true)

    return true
end)
