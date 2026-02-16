local function tint_recursive(object, tint_value)
    for key, value in pairs(object) do
        if type(value) == "table" then
            -- log("Checking key and value of: " .. serpent.line({ key = key, value = value }))
            -- TODO: Add more here as needed, this is not a complete list
            if value.filename or value.filenames or value.stripes then
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
