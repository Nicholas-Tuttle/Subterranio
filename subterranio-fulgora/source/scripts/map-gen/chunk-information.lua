local function set_chunk_data(chunk_indices, data)
    if (storage == nil) then
        storage = {}
    end

    if (storage.surface_info == nil) then
        storage.surface_info = {}
    end

    if (storage.surface_info == nil) then
        storage.surface_info = {}
    end

    if (storage.surface_info[chunk_indices.x] == nil) then
        storage.surface_info[chunk_indices.x] = {}
    end

    storage.surface_info[chunk_indices.x][chunk_indices.y] = data
end

local function get_chunk_data(chunk_indices)
    if storage == nil or storage == nil or storage.surface_info == nil or
    storage.surface_info == nil or storage.surface_info[chunk_indices.x] == nil then
        return nil
    end

    return storage.surface_info[chunk_indices.x][chunk_indices.y]
end

local function chunk_indices_from_raw_coordinates(raw_x, raw_y)
    return {
        x = math.floor(raw_x / 32),
        y = math.floor(raw_y / 32)
    }
end

local function bounding_box_from_chunk_indices(chunk_indices)
    return {
        left_top = {
            x = chunk_indices.x * 32,
            y = chunk_indices.y * 32
        },
        right_bottom = {
            x = chunk_indices.x * 32 + 32,
            y = chunk_indices.y * 32 + 32
        }
    }
end

script.on_event(defines.events.on_pre_surface_deleted, function (event)
    if storage and storage.surface_info then
        local surface_name = game.surfaces[event.surface_index].name
        if surface_name == "fulgoran_subway" then
            storage.surface_info = nil
        end
    end
end)

return {
    get_chunk_data = get_chunk_data,
    set_chunk_data = set_chunk_data,

    chunk_indices_from_raw_coordinates = chunk_indices_from_raw_coordinates,
    bounding_box_from_chunk_indices = bounding_box_from_chunk_indices
}
