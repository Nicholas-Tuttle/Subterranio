require("scripts.event-handler-combinations")

local function equipment_grid_contains_equipment_of_any_quality(equipment_grid, name)
     for i = 1, #equipment_grid.equipment do
        if equipment_grid.equipment[i].name == name then
            return true
        end
    end

    return false
end

local function can_tunnel_to_surface(player, target_surface_name)
    local target_surface_info = storage.MineshaftTargetInfo[target_surface_name]
    if not target_surface_info then return false end

    if target_surface_info.equipment_requirements then
        local armor_inventory = player.get_inventory(defines.inventory.character_armor)
        if not armor_inventory then return false end
        local armor_stack = armor_inventory[1]
        if not armor_stack or not armor_stack.valid_for_read then return false end
        local equipment_grid = armor_stack.grid
        if not equipment_grid then return false end

        for i = 1, #target_surface_info.equipment_requirements do
            if not equipment_grid_contains_equipment_of_any_quality(equipment_grid, target_surface_info.equipment_requirements[i]) then
                -- game.print("equipment_requirements not met")
                return false
            end
        end
    end

    if target_surface_info.required_techs_to_arrive ~= nil then
        for i = 1, #target_surface_info.required_techs_to_arrive do
            local tech = game.player.force.technologies[target_surface_info.required_techs_to_arrive[i]]
            if tech ~= nil and not tech.researched then
                -- game.print("required_techs_to_arrive not met")
                return false
            end
        end
    end

    return true
end

-- Don't forget that arrays are 1-indexed in Lua!
local function get_current_surface_index(player, target_surface_list)
    local current_surface = player.surface
    for i = 1, #target_surface_list do
        if target_surface_list[i] == current_surface.name then
            return i
        end
    end

    return 0
end

local function determine_mineshaft_target(player)
    -- TODO: If the player cannot go down, try to loop back to the start so they can go up
    local target_surface_info = storage.MineshaftTargetInfo[player.surface.name]
    if not target_surface_info then return false end
    local target_surface_list = target_surface_info.target_surfaces
    if not target_surface_list then return false end
    local current_surface_index = get_current_surface_index(player, target_surface_list)
    if current_surface_index == 0 then return false end
    local found_valid_target_surface = false
    local opposite_surface_name = nil

    -- Go down further
    for i = current_surface_index + 1, #target_surface_list do
        if not found_valid_target_surface then
            -- game.print("Checking if player can tunnel to surface " .. target_surface_list[i])
            found_valid_target_surface = can_tunnel_to_surface(player, target_surface_list[i])
            if found_valid_target_surface then
                opposite_surface_name = target_surface_list[i]
            end
        end
    end

    -- Loop back to the upper levels
    for i = 1, current_surface_index - 1 do
        if not found_valid_target_surface then
            -- game.print("Checking if player can tunnel to surface " .. target_surface_list[i])
            found_valid_target_surface = can_tunnel_to_surface(player, target_surface_list[i])
            if found_valid_target_surface then
                opposite_surface_name = target_surface_list[i]
            end
        end
    end
    
    if not opposite_surface_name then
        game.print("No other surface is reachable with the current equipment and technologies")
        return false
    end

    local target_surface = game.planets[opposite_surface_name].create_surface()
    local position = player.position
    local target_position = {x = position.x, y = position.y}
    target_surface.request_to_generate_chunks(target_position, 1)
    target_surface.force_generate_chunk_requests()

    target_position = target_surface.find_non_colliding_position(player.character.name, target_position, 100, 0.5, false)
    if not target_position then return nil end
    return target_surface, target_position
end

subterrain.on_event("subterranean-mineshaft-player-enter", function(event)
    if storage.MineshaftTargetInfo == nil then
        return false
    end

    local player = game.get_player(event.player_index)
    if not player then return false end

    local target_surface, target_position = determine_mineshaft_target(player)

    if not target_surface then return false end
    if not target_position then return false end

    player.teleport(target_position, target_surface, true)

    return true
end)
