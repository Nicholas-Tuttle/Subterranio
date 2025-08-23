local function create_tiles(bounding_box, surface)
    
end

local function generate_room(bounding_box, surface)
    create_tiles(bounding_box, surface)
end

return {
    generate_room = generate_room
}