local base_grid = require("base-grid-filler")

script.on_event(defines.events.on_chunk_generated, function (event)
    local grid_size_random = math.random()
    local grid_size = 16
    if grid_size_random >= 0.7 then
        grid_size = 8
    end
    if grid_size_random >= 0.9 then
        grid_size = 32
    end
    base_grid.generate_base_rooms(event.area, event.surface, grid_size)
end)