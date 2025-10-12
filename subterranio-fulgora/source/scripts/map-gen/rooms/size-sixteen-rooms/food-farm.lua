local function create_tiles(bounding_box, surface)
    local left_offset = bounding_box.left_top.x + 1
    local downward_offset = bounding_box.left_top.y + 1

    local tile_layout = {
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 1},
        {1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 1},
        {1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 1},
        {1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 1},
        {1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 1},
        {1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 1},
        {1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 1},
        {1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 1},
        {1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 1},
        {1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 1},
        {1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 2, 2, 2, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    }

    local tile_map = {
        "fulgoran-paving",
        "landfill"
    }

    local tiles = {}
    local index = 0
    for y = 1, #tile_layout, 1 do
        for x = 1, #tile_layout[y], 1 do
            tiles[index] = {
                position = {x = x - 1 + left_offset, y = y - 1 + downward_offset},
                name = tile_map[tile_layout[y][x]]
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
    local x_origin = bounding_box.left_top.x
    local y_origin = bounding_box.left_top.y
    local biochamber_offsets = {
        {x = 2, y = 3},
        {x = 2, y = 6},
        {x = 2, y = 9},
        {x = 2, y = 12},
        {x = 9, y = 3},
        {x = 9, y = 6},
        {x = 9, y = 9},
        {x = 9, y = 12},
    }

    for i = 1, #biochamber_offsets do 
        surface.create_entity{
            name = "biochamber-remnants",
            position = { x_origin + biochamber_offsets[i].x, y_origin + biochamber_offsets[i].y },
            force = "neutral",
            create_build_effect_smoke = false,
            move_stuck_players = true
        }
    end

    local lamp_offsets = {
        {x = 1,  y = 1},
        {x = 14, y = 1},
        {x = 1,  y = 14},
        {x = 14, y = 14},
    }

    for i = 1, #lamp_offsets do 
        surface.create_entity{
            name = "fulgoran-lamp",
            position = { x_origin + lamp_offsets[i].x, y_origin + lamp_offsets[i].y },
            force = "neutral",
            create_build_effect_smoke = false,
            move_stuck_players = true
        }
    end
end

local function create_decoratives(bounding_box, surface)
    local x_origin = bounding_box.left_top.x - 1
    local y_origin = bounding_box.left_top.y - 1
    local plant_layout = {
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    }

    local food_options = {
        "blood-grape",
        "blood-grape-vibrant",
        "red-croton",
        "green-croton",
        "polycephalum-balloon",
        "pink-phalanges",
        "green-pita",
        "red-pita",
        "fuchsia-pita",
        "green-pita-mini",
        "green-bush-mini",
        "green-asterisk",
        "red-asterisk",
        "brown-asterisk"
    }
    local food_option = food_options[math.random(1, #food_options)]
    local decoratives = {}
    local index = 0
    for y = 1, #plant_layout, 1 do
        for x = 1, #plant_layout[y], 1 do
            if plant_layout[y][x] == 1 then
                decoratives[index] = {
                    name = food_option,
                    position = { x = x_origin + x, y = y_origin + y },
                    amount = math.random(10, 255)
                }
                index = index + 1
            end
        end
    end

    surface.create_decoratives{
        check_collision = false,
        decoratives = decoratives
    }
end

local function generate(bounding_box, surface)
    create_tiles(bounding_box, surface)
    create_entities(bounding_box, surface)
    create_decoratives(bounding_box, surface)
end

return {
    generate = generate
}