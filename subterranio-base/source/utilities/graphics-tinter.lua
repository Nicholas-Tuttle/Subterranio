local function tint_recursive(object, tint_value)
    local excluded = {
        ["circuit_connector"] = true,
        ["radius_visualisation_picture"] = true
    }

    for key, value in pairs(object) do
        if type(value) == "table" and excluded[key] == nil then
            -- log("Checking key and value of: " .. serpent.line({ key = key, value = value }))
            -- TODO: Add more here as needed, this is not a complete list
            if (value.filename and value.filename ~= "__recycler__/graphics/icons/recycling.png" and value.filename ~= "__recycler__/graphics/icons/recycling-top.png")
                or (value.icon and value.icon ~= "__recycler__/graphics/icons/recycling.png" and value.icon ~= "__recycler__/graphics/icons/recycling-top.png")
                or value.filenames or value.stripes then
                value.tint = table.deepcopy(tint_value)
            end

            tint_recursive(value, tint_value)
        end
    end

    return object
end

local function tint(object, tint_value)
    return tint_recursive(object, tint_value)
end

return {
    tint = tint
}
