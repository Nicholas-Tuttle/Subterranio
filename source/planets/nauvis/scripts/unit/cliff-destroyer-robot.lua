local bot_search_distance = 128

local function get_nearest_entity_position(bot, max_radius, name)
    local surface = bot.surface
    local position = bot.position
    local radius = 0

    -- This needs to use integers so the searching can be efficient. Use math.floor on everything

    local upper_bound = math.floor(max_radius / 2)
    local last_found_distance = math.floor(max_radius)

    local debug_search_iterations = 0

    local maximum_found_entity_count_before_linear_distance_check = 5

    while upper_bound < last_found_distance do
        debug_search_iterations = debug_search_iterations + 1

        local entity_count = surface.count_entities_filtered{
            position = position,
            radius = upper_bound,
            name = {name}
        }

        -- game.print("Found " .. entity_count .. " " .. name .. "(s) within a search area of " .. upper_bound .. " tiles")

        -- Shrink the search area if there are too many
        if entity_count > maximum_found_entity_count_before_linear_distance_check then
            last_found_distance = upper_bound
            upper_bound = math.floor(upper_bound / 2)
        -- If there are only a few things, just go find there distances and continue on
        elseif entity_count > 0 then
            last_found_distance = upper_bound
        -- Otherwise if there are no items, expand the search area
        else
            upper_bound = upper_bound + math.floor((last_found_distance - upper_bound + 1) / 2)
        end
    end

    radius = upper_bound

    local final_cliff_count = surface.count_entities_filtered{
        position = position,
        radius = radius,
        name = {name}
    }

    -- game.print("Took " .. debug_search_iterations .. " search iterations to find " .. final_cliff_count .. " " .. name .. "(s) at distance " .. radius)

    if radius == 0 or radius > max_radius then return nil end

    local entities = surface.find_entities_filtered{
        position = position,
        radius = radius,
        name = {name},
        limit = final_cliff_count
    }

    if entities == nil or #entities == 0 then return nil end

    -- game.print("Found " .. final_cliff_count .. " " .. name .. " entities within a search area of " .. radius .. " tiles")

    local shortest_length = bot_search_distance + 1
    local shortest_position = nil
    for i = 1, #entities do
        local entity_position = entities[i].position
        local x_distance = position.x - entity_position.x
        local y_distance = position.y - entity_position.y
        local length = math.sqrt(x_distance * x_distance + y_distance * y_distance)
        if length < shortest_length then
            shortest_length = length
            shortest_position = entity_position
        end
    end

    return shortest_position
end

local function send_bot_to_nearest_cliff(bot)
    local target_postition = get_nearest_entity_position(bot, bot_search_distance, "impassable-cave-wall")
    if target_postition == nil then return end

    local destination = target_postition

    -- Find the vector from the current position to the destination
    -- Follow that vector to the destination minus about 2 tiles so it is in open space (guaranteed to be open space)
    local position = bot.position
    local travel_vector = {x = destination.x - position.x, y = destination.y - position.y}
    local travel_vector_magnitude = math.sqrt(travel_vector.x ^ 2 + travel_vector.y ^ 2)
    local travel_vector_normalized = {x = travel_vector.x / travel_vector_magnitude, y = travel_vector.y / travel_vector_magnitude}
    local travel_vector_stopping_gap = {x = travel_vector_normalized.x * 2, y = travel_vector_normalized.y * 2}

    destination = {x = destination.x - travel_vector_stopping_gap.x, y = destination.y - travel_vector_stopping_gap.y}
    
    -- Move the bot to that position
    bot.add_autopilot_destination(destination)
end

function built_cliff_destroyer_robot(event)
    local bot = event.entity
    send_bot_to_nearest_cliff(bot)
end

local function send_bot_to_nearest_port(bot)
    local target_postition = get_nearest_entity_position(bot, bot_search_distance, "cliff-destroyer-port")
    if target_postition == nil then return end
    bot.add_autopilot_destination(target_postition)
end

function cliff_destroyer_robot_completed_command(event)
    local bot = event.vehicle

    if event.vehicle.name ~= "cliff-destroyer-robot" then return end

    -- TODO: laser the nearest cliff wall for a moment
    -- Then destroy it and TODO: collect its contents
    -- TODO: Clean this  up for situations like no port and then one is build or a new chunk is generated, etc. etc.
    local cliff_walls = bot.surface.find_entities_filtered{
        position = bot.position,
        radius = 4,
        name = {"impassable-cave-wall"},
        limit = 1
    }

    if cliff_walls ~= nil and #cliff_walls > 0 then
        cliff_walls[1].destroy()
        -- game.print("Sending bot to nearest port")
        send_bot_to_nearest_port(bot)
    else
        -- game.print("Sending bot to nearest cliff")
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
