local function tint(object, tint_color)
    local temp = table.deepcopy(object)
    if temp.icon then
        temp.icons = { { icon = temp.icon, tint = tint_color } }
        temp.icon = nil
    elseif temp.icons then
        for _, icon in pairs(temp.icons) do
            if icon.icon then
                icon.tint = tint_color
            end
        end
    elseif temp.graphics_set and temp.graphics_set.base_visualisation
        and temp.graphics_set.base_visualisation.animation and
        temp.graphics_set.base_visualisation.animation.layers then
        for _, layer in pairs(temp.graphics_set.base_visualisation.animation.layers) do
            if layer.filename then
                layer.tint = tint_color
            end
        end
    end
    return temp
end

return {
    tint = tint
}
