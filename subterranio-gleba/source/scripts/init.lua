local function subterrain_base_register_target_surface_visitation_requirements_v1(requirements)
    remote.call("subterranio_base", "register_target_surface_visitation_requirements_v1", requirements)
end

local function register_target_surface_requirements()
    local gleba_surface_family = {
        "gleba",
        "gleban_biospheres"
    }

    local gleba_tech_requirements = {
        "tunnelling-drill-equipment",
        "water-resistant-tunnelling-drill-equipment"
    }

    local basic_equipment_requirements = {
        "tunnelling-drill-equipment"
    }

    subterrain_base_register_target_surface_visitation_requirements_v1({
        surface_name = "gleba",
        target_surfaces = gleba_surface_family,
        tech_requirements = gleba_tech_requirements,
        equipment_requirements = basic_equipment_requirements
    })

    subterrain_base_register_target_surface_visitation_requirements_v1({
        surface_name = "gleban_biospheres",
        target_surfaces = gleba_surface_family,
        tech_requirements = gleba_tech_requirements,
        equipment_requirements = basic_equipment_requirements
    })
end

script.on_configuration_changed(function ()
    register_target_surface_requirements()
end)

script.on_init(function ()
    register_target_surface_requirements()
end)
