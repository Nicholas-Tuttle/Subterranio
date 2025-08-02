local function subterrain_base_register_target_surface_visitation_requirements_v1(requirements) 
    remote.call("subterranio_base", "register_target_surface_visitation_requirements_v1", requirements)
end

script.on_init(function ()
    local fulgora_surface_family = {
        "fulgora",
        "fulgoran_subway"
    }

    local fulgora_tech_requirements = {
        "tunnelling-drill-equipment",
        "electrostatic-drill-equipment"
    }

    local basic_equipment_requirements = {
        "tunnelling-drill-equipment"
    }

    subterrain_base_register_target_surface_visitation_requirements_v1({
        surface_name = "fulgora",
        target_surfaces = fulgora_surface_family,
        tech_requirements = fulgora_tech_requirements,
        equipment_requirements = basic_equipment_requirements
    })

    subterrain_base_register_target_surface_visitation_requirements_v1({
        surface_name = "fulgoran_subway",
        target_surfaces = fulgora_surface_family,
        tech_requirements = fulgora_tech_requirements,
        equipment_requirements = basic_equipment_requirements
    })
end)
