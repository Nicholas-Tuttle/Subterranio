local chunk_information = require("scripts.map-gen.chunk-information")
local consts = require("scripts.map-gen.map-gen-constants")
local rail_subtypes = require("scripts.map-gen.rooms.rail-subtypes")

local layout_utils = {}

function layout_utils.create_orientation_entry(position, name)
    return {
        position = { x = position.x, y = position.y },
        name = name
    }
end

function layout_utils.resolve_wall_orientation(placements, position)
    if placements == nil then
        return "north-to-south"
    end

    local has_above = placements[position.x] ~= nil and placements[position.x][position.y - 1] ~= nil and
        placements[position.x][position.y - 1].name == consts.wall_entity_name
    local has_below = placements[position.x] ~= nil and placements[position.x][position.y + 1] ~= nil and
        placements[position.x][position.y + 1].name == consts.wall_entity_name
    local has_left = placements[position.x - 1] ~= nil and placements[position.x - 1][position.y] ~= nil and
        placements[position.x - 1][position.y].name == consts.wall_entity_name
    local has_right = placements[position.x + 1] ~= nil and placements[position.x + 1][position.y] ~= nil and
        placements[position.x + 1][position.y].name == consts.wall_entity_name

    if has_above and not has_below and not has_left and not has_right then
        return "north-to-none"
    end

    if not has_above and has_below and not has_left and not has_right then
        return "south-to-none"
    end

    if not has_above and not has_below and (has_left or has_right) then
        return "west-to-east"
    end

    if has_above and not has_below and has_left and not has_right then
        return "north-to-west"
    end

    if has_above and not has_below and not has_left and has_right then
        return "north-to-east"
    end

    if not has_above and has_below and has_left and not has_right then
        return "south-to-west"
    end

    if not has_above and has_below and not has_left and has_right then
        return "south-to-east"
    end

    if has_above and has_below and has_left and not has_right then
        return "north-to-south"
    end

    if has_above and has_below and not has_left and has_right then
        return "north-to-south"
    end

    if has_above and not has_below and has_left and has_right then
        return "west-to-east"
    end

    if not has_above and has_below and has_left and has_right then
        return "west-to-east"
    end

    return "north-to-south"
end

local function build_room_layout_internal(wall_placements, gate_definitions, should_place_gate)
    local placements = {}

    for _, definition in pairs(wall_placements or {}) do
        if placements[definition.position.x] == nil then
            placements[definition.position.x] = {}
        end

        placements[definition.position.x][definition.position.y] = {
            name = consts.wall_entity_name,
        }
    end

    for _, side in pairs({ "left", "right", "bottom", "top" }) do
        if should_place_gate(side) then
            for _, definition in pairs(gate_definitions[side] or {}) do
                if placements[definition.position.x] == nil then
                    placements[definition.position.x] = {}
                end

                placements[definition.position.x][definition.position.y] = {
                    name = consts.gate_entity_name,
                    direction = definition.direction,
                }
            end
        end
    end

    for x, col in pairs(placements) do
        for y, value in pairs(col) do
            if value.name == consts.wall_entity_name then
                value.orientation = layout_utils.resolve_wall_orientation(placements, { x = x, y = y })
            end
        end
    end

    return placements
end

local function place_room_layout_internal(surface, placements)
    for x, col in pairs(placements) do
        for y, entity in pairs(col) do
            if entity.name == consts.wall_entity_name then
                surface.create_entity {
                    name = consts.wall_entity_name,
                    cliff_orientation = entity.orientation,
                    position = { x = x, y = y},
                    force = "neutral",
                    create_build_effect_smoke = false,
                    move_stuck_players = true,
                    raise_built = true
                }
            elseif entity.name == consts.gate_entity_name then
                surface.create_entity {
                    name = consts.gate_entity_name,
                    position = { x = x, y = y},
                    direction = entity.direction,
                    force = "enemy",
                    create_build_effect_smoke = false,
                    move_stuck_players = true,
                    raise_built = true
                }
            end
        end
    end
end

function layout_utils.build_and_place_room_layout(surface, wall_placements, gate_definitions, should_place_gate)
    local placements = build_room_layout_internal(wall_placements, gate_definitions, should_place_gate)
    place_room_layout_internal(surface, placements)
end

function layout_utils.should_place_gates(chunk_indices, side)
    local chunk = nil
    if side == "left" then
        chunk = chunk_information.get_chunk_data({ x = chunk_indices.x - 1, y = chunk_indices.y })
        return not (chunk and chunk.type == consts.room_types.RAILWAY and chunk.subtype ~= rail_subtypes.station_right.subtype)
    elseif side == "right" then
        chunk = chunk_information.get_chunk_data({ x = chunk_indices.x + 1, y = chunk_indices.y })
        return not (chunk and chunk.type == consts.room_types.RAILWAY and chunk.subtype ~= rail_subtypes.station_left.subtype)
    elseif side == "bottom" then
        chunk = chunk_information.get_chunk_data({ x = chunk_indices.x, y = chunk_indices.y + 1 })
        return not (chunk and chunk.type == consts.room_types.RAILWAY and chunk.subtype ~= rail_subtypes.station_top.subtype)
    elseif side == "top" then
        chunk = chunk_information.get_chunk_data({ x = chunk_indices.x, y = chunk_indices.y - 1 })
        return not (chunk and chunk.type == consts.room_types.RAILWAY and chunk.subtype ~= rail_subtypes.station_bottom.subtype)
    end

    return true
end

return layout_utils
