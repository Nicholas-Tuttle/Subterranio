local layout_utils = require("scripts.map-gen.rooms.layout-utils")
local consts = require("scripts.map-gen.map-gen-constants")

local function build_window_orientation_data(window_walls)
    local orientation_data = {}

    for _, wall in ipairs(window_walls) do
        local position = { x = math.floor(wall.position.x), y = math.floor(wall.position.y) }
        if orientation_data[position.x] == nil then
            orientation_data[position.x] = {}
        end

        orientation_data[position.x][position.y] = layout_utils.create_orientation_entry(
            { x = position.x, y = position.y },
            wall.name
        )
    end

    return orientation_data
end

local function rebuild_wall(wall, window_orientation_data)
    local surface = wall.surface
    local position = wall.position
    local orientation = layout_utils.resolve_wall_orientation(window_orientation_data, { x = math.floor(position.x), y = math.floor(position.y) })

    wall.destroy()

    surface.create_entity {
        name = consts.wall_entity_name,
        position = position,
        cliff_orientation = orientation
    }
end

local function rebuild_gate(gate)
    local surface = gate.surface
    local position = gate.position
    local direction = gate.direction

    gate.destroy()

    surface.create_entity {
        name = consts.gate_entity_name,
        position = position,
        direction = direction,
        force = "enemy",
        create_build_effect_smoke = false,
        move_stuck_players = true,
        raise_built = true
    }
end

local function main()
    local surface = game.surfaces["fulgoran_subway"]
    if surface == nil then
        return
    end

    local walls = surface.find_entities_filtered { name = consts.wall_entity_name }

    log("Migration: Rebuilding " .. #walls .. " fulgoran-wall-cliff entities on fulgoran_subway surface.")

    if #walls == 0 then
        return
    end

    local min_x = math.huge
    local max_x = -math.huge
    local min_y = math.huge
    local max_y = -math.huge

    for _, wall in pairs(walls) do
        local position = wall.position
        local x = math.floor(position.x)
        local y = math.floor(position.y)

        min_x = math.min(min_x, x)
        max_x = math.max(max_x, x)
        min_y = math.min(min_y, y)
        max_y = math.max(max_y, y)
    end

    local start_window_x = math.floor(min_x / 32)
    local end_window_x = math.floor(max_x / 32)
    local start_window_y = math.floor(min_y / 32)
    local end_window_y = math.floor(max_y / 32)

    if min_x < 0 then
        start_window_x = start_window_x - 1
    end
    if max_x < 0 then
        end_window_x = end_window_x - 1
    end
    if min_y < 0 then
        start_window_y = start_window_y - 1
    end
    if max_y < 0 then
        end_window_y = end_window_y - 1
    end

    local window_walls_by_key = {}

    for _, wall in pairs(walls) do
        local position = wall.position
        local x = math.floor(position.x)
        local y = math.floor(position.y)
        local window_x = math.floor(x / 32)
        local window_y = math.floor(y / 32)
        if x < 0 then
            window_x = window_x - 1
        end
        if y < 0 then
            window_y = window_y - 1
        end
        local window_key = window_x .. ":" .. window_y
        local window_walls = window_walls_by_key[window_key]

        if window_walls == nil then
            window_walls = {}
            window_walls_by_key[window_key] = window_walls
        end

        window_walls[#window_walls + 1] = wall
    end

    for window_y = start_window_y, end_window_y, 1 do
        for window_x = start_window_x, end_window_x, 1 do
            local window_key = window_x .. ":" .. window_y
            local window_walls = window_walls_by_key[window_key]
            if window_walls ~= nil then
                local window_orientation_data = build_window_orientation_data(window_walls)
                for _, wall in ipairs(window_walls) do
                    rebuild_wall(wall, window_orientation_data)
                end
            end
        end
    end

    local gates = surface.find_entities_filtered { name = consts.gate_entity_name }

    log("Rebuilding " .. #gates .. " gates on fulgoran_subway surface.")

    for _, gate in pairs(gates) do
        rebuild_gate(gate)
    end
end

main()
