local function spawn_room(bounding_box, surface)
    game.print("Would have spawned an underground fulgoran vault on " .. surface.name .. " at position " .. serpent.line(bounding_box))
end

return {
    spawn_room = spawn_room
}
