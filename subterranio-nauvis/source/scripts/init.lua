local function subterrain_base_register_target_surface_visitation_requirements_v1(requirements) 
    remote.call("subterranio_base", "register_target_surface_visitation_requirements_v1", requirements)
end

script.on_init(function ()
    local nauvis_surface_family = {
        "nauvis",
        "subterrain"
    }

    local nauvis_tech_requirements = {
        "tunnelling-drill-equipment"
    }

    local basic_equipment_requirements = {
        "tunnelling-drill-equipment"
    }

    subterrain_base_register_target_surface_visitation_requirements_v1({
        surface_name = "nauvis",
        target_surfaces = nauvis_surface_family,
        tech_requirements = nauvis_tech_requirements,
        equipment_requirements = basic_equipment_requirements
    })

    subterrain_base_register_target_surface_visitation_requirements_v1({
        surface_name = "subterrain",
        target_surfaces = nauvis_surface_family,
        tech_requirements = nauvis_tech_requirements,
        equipment_requirements = basic_equipment_requirements
    })
end)
