local base_room_16 = require("base-room-size-sixteen")
local base_room_32 = require("base-room-size-thirty-two")

local function generate_base_rooms(bounding_box, surface, grid_size)
    if grid_size == 32 then
        base_room_32.generate_room(bounding_box, surface)
    elseif grid_size == 16 then
        base_room_16.generate_room(bounding_box, surface)
    end
end

return {
    generate_base_rooms = generate_base_rooms
}
