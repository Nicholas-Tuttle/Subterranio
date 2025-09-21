local fulgoran_subway = require("scripts.map-gen.fulgoran-subway")

local function subterrain_base_register_target_surface_visitation_requirements_v1(requirements)
    remote.call("subterranio_base", "register_target_surface_visitation_requirements_v1", requirements)
end

local function subterrain_base_register_pre_tunnelling_drill_usage_function_v1(mod_name, func_name)
    remote.call("subterranio_base", "register_pre_tunnelling_drill_usage_function_v1", mod_name, func_name)
end

remote.add_interface("subterranio_fulgora", {
    pre_tunnelling_function = function (surface_name, target_position)
        fulgoran_subway.pre_tunnelling_callback(surface_name, target_position)
    end
})

script.on_init(function ()
    local fulgora_surface_family = {
        "fulgora",
        "fulgoran_subway"
    }

    local fulgora_tech_requirements = {
        "tunnelling-drill-equipment",
        -- "electrostatic-drill-equipment"
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

    subterrain_base_register_pre_tunnelling_drill_usage_function_v1("subterranio_fulgora", "pre_tunnelling_function")
end)
