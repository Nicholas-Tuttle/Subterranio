local base_grid = require("base-grid-filler")

script.on_event(defines.events.on_chunk_generated, function (event)
    local grid_size_random = math.random()
    local grid_size = 16
    -- if grid_size_random >= 0.7 then
    --     grid_size = 8
    -- end
    if grid_size_random >= 0.9 then
        grid_size = 32
    end
    base_grid.generate_base_rooms(event.area, event.surface, grid_size)
end)

script.on_event(defines.events.on_entity_died, function (event)
    game.print("Fulgoran gate destroyed")
end,
{{
    filter = "name",
    name = "fulgoran-gate",
    force = "neutral"
}})

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
