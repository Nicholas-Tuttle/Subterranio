local chunk_information = require("scripts.map-gen.chunk-information")
local layout_utils = require("scripts.map-gen.rooms.layout-utils")
local consts = require("scripts.map-gen.map-gen-constants")

-- A seed that has 2-part and 4-part vaults is 3692670796

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
                position = { x = i, y = j },
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

local wall_definitions = {}

for i = 1, 30, 1 do
    table.insert(wall_definitions, { position = { x = 0, y = i } })
    table.insert(wall_definitions, { position = { x = 31, y = i } })
    table.insert(wall_definitions, { position = { x = i, y = 0 } })
    table.insert(wall_definitions, { position = { x = i, y = 31 } })
end

table.insert(wall_definitions, { position = { x = 0, y = 0 } })
table.insert(wall_definitions, { position = { x = 31, y = 0 } })
table.insert(wall_definitions, { position = { x = 0, y = 31 } })
table.insert(wall_definitions, { position = { x = 31, y = 31 } })

local gate_definitions = {
    left = {
        { x = 0, y = 3,  direction = defines.direction.north },
        { x = 0, y = 4,  direction = defines.direction.north },
        { x = 0, y = 27, direction = defines.direction.north },
        { x = 0, y = 28, direction = defines.direction.north }
    },
    right = {
        { x = 31, y = 3,  direction = defines.direction.north },
        { x = 31, y = 4,  direction = defines.direction.north },
        { x = 31, y = 27, direction = defines.direction.north },
        { x = 31, y = 28, direction = defines.direction.north }
    },
    bottom = {
        { x = 3,  y = 31, direction = defines.direction.east },
        { x = 4,  y = 31, direction = defines.direction.east },
        { x = 27, y = 31, direction = defines.direction.east },
        { x = 28, y = 31, direction = defines.direction.east }
    },
    top = {
        { x = 3,  y = 0, direction = defines.direction.east },
        { x = 4,  y = 0, direction = defines.direction.east },
        { x = 27, y = 0, direction = defines.direction.east },
        { x = 28, y = 0, direction = defines.direction.east }
    }
}

local function build_room_layout(chunk_indices, left_x, top_y)
    local room_wall_definitions = {}
    for _, definition in ipairs(wall_definitions) do
        room_wall_definitions[#room_wall_definitions + 1] = {
            position = { x = left_x + definition.position.x, y = top_y + definition.position.y }
        }
    end

    local room_gate_definitions = {}
    for _, side in ipairs({ "left", "right", "bottom", "top" }) do
        room_gate_definitions[side] = {}
        for _, definition in ipairs(gate_definitions[side] or {}) do
            room_gate_definitions[side][#room_gate_definitions[side] + 1] = {
                position = { x = left_x + definition.x, y = top_y + definition.y },
                direction = definition.direction
            }
        end
    end

    return room_wall_definitions, room_gate_definitions
end

local function make_lamps(surface, left_x, right_x, bottom_y, top_y)
    local lamp_positions = {
        { left_x + 1,  top_y + 1 },
        { left_x + 1,  bottom_y - 1 },
        { right_x - 1, top_y + 1 },
        { right_x - 1, bottom_y - 1 }
    }

    for _, position in pairs(lamp_positions) do
        surface.create_entity {
            name = "fulgoran-lamp",
            position = position,
            force = "neutral",
            create_build_effect_smoke = false,
            move_stuck_players = true,
            raise_built = true
        }
    end
end

local function create_entities(bounding_box, surface)
    local left_x = bounding_box.left_top.x
    local right_x = bounding_box.right_bottom.x - 1
    local bottom_y = bounding_box.right_bottom.y - 1
    local top_y = bounding_box.left_top.y

    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(bounding_box.left_top.x,
        bounding_box.left_top.y)
    local room_wall_definitions, room_gate_definitions = build_room_layout(chunk_indices, left_x, top_y)
    layout_utils.build_and_place_room_layout(surface, room_wall_definitions, room_gate_definitions, function(side)
        return layout_utils.should_place_gates(chunk_indices, side)
    end)
    make_lamps(surface, left_x, right_x, bottom_y, top_y)

    local scrap_name = "mixed-type-1-scrap"
    if math.random() < 0.5 then
        scrap_name = "mixed-type-2-scrap"
    end

    for i = left_x + 5, right_x - 5, 1 do
        for j = top_y + 5, bottom_y - 5, 1 do
            surface.create_entity {
                name = scrap_name,
                position = { i, j },
                force = "neutral",
                create_build_effect_smoke = false,
                move_stuck_players = false,
                raise_built = false,
                amount = 100 * math.sqrt(i * i + j * j)
            }
        end
    end
end

local function spawn_room(bounding_box, surface)
    create_tiles(bounding_box, surface)
    create_entities(bounding_box, surface)
end

local function generate_room()
    return {
        type = consts.room_types.VAULT
    }
end

local function fulgoran_gate_destroyed(destroyed_entity_position)
    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(destroyed_entity_position.x,
        destroyed_entity_position.y)

    local x_offset = math.floor(destroyed_entity_position.x - chunk_indices.x * 32)
    local y_offset = math.floor(destroyed_entity_position.y - chunk_indices.y * 32)

    if (x_offset == 0) then
        return {
            x = chunk_indices.x - 1,
            y = chunk_indices.y
        }
    elseif (x_offset == 31) then
        return {
            x = chunk_indices.x + 1,
            y = chunk_indices.y
        }
    elseif (y_offset == 0) then
        return {
            x = chunk_indices.x,
            y = chunk_indices.y - 1
        }
    elseif (y_offset == 31) then
        return {
            x = chunk_indices.x,
            y = chunk_indices.y + 1
        }
    else
        return chunk_indices
    end
end

return {
    generate_room = generate_room,
    spawn_room = spawn_room,
    fulgoran_gate_destroyed = fulgoran_gate_destroyed
}
