local function remove_mycellium(surface, plant_position)
    local correct_tiles = true
    local remove_colliding_entities = true
    local remove_colliding_decoratives = true

    local mycellium = surface.find_entities_filtered {
        area = {
            { x = plant_position.x - 1.25, y = plant_position.y - 1.25 },
            { x = plant_position.x + 1.25, y = plant_position.y + 1.25 }
        },
        name = "mycellium"
    }
    -- game.print(serpent.line(mycellium))

    local depleted_tiles = {}
    for _, value in pairs(mycellium) do
        if value.amount > 7 then
            value.amount = value.amount - 7
        else
            local depleted_x = value.position.x
            local depleted_y = value.position.y
            value.deplete()
            depleted_tiles[#depleted_tiles + 1] = {
                x = depleted_x,
                y = depleted_y
            }
        end
    end
    -- game.print(serpent.line(depleted_tiles))

    local tiles = {}
    for _, depleted_tile in pairs(depleted_tiles) do
        if storage.gleban_biospheres[depleted_tile.x] ~= nil then
            -- game.print(serpent.line(storage.gleban_biospheres[plant_position.x]))
            local pre_existing_tile_name = storage.gleban_biospheres[depleted_tile.x][depleted_tile.y]
            -- game.print("Pre existing tile found: " .. tostring(pre_existing_tile_name))

            if pre_existing_tile_name ~= nil then
                -- game.print("Switching back from mycellium to " .. pre_existing_tile_name .. " at position " .. depleted_tile.x .. ", " .. depleted_tile.y)
                tiles[#tiles + 1] = {
                    position = {
                        x = depleted_tile.x,
                        y = depleted_tile.y
                    },
                    name = pre_existing_tile_name,
                }
            end

            storage.gleban_biospheres[depleted_tile.x][depleted_tile.y] = nil
        end
    end
    surface.set_tiles(tiles, correct_tiles, remove_colliding_entities, remove_colliding_decoratives)
end

local function add_mycellium(surface, plant_position)
    local correct_tiles = true
    local remove_colliding_entities = true
    local remove_colliding_decoratives = true

    local mycellium = surface.find_entities_filtered {
        area = {
            { x = plant_position.x - 1.25, y = plant_position.y - 1.25 },
            { x = plant_position.x + 1.25, y = plant_position.y + 1.25 }
        },
        name = "mycellium"
    }

    for _, value in pairs(mycellium) do
        -- game.print("Adding to pre-existing patch, before amount: " .. value.amount)
        value.amount = value.amount + 10

        if value.amount >= 30 then
            local tiles = { {
                position = {
                    x = value.position.x,
                    y = value.position.y
                },
                name = "gleban-subterranean-mycellium-cold",
            } }

            surface.set_tiles(tiles, correct_tiles, remove_colliding_entities, remove_colliding_decoratives)
        end
    end

    local offsets = {
        { x = -1, y = -1 },
        { x = -1, y = 0 },
        { x = -1, y = 1 },
        { x = 0,  y = -1 },
        { x = 0,  y = 0 },
        { x = 0,  y = 1 },
        { x = 1,  y = -1 },
        { x = 1,  y = 0 },
        { x = 1,  y = 1 },
    }
    for _, offset in ipairs(offsets) do
        local found = false
        local offset_x = plant_position.x + offset.x
        local offset_y = plant_position.y + offset.y
        for _, pre_existing in pairs(mycellium) do
            if pre_existing.position.x == offset_x and pre_existing.position.y == offset_y then
                found = true
            end
        end

        if found == false then
            if storage.gleban_biospheres[offset_x] == nil then
                storage.gleban_biospheres[offset_x] = {}
            end

            if storage.gleban_biospheres[offset_x][offset_y] == nil then
                local tile = surface.get_tile(offset_x, offset_y)
                -- game.print("Saving tile of name " .. tile.name .. " at position " .. offset_x .. ", " .. offset_y)
                storage.gleban_biospheres[offset_x][offset_y] = tile.name
            end

            surface.create_entity {
                name = "mycellium",
                position = {
                    x = offset_x,
                    y = offset_y
                },
                force = "neutral",
                amount = 10,
                snap_to_tile_center = true
            }
        end
    end
end

script.on_event(defines.events.on_tower_mined_plant, function(event)
    -- game.print("Event on_tower_pre_mined_plant triggered. Plant name: " .. event.plant.name
    --     .. ", position: (" .. event.plant.position.x .. ", " .. event.plant.position.y .. ")"
    --     .. ", surface: " .. event.plant.surface.name)
    local surface = event.plant.surface

    if surface.name ~= "gleban_biospheres" then return end

    local plant_position = event.plant.position
    plant_position.x = math.floor(plant_position.x) + 0.5
    plant_position.y = math.floor(plant_position.y) + 0.5

    if event.plant.name == "cold-resistant-bacteria" or event.plant.name == "heat-resistant-bacteria" then
        -- Remove mycelium value from tiles below this plant
        -- If there is none left, switch to the other tile type that accepts fungi
        remove_mycellium(surface, plant_position)
    end

    if event.plant.name == "compression-resistant-fungi" or event.plant.name == "expansion-resistant-fungi" then
        -- Add mycelium value to tiles below this plant
        -- If it goes above the certain threshold, switch to the other tile type that accepts bacteria
        add_mycellium(surface, plant_position)
    end
end)
