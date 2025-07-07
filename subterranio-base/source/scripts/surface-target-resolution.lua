-- Don't forget that arrays are 1-indexed in Lua!
local function get_entrance_surface_index(entrance_surface_name, target_surface_list)
    for i = 1, #target_surface_list do
        if target_surface_list[i] == entrance_surface_name then
            return i
        end
    end

    return 0
end

-- Don't forget that arrays are 1-indexed in Lua!
function get_exit_surface_options(entrance_surface_name)
    local target_surface_info = storage.MineshaftTargetInfo[entrance_surface_name]
    game.print("target_surface_info " .. #target_surface_info)
    if not target_surface_info then return nil end
    local target_surface_list = target_surface_info.target_surfaces
    game.print("target_surface_list " .. #target_surface_list)
    if not target_surface_list then return false end
    local entrance_surface_index = get_entrance_surface_index(entrance_surface_name, target_surface_list)
    game.print("entrance_surface_index " .. entrance_surface_index)
    if not entrance_surface_index then
        game.print("Count not find entrance_surface_index")
        return nil
    end

    -- Handle just the common cases for now
    -- TODO: Make this loop around and go up-down for multi-surface planets
    if entrance_surface_index == 1 and #target_surface_list >= 2 then
        return {target_surface_list[2]}
    end
    
    if entrance_surface_index == 2 and #target_surface_list == 2 then
        return {target_surface_list[1]}
    end

    game.print("Could not find exit surface options, returning nil")
    return nil
end
