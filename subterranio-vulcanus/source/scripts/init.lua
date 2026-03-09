local function subterrain_base_register_target_surface_visitation_requirements_v1(requirements) 
    remote.call("subterranio_base", "register_target_surface_visitation_requirements_v1", requirements)
end

script.on_init(function ()
    local vulcanus_surface_family = {
        "vulcanus",
        "vulcanus_lava_tubes"
    }

    local vulcanus_tech_requirements = {
        "tunnelling-drill-equipment"
    }

    local vulcanus_equipment_requirements = {
        "heat-resistant-tunnelling-drill-equipment"
    }

    subterrain_base_register_target_surface_visitation_requirements_v1({
        surface_name = "vulcanus",
        target_surfaces = vulcanus_surface_family,
        tech_requirements = vulcanus_tech_requirements,
        equipment_requirements = vulcanus_equipment_requirements
    })

    subterrain_base_register_target_surface_visitation_requirements_v1({
        surface_name = "vulcanus_lava_tubes",
        target_surfaces = vulcanus_surface_family,
        tech_requirements = vulcanus_tech_requirements,
        equipment_requirements = vulcanus_equipment_requirements
    })
end)
