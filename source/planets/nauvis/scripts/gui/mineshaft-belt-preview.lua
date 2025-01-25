local function determine_mineshaft_direction(player)
    local position = player.position
    local surface = player.surface
    local surface_name = surface.name

    local opposite_surface_name = (surface_name == "nauvis" and "subterrain" or "nauvis")
    local target_surface = game.planets[opposite_surface_name].create_surface()

    local target_position = {x = position.x, y = position.y}
    target_surface.request_to_generate_chunks(target_position, 1)
    target_surface.force_generate_chunk_requests()

    target_position = target_surface.find_non_colliding_position(player.character.name, target_position, 100, 0.5, false)
    if not target_position then return nil end
    return target_surface, target_position
end

subterrain.on_event("subterranean-mineshaft-player-preview", function(event)
    local player = game.get_player(event.player_index)
    if not player then return false end

    local target_surface, target_position = determine_mineshaft_direction(player)

    if not target_surface then return false end
    if not target_position then return false end

    local preview = player.gui.left.add{
        type = "frame",
        caption = "Mineshaft Belt Preview"
    }
    preview.style.minimal_width = 200
    preview.style.minimal_height = 200

    local camera = preview.add{
        type = "camera",
        position = target_position,
        surface_index = target_surface.index,
        zoom = 1.0
    }
    camera.style.minimal_width = 200
    camera.style.minimal_height = 200

    return true
end)
