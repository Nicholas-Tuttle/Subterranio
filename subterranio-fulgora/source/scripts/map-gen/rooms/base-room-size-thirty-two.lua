local consts = require("scripts.map-gen.map-gen-constants")
local chunk_information = require("scripts.map-gen.chunk-information")
local rails = require("scripts.map-gen.rooms.underground-rails")
local blueprints = require("scripts.map-gen.blueprints")

local function create_tiles(bounding_box, surface, room_key)
    local left_x = bounding_box.left_top.x
    local top_y = bounding_box.left_top.y

    local out_of_map_tile_positions = blueprints.get_out_of_map_room_tile_positions(room_key) or {}

    -- log("For room key: " .. room_key .. " got out-of-map-tiles: " .. serpent.line(out_of_map_tile_positions))

    local tiles = {}
    for x = 0, 31, 1 do
        for y = 0, 31 - 1, 1 do
            if out_of_map_tile_positions[x] == nil or out_of_map_tile_positions[x][y] == nil then
                tiles[#tiles + 1] = {
                    position = { x = x + left_x, y = y + top_y },
                    name = "tutorial-grid"
                }
            end
        end
    end
    local correct_tiles = true
    local remove_colliding_entities = true
    local remove_colliding_decoratives = true
    surface.set_tiles(tiles, correct_tiles, remove_colliding_entities, remove_colliding_decoratives)
end

