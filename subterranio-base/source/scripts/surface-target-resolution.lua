-- Don't forget that arrays are 1-indexed in Lua!
local function get_entrance_surface_index(entrance_surface_name, target_surface_list)
    for i = 1, #target_surface_list do
        if target_surface_list[i] == entrance_surface_name then
            return i
        end
    end

    return 0
end

local function get_next_lower_surface(entrance_surface_name)
    local target_surface_info = storage.MineshaftTargetInfo[entrance_surface_name]
    if not target_surface_info then return nil end
    local target_surface_list = target_surface_info.target_surfaces
    if not target_surface_list then return false end
    local entrance_surface_index = get_entrance_surface_index(entrance_surface_name, target_surface_list)
    if not entrance_surface_index then
        game.print("get_next_lower_surface - could not find entrance_surface_index")
        return nil
    end

    if entrance_surface_index < #target_surface_list then
        return target_surface_list[entrance_surface_index + 1]
    else
        return nil
    end
end

local function get_next_higher_surface(entrance_surface_name)
    local target_surface_info = storage.MineshaftTargetInfo[entrance_surface_name]
    if not target_surface_info then return nil end
    local target_surface_list = target_surface_info.target_surfaces
    if not target_surface_list then return false end
    local entrance_surface_index = get_entrance_surface_index(entrance_surface_name, target_surface_list)
    if not entrance_surface_index then
        game.print("get_next_higher_surface - could not find entrance_surface_index")
        return nil
    end

    if entrance_surface_index > 1 then
        return target_surface_list[entrance_surface_index - 1]
    else
        return nil
    end
end

return {
    get_next_lower_surface = get_next_lower_surface,
    get_next_higher_surface = get_next_higher_surface
}
