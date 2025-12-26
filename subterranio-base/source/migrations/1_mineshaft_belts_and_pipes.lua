-- All mineshaft belts have been switched to downward variants from the json migration
-- On the Nauvis caves, remove all the downward belts and replace with upward belts
-- Do the same with pipes

local function replace_subterrain_belts_and_pipes()
    local surface = game.surfaces["subterrain"]
    local nauvis = game.surfaces["nauvis"]

    local belt_mapping = {
        ["mineshaft-belt-down"] = "mineshaft-belt-up",
        ["fast-mineshaft-belt-down"] = "fast-mineshaft-belt-up",
        ["express-mineshaft-belt-down"] = "express-mineshaft-belt-up",
        ["turbo-mineshaft-belt-down"] = "turbo-mineshaft-belt-up"
    }

    for old_belt, new_belt in pairs(belt_mapping) do
        local belts = surface.find_entities_filtered { name = old_belt, force = game.forces.player }
        for _, belt in pairs(belts) do
            local position = belt.position
            local direction = belt.direction
            local type = belt.linked_belt_type
            local quality = belt.quality
            belt.destroy()

            if type == "output" then
                -- For some reason the direction needs to be flipped when creating the output type belt
                local opposite_direction = {
                    [defines.direction.north] = defines.direction.south,
                    [defines.direction.south] = defines.direction.north,
                    [defines.direction.east] = defines.direction.west,
                    [defines.direction.west] = defines.direction.east
                }

                direction = opposite_direction[direction]
            end

            local new_underground_belt = surface.create_entity {
                name = new_belt,
                position = position,
                direction = direction,
                force = game.forces.player,
                quality = quality
            }
            new_underground_belt.linked_belt_type = type
            new_underground_belt.connect_linked_belts(nauvis.find_entity(old_belt, position))
        end
    end

    local pipes = surface.find_entities_filtered { name = "mineshaft-pipe-down", force = game.forces.player }
    for _, pipe in pairs(pipes) do
        local position = pipe.position
        local quality = pipe.quality
        pipe.destroy()
        surface.create_entity {
            name = "mineshaft-pipe-up",
            position = position,
            force = game.forces.player,
            quality = quality
        }
    end
end

replace_subterrain_belts_and_pipes()
