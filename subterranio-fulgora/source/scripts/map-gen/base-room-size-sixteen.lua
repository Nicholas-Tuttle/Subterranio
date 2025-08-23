local food_farm = require("size-sixteen-rooms.food-farm")

local function create_tiles(bounding_box, surface, tile_name)
    local left_x = bounding_box.left_top.x
    local right_x = bounding_box.right_bottom.x - 1
    local bottom_y = bounding_box.right_bottom.y - 1
    local top_y = bounding_box.left_top.y

    local tiles = {}
    local index = 0

    for i = left_x, right_x, 1 do
        for j = top_y, bottom_y, 1 do
            tiles[index] = {
                position = {x = i, y = j},
                name = tile_name
            }
            index = index + 1
        end
    end
    local correct_tiles = true
    local remove_colliding_entities = true
    local remove_colliding_decoratives = true 
    surface.set_tiles(tiles, correct_tiles, remove_colliding_entities, remove_colliding_decoratives)
end

local function create_entities(bounding_box, surface)
    local left_x = bounding_box.left_top.x
    local right_x = bounding_box.right_bottom.x - 1
    local bottom_y = bounding_box.right_bottom.y - 1
    local top_y = bounding_box.left_top.y

    for i = left_x, right_x, 1 do
        for j = top_y, bottom_y, 1 do
            -- Only make walls on the perimeters
            if i == left_x or i == right_x or j == top_y or j == bottom_y then
                local entity_name = "stone-wall"
                local direction = defines.direction.east

                if i % 32 == 3 or i % 32 == 4 or i % 32 == 27 or i % 32 == 28 then
                    entity_name = "gate"
                end

                if j % 32 == 3 or j % 32 == 4 or j % 32 == 27 or j % 32 == 28 then
                    entity_name = "gate"
                    direction = defines.direction.north
                end

                surface.create_entity{
                    name = entity_name,
                    direction = direction,
                    position = { i, j },
                    force = "neutral",
                    create_build_effect_smoke = false,
                    move_stuck_players = true
                }
            end
        end
    end
end

local function generate_room(bounding_box, surface)
    for i = 1, 4, 1 do
        local left_x_offset = math.floor(((i - 1) % 2)) * 16
        local top_y_offset = math.floor(((i - 1) / 2)) * 16
        local bounding_box = {
            left_top = {
                x = bounding_box.left_top.x + left_x_offset,
                y = bounding_box.left_top.y + top_y_offset
            },
            right_bottom = {
                x = bounding_box.left_top.x + left_x_offset + 16,
                y = bounding_box.left_top.y + top_y_offset + 16
            }
        }
        
        if (math.random() <= 0.7) then
            create_tiles(bounding_box, surface, "tutorial-grid")
            create_entities(bounding_box, surface)
            if math.random() <= 1.0 then
                food_farm.generate(bounding_box, surface)
            end
        else
            create_tiles(bounding_box, surface, "out-of-map")
        end
    end
    
end

return {
    generate_room = generate_room
}