local function make_walls(surface, left_x, right_x, bottom_y, top_y)
    for i = left_x, right_x, 1 do
        for j = top_y, bottom_y, 1 do
            -- Only make walls on the perimeters
            if i == left_x or i == right_x or j == top_y or j == bottom_y then
                surface.create_entity {
                    name = consts.wall_entity_name,
                    direction = defines.direction.east,
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

local function make_left_doors(surface, chunk_indices, left_x, bottom_y, top_y)
    local chunk = chunk_information.get_chunk_data({ x = chunk_indices.x - 1, y = chunk_indices.y })
    if chunk and chunk.type == consts.room_types.RAILWAY and chunk.subtype ~= rails.rail_subtypes.station_right.subtype then
        return
    end

    local positions = {
        { left_x, top_y + 3 },
        { left_x, top_y + 4 },
        { left_x, bottom_y - 3 },
        { left_x, bottom_y - 4 }
    }

    for _, position in pairs(positions) do
        surface.create_entity {
            name = "fulgoran-gate",
            position = position,
            direction = defines.direction.north,
            force = "neutral",
            create_build_effect_smoke = false,
            move_stuck_players = true,
            raise_built = true
        }
    end
end

local function make_right_doors(surface, chunk_indices, right_x, bottom_y, top_y)
    local chunk = chunk_information.get_chunk_data({ x = chunk_indices.x + 1, y = chunk_indices.y })
    if chunk and chunk.type == consts.room_types.RAILWAY and chunk.subtype ~= rails.rail_subtypes.station_left.subtype then
        return
    end

    local positions = {
        { right_x, top_y + 3 },
        { right_x, top_y + 4 },
        { right_x, bottom_y - 3 },
        { right_x, bottom_y - 4 }
    }

    for _, position in pairs(positions) do
        surface.create_entity {
            name = "fulgoran-gate",
            position = position,
            direction = defines.direction.north,
            force = "neutral",
            create_build_effect_smoke = false,
            move_stuck_players = true,
            raise_built = true
        }
    end
end

local function make_bottom_doors(surface, chunk_indices, left_x, right_x, bottom_y)
    local chunk = chunk_information.get_chunk_data({ x = chunk_indices.x, y = chunk_indices.y + 1 })
    if chunk and chunk.type == consts.room_types.RAILWAY and chunk.subtype ~= rails.rail_subtypes.station_top.subtype then
        return
    end

    local positions = {
        { left_x + 3,  bottom_y },
        { left_x + 4,  bottom_y },
        { right_x - 3, bottom_y },
        { right_x - 4, bottom_y }
    }

    for _, position in pairs(positions) do
        surface.create_entity {
            name = "fulgoran-gate",
            position = position,
            direction = defines.direction.east,
            force = "neutral",
            create_build_effect_smoke = false,
            move_stuck_players = true,
            raise_built = true
        }
    end
end

local function make_top_doors(surface, chunk_indices, left_x, right_x, top_y)
    local chunk = chunk_information.get_chunk_data({ x = chunk_indices.x, y = chunk_indices.y - 1 })
    if chunk and chunk.type == consts.room_types.RAILWAY and chunk.subtype ~= rails.rail_subtypes.station_bottom.subtype then
        return
    end

    local positions = {
        { left_x + 3,  top_y },
        { left_x + 4,  top_y },
        { right_x - 3, top_y },
        { right_x - 4, top_y }
    }

    for _, position in pairs(positions) do
        surface.create_entity {
            name = "fulgoran-gate",
            position = position,
            direction = defines.direction.east,
            force = "neutral",
            create_build_effect_smoke = false,
            move_stuck_players = true,
            raise_built = true
        }
    end
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

local function create_entities(bounding_box, surface, room_key)
    local left_x = bounding_box.left_top.x
    local right_x = bounding_box.right_bottom.x - 1
    local bottom_y = bounding_box.right_bottom.y - 1
    local top_y = bounding_box.left_top.y

    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(bounding_box.left_top.x,
        bounding_box.left_top.y)
    make_left_doors(surface, chunk_indices, left_x, bottom_y, top_y)
    make_right_doors(surface, chunk_indices, right_x, bottom_y, top_y)
    make_bottom_doors(surface, chunk_indices, left_x, right_x, bottom_y)
    make_top_doors(surface, chunk_indices, left_x, right_x, top_y)
    make_walls(surface, left_x, right_x, bottom_y, top_y)
    make_lamps(surface, left_x, right_x, bottom_y, top_y)

    blueprints.generate(bounding_box, surface, room_key, {
        ["refined-concrete"] = "tutorial-grid"
    }, {
        ["stone-wall"] = "wall-remnants",
        ["small-lamp"] = "lamp-remnants"
    }, true)
end

local function create_enemies(bounding_box, surface, room_key)
    local enemy_count = math.random(1, 50)
    local nauvis_enemy_types = {
        "small-biter",
        "medium-biter",
        "big-biter",
        "behemoth-biter",
        "small-spitter",
        "medium-spitter",
        "big-spitter",
        "behemoth-spitter",
    }

    local gleba_enemy_types = {
        "small-wriggler-pentapod",
        "medium-wriggler-pentapod",
        "big-wriggler-pentapod"
    }

    local enemy_types = nauvis_enemy_types
    if math.random() <= 0.5 then
        enemy_types = gleba_enemy_types
    end

    local flat_in_map_tile_positions = blueprints.get_in_map_room_tile_positions_flattened(room_key)

    for _ = 1, enemy_count, 1 do
        if #flat_in_map_tile_positions >= 1 then
            local random = flat_in_map_tile_positions[math.random(1, #flat_in_map_tile_positions)]
            surface.create_entity {
                name = enemy_types[math.random(1, #enemy_types)],
                position = {
                    x = bounding_box.left_top.x + random.x,
                    y = bounding_box.left_top.y + random.y
                }
            }
        end
    end
end

local function spawn_room(bounding_box, surface)
    local subtype_keys = {
        "fusion_power_plant_32",
        "nuclear_power_plant_32",
        "biolab_32",
        "steam_room_32",
        "server_room_32",
        "kitchen_32",
        "industry_room_32",
        "furnace_room_sinkhole_32"
    }

    local room_key = subtype_keys[math.random(1, #subtype_keys)]

    create_tiles(bounding_box, surface, room_key)
    create_entities(bounding_box, surface, room_key)
    create_enemies(bounding_box, surface, room_key)
end

local function generate_room()
    return {
        type = consts.room_types.SIZE_32
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
