script.on_init(function ()
    storage.MineshaftTargetInfo = {}
end)

remote.add_interface("subterranio_base", {
    --- @alias TargetSurfaceVisitationRequirements { 
    ---     target_surfaces: string[], 
    ---     tech_requirements: string[], 
    ---     equipment_requirements: string[] 
    --- }



    --- Registers a surface as a connected underground surface for another planet. 
    --- The requirements to reach this surface must include the equipment grid items and technology unlocks (or empty lists if none).
    --- If a surface_name is duplicated the value will be overwritten with the last value. If merging
    --- is intended, the current value must be retrieved with `get_target_surface_visitation_requirements_v1`
    --- and manually merged, then re-registered with this function.
    ---
    --- ```
    --- Args:
    --- 
    --- requirements -> {
    ---     string[] target_surfaces, 
    ---         The full list of surfaces associated with this new surface.
    ---         All names must match internal ids for the surfaces. 
    ---         For example, ["fulgora", "fulgoran_subway"].
    ---     string[] tech_requirements, 
    ---         The full list of technology unlock requirements in order for a player to travel to this surface. 
    ---         All technology requirements must match internal ids for the technologies. 
    ---         For example, Fulgora requires ["tunnelling-drill-equipment", "electrostatic-drill-equipment"].
    ---     string[] equipment_requirements
    ---         All equipment grid requirements for the player to travel to this surface.
    ---         For example, Fulgora requires ["tunnelling-drill-equipment"].
    --- }
    --- 
    --- Returns:
    ---     true when the surface is successfully registered, otherwise false
    --- ```
    --- 
    --- @param requirements TargetSurfaceVisitationRequirements
    --- @return boolean
    register_target_surface_visitation_requirements_v1 = function (requirements)
        if requirements.target_surfaces == nil
            or requirements.tech_requirements == nil
            or requirements.equipment_requirements == nil then
                return false
            end

        for _, value in pairs(requirements.target_surfaces) do
            storage.MineshaftTargetInfo[value] = {
                target_surfaces = requirements.target_surfaces,
                tech_requirements = requirements.tech_requirements,
                equipment_requirements = requirements.equipment_requirements
            }
        end
        return true
    end,

    --- Gets the target surface requirements based on the surfaces name, or nil when not found.
    ---
    ---```
    --- Args:
    --- surface_name -> string
    ---     The name of the surface to retrieve the requirements of
    --- 
    --- Returns:
    --- nil when not found, otherwise:
    --- 
    --- TargetSurfaceVisitationRequirements {
    ---     string[] target_surfaces,
    ---         The surfaces associated with this surface.
    ---         For example, ["fulgora", "fulgoran_subway"]
    ---     string[] tech_requirements,
    ---         The technology requirements to reach the surface
    ---         For example, ["tunnelling-drill-equipment", "electrostatic-drill-equipment"]
    ---     string[] equipment_requirements
    ---         The equipment requirements to reach the surface
    ---         For example, ["tunnelling-drill-equipment"]
    --- } 
    --- ```
    --- @param surface_name string
    --- @return TargetSurfaceVisitationRequirements | nil
    get_target_surface_visitation_requirements_v1 = function (surface_name)
        local requirements = storage.MineshaftTargetInfo[surface_name]

        if requirements == nil then
            return nil
        end

        return {
            surface_name = surface_name,
            target_surfaces = requirements.target_surfaces,
            tech_requirements = requirements.tech_requirements,
            equipment_requirements = requirements.equipment_requirements
        }
    end
})
