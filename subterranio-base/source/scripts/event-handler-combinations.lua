require("entity/mineshaft-belt")

local mineshaft_upward_belt_filter = {
    "mineshaft-belt-up",
    "fast-mineshaft-belt-up",
    "express-mineshaft-belt-up",
    "turbo-mineshaft-belt-up"
}

local mineshaft_downward_belt_filter = {
    "mineshaft-belt-down",
    "fast-mineshaft-belt-down",
    "express-mineshaft-belt-down",
    "turbo-mineshaft-belt-down",
}

local mineshaft_pipe_filter = {
    "mineshaft-pipe-to-ground"
}

local combined_filter = {
    { filter = "name", name = "mineshaft-belt-up" },
    { filter = "name", name = "mineshaft-belt-down" },
    { filter = "name", name = "fast-mineshaft-belt-up" },
    { filter = "name", name = "fast-mineshaft-belt-down" },
    { filter = "name", name = "express-mineshaft-belt-up" },
    { filter = "name", name = "express-mineshaft-belt-down" },
    { filter = "name", name = "turbo-mineshaft-belt-up" },
    { filter = "name", name = "turbo-mineshaft-belt-down" },
    { filter = "name", name = "mineshaft-pipe-to-ground" }
}

local function on_built(event)
    for _, entity in pairs(mineshaft_upward_belt_filter) do
        if event.entity.name == entity then
            built_upward_mineshaft_belt(event)
        end
    end

    for _, entity in pairs(mineshaft_downward_belt_filter) do
        if event.entity.name == entity then
            built_downward_mineshaft_belt(event)
        end
    end

    for _, entity in pairs(mineshaft_pipe_filter) do
        if event.entity.name == entity then
            built_mineshaft_pipe(event)
        end
    end
end

script.on_event(defines.events.on_built_entity, on_built, combined_filter)
script.on_event(defines.events.on_robot_built_entity, on_built, combined_filter)

local function on_pre_destroyed(event)
    for _, entity in pairs(mineshaft_upward_belt_filter) do
        if event.entity.name == entity then
            destroyed_upward_mineshaft_belt(event)
        end
    end

    for _, entity in pairs(mineshaft_downward_belt_filter) do
        if event.entity.name == entity then
            destroyed_downward_mineshaft_belt(event)
        end
    end

    for _, entity in pairs(mineshaft_pipe_filter) do
        if event.entity.name == entity then
            destroyed_mineshaft_pipe(event)
        end
    end
end

script.on_event(defines.events.on_pre_player_mined_item, on_pre_destroyed, combined_filter)
script.on_event(defines.events.on_entity_died, on_pre_destroyed, combined_filter)
script.on_event(defines.events.on_robot_pre_mined, on_pre_destroyed, combined_filter)

-- -- Surface families
-- local nauvis_surface_family = {
--     "nauvis",
--     "subterrain"
-- }
-- local vulcanus_surface_family = {
--     "vulcanus",
--     "vulcanus_lava_tubes"
-- }
-- local fulgora_surface_family = {
--     "fulgora",
--     "fulgoran_subway"
-- }
-- local gleba_surface_family = {
--     "gleba",
--     "gleba_biospheres"
-- }
-- local aquilo_surface_family = {
--     "aquilo",
--     "aquilan_ice_caverns"
-- }

-- -- Surface drilling tech requirements
-- local nauvis_tech_requirements = {
--     "tunnelling-drill-equipment"
-- }
-- local vulcanus_tech_requirements = {
--     "tunnelling-drill-equipment",
--     "insulated-drill-equipment"
-- }
-- local fulgora_tech_requirements = {
--     "tunnelling-drill-equipment",
--     "electrostatic-drill-equipment"
-- }
-- local gleba_tech_requirements = {
--     "tunnelling-drill-equipment",
--     "waterproof-drill-equipment"
-- }
-- local aquilo_tech_requirements = {
--     "tunnelling-drill-equipment",
--     "thermal-drill-equipment",
--     "insulated-drill-equipment",
--     "electrostatic-drill-equipment",
--     "waterproof-drill-equipment"
-- }

-- -- Surface drilling equipment requirements
-- local basic_equipment_requirements = {
--     "tunnelling-drill-equipment"
-- }

-- TODO: Move this to the individual planet-specific modules
-- MineshaftTargetInfo = {
--     nauvis = {
--         target_surfaces = nauvis_surface_family,
--         tech_requirements = nauvis_tech_requirements,
--         equipment_requirements = basic_equipment_requirements
--     },
--     subterrain = {
--         target_surfaces = nauvis_surface_family,
--         tech_requirements = nauvis_tech_requirements,
--         equipment_requirements = basic_equipment_requirements
--     },
--     vulcanus = {
--         target_surfaces = vulcanus_surface_family,
--         tech_requirements = vulcanus_tech_requirements,
--         equipment_requirements = basic_equipment_requirements
--     },
--     vulcanus_lava_tubes = {
--         target_surfaces = vulcanus_surface_family,
--         tech_requirements = vulcanus_tech_requirements,
--         equipment_requirements = basic_equipment_requirements
--     },
--     fulgora = {
--         target_surfaces = fulgora_surface_family,
--         tech_requirements = fulgora_tech_requirements,
--         equipment_requirements = basic_equipment_requirements
--     },
--     fulgoran_subway = {
--         target_surfaces = fulgora_surface_family,
--         tech_requirements = fulgora_tech_requirements,
--         equipment_requirements = basic_equipment_requirements
--     },
--     gleba = {
--         target_surfaces = gleba_surface_family,
--         tech_requirements = gleba_tech_requirements,
--         equipment_requirements = basic_equipment_requirements
--     },
--     gleba_biospheres = {
--         target_surfaces = gleba_surface_family,
--         tech_requirements = gleba_tech_requirements,
--         equipment_requirements = basic_equipment_requirements
--     },
--     aquilo = {
--         target_surfaces = aquilo_surface_family,
--         tech_requirements = aquilo_tech_requirements,
--         equipment_requirements = basic_equipment_requirements
--     },
--     aquilan_ice_caverns = {
--         target_surfaces = aquilo_surface_family,
--         tech_requirements = aquilo_tech_requirements,
--         equipment_requirements = basic_equipment_requirements
--     }
-- }
