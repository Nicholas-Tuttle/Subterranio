script.on_event(defines.events.on_tower_pre_mined_plant, function(event)
    local plant_position = event.plant.position

    if event.surface ~= "gleban_biospheres" then return end

    if event.plant.name == "cold-resistant-bacteria" or event.plant.name == "heat-resistant-bacteria" then
        game.log(serpent.line(event.plant))
        -- Remove mycelium value from tiles below this plant
        -- If there is none left, switch to the other tile type that accepts fungi
    end

    if event.plant.name == "compression-resistant-fungi" or event.plant.name == "expansion-resistant-fungi" then
        game.log(serpent.line(event.plant))
        -- Add mycelium value to tiles below this plant
        -- If it goes above the certain threshold, switch to the other tile type that accepts bacteria
    end
end)