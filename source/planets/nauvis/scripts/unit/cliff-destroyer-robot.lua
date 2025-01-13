local function get_nearest_cliff(bot, max_radius)
    local surface = bot.surface
    local position = bot.position

    local radius = 0
    for i = 1, max_radius do
        local cliff_count = surface.count_entities_filtered{
            position = position,
            radius = i,
            name = {"impassable-cave-wall"}
        }

        if cliff_count > 0 then
            radius = i
            break
        end
    end

    local impassable_cliffs = surface.find_entities_filtered{
        position = position,
        radius = radius,
        name = {"impassable-cave-wall"},
        limit = 1
    }

    if impassable_cliffs == nil or #impassable_cliffs == 0 then return nil end
    return impassable_cliffs[1]
end

local function send_bot_to_nearest_cliff(bot)
    local target = get_nearest_cliff(bot, 128)
    if target == nil then return end

    local destination = target.position

    -- Find the vector from the current position to the destination
    -- Follow that vector to the destination minus about 2 tiles so it is in open space (guaranteed to be open space)
    local position = bot.position
    local travel_vector = {x = destination.x - position.x, y = destination.y - position.y}
    local travel_vector_magnitude = math.sqrt(travel_vector.x ^ 2 + travel_vector.y ^ 2)
    local travel_vector_normalized = {x = travel_vector.x / travel_vector_magnitude, y = travel_vector.y / travel_vector_magnitude}
    local travel_vector_stopping_gap = {x = travel_vector_normalized.x * 3, y = travel_vector_normalized.y * 3}

    destination = {x = destination.x - travel_vector_stopping_gap.x, y = destination.y - travel_vector_stopping_gap.y}
    
    -- Move the bot to that position
    bot.add_autopilot_destination(destination)
end

function built_cliff_destroyer_robot(event)
    local bot = event.entity
    send_bot_to_nearest_cliff(bot)
end

local function get_nearest_port(bot)
    local surface = bot.surface
    local position = bot.position

    local radius = 0
    for i = 1, 128 do
        local port_count = surface.count_entities_filtered{
            position = position,
            radius = i,
            name = {"cliff-destroyer-port"}
        }

        if port_count > 0 then
            radius = i
            break
        end
    end

    local port = surface.find_entities_filtered{
        position = position,
        radius = radius,
        name = {"cliff-destroyer-port"},
        limit = 1
    }

    if port == nil or #port == 0 then return nil end
    return port[1]
end

local function send_bot_to_nearest_port(bot)
    local target = get_nearest_port(bot)
    if target == nil then return end
    bot.add_autopilot_destination(target.position)
end

function cliff_destroyer_robot_completed_command(event)
    local bot = event.vehicle

    if event.vehicle.name ~= "cliff-destroyer-robot" then return end

    -- TODO: laser the nearest cliff wall for a moment
    -- Then destroy it and TODO: collect its contents
    -- TODO: Clean this  up for situations like no port and then one is build or a new chunk is generated, etc. etc.
    local target = get_nearest_cliff(bot, 4)
    if target ~= nil then
        target.destroy()
        send_bot_to_nearest_port(bot)
    else
        send_bot_to_nearest_cliff(bot)
    end
end

function cliff_destroyer_port_built(event)
    local surface = event.entity.surface
    local entities = surface.find_entities_filtered{
        name = {"cliff-destroyer-robot"}
    }

    for _, bot in pairs(entities) do
        if bot.speed == 0 then
            bot.add_autopilot_destination(event.entity.position)
        end
    end
end
