local base_grid = require("base-grid-filler")
local chunk_information = require("chunk-information")
local starting_area = require("starting-area")
local consts = require("map-gen-constants")

local function clear_tiles(bounding_box, surface)
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
                name = "out-of-map"
            }
            index = index + 1
        end
    end
    local correct_tiles = true
    local remove_colliding_entities = true
    local remove_colliding_decoratives = true 
    surface.set_tiles(tiles, correct_tiles, remove_colliding_entities, remove_colliding_decoratives)
end

script.on_event(defines.events.on_chunk_generated, function (event)
    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(event.area.left_top.x, event.area.left_top.y)
    if ((chunk_indices.x == -1 or chunk_indices.x == 0) and (chunk_indices.y == -1 or chunk_indices.y == 0)) then
        starting_area.generate_room(event.area, event.surface)
    else
        clear_tiles(event.area, event.surface)
    end
end)

local function get_destination_chunk_indicies(chunk_indices, position)
    local x_offset = math.floor(position.x - chunk_indices.x * 32)
    local y_offset = math.floor(position.y - chunk_indices.y * 32)

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

script.on_event(defines.events.on_entity_died, function (event)
    local entrance_position = {
        x = math.floor(event.entity.position.x),
        y = math.floor(event.entity.position.y)
    }
    local chunk_indices = chunk_information.chunk_indices_from_raw_coordinates(entrance_position.x, entrance_position.y)
    local next_chunk_indices = get_destination_chunk_indicies(chunk_indices, entrance_position)

    -- game.print("Current chunk indices {" .. chunk_indices.x .. "," .. chunk_indices.y .. "}, next chunk indices {" .. next_chunk_indices.x .. "," .. next_chunk_indices.y .. "}")

    base_grid.generate_base_rooms(next_chunk_indices, event.entity.surface, entrance_position)
end,
{
    { filter = "name", name = "fulgoran-gate", force = "neutral" }
})

script.on_event(defines.events.script_raised_built, function(event)
    local entity = event.entity
    if (entity.name == "fulgoran-gate") then
        entity.active = false
    end

    if (entity.name == "fulgoran-wall") then
        entity.destructible = false
    end

    entity.minable_flag = false
    entity.operable = false
end,
{
    { filter = "name", name = "fulgoran-gate", force = "neutral" },
    { filter = "name", name = "fulgoran-wall", force = "neutral" }
})
