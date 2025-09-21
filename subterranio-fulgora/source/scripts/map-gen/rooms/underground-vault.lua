local consts = require("scripts.map-gen.map-gen-constants")

local function create_tiles(bounding_box, surface)
    local left_x = bounding_box.left_top.x
    local right_x = bounding_box.right_bottom.x
    local bottom_y = bounding_box.right_bottom.y
    local top_y = bounding_box.left_top.y

    local tiles = {}
    local index = 0
    for i = left_x, right_x - 1, 1 do
        for j = top_y, bottom_y - 1, 1 do
            tiles[index] = {
                position = {x = i, y = j},
                name = "fulgoran-paving"
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
                local entity_name = consts.wall_entity_name
                local direction = defines.direction.east

                if (i - left_x == 3) or (i - left_x == 4) or (i - left_x == 27) or (i - left_x == 28) then
                    entity_name = consts.gate_entity_name
                end

                if (j - top_y == 3) or (j - top_y == 4) or (j - top_y == 27) or (j - top_y == 28) then
                    entity_name = consts.gate_entity_name
                    direction = defines.direction.north
                end

                surface.create_entity{
                    name = entity_name,
                    direction = direction,
                    position = { i, j },
                    force = "neutral",
                    create_build_effect_smoke = false,
                    move_stuck_players = true,
                    raise_built = true
                }
            end
        end
    end
end

local function spawn_room(bounding_box, surface)
    create_tiles(bounding_box, surface)
    create_entities(bounding_box, surface)
end

local function generate_room()
    return {
        type = consts.room_types.VAULT,
        spawn_on_connection = true
    }
end

return {
    generate_room = generate_room,
    spawn_room = spawn_room
}
