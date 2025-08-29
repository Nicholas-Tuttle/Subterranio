local function set_chunk_data(surface_name, x, y, data)
    if (storage.subterranio_fulgora == nil) then
        storage.subterranio_fulgora = {}
    end

    if (storage.subterranio_fulgora.surface_info == nil) then
        storage.subterranio_fulgora.surface_info = {}
    end

    if (storage.subterranio_fulgora.surface_info[surface_name] == nil) then
        storage.subterranio_fulgora.surface_info[surface_name] = {}
    end

    if (storage.subterranio_fulgora.surface_info[surface_name][x] == nil) then
        storage.subterranio_fulgora.surface_info[surface_name][x] = {}
    end

    storage.subterranio_fulgora.surface_info[surface_name][x][y] = data
end

local function get_chunk_data(surface_name, x, y)
    return storage.subterranio_fulgora.surface_info[surface_name][x][y]
end

local function chunk_indices_from_raw_coordinates(raw_x, raw_y)
    return {
        x = math.floor(raw_x / 32),
        y = math.floor(raw_y / 32)
    }
end

return {
    get_chunk_data = get_chunk_data,
    set_chunk_data = set_chunk_data,

    chunk_indices_from_raw_coordinates = chunk_indices_from_raw_coordinates
}
