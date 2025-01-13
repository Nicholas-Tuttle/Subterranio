local function ground_player (event) 
    local player = game.get_player(event.player_index)
    if not player or not player.character then return end

    local impassable_cliffs_count = player.surface.count_entities_filtered{
        position = player.position,
        radius = 4,
        name = {"impassable-cave-wall"},
        limit = 1
    }

    if impassable_cliffs_count == 0 then return end

    player.surface.create_entity({
        name = "impassable-cliff-sticker", 
        position = player.position, 
        force = "neutral", 
        target = player.character
    })
end

script.on_event(defines.events.on_player_changed_position, ground_player)