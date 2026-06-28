local graphics_tinter = require("utilities.graphics-tinter")

local function update_icon_graphics(type, source, destination, tint)
    if data.raw[type] == nil then
        return
    end
    local entry = data.raw[type][destination]
    if entry == nil or data.raw[type][source] == nil then
        return
    end
    if data.raw[type][source].icon then
        entry.icons = { { icon = data.raw[type][source].icon, icon_size = data.raw[type][source].icon_size, tint = tint } }
        entry.icon = nil
    elseif data.raw[type][source].icons then
        entry.icons = table.deepcopy(data.raw[type][source].icons)
    end

    entry = graphics_tinter.tint(entry, tint)
end

local function update_entity_graphics(source_type, source, source_tech, destination_type, destination, tint)
    local entry = data.raw[destination_type][destination]
    if entry == nil or data.raw[source_type][source] == nil then
        return
    end
    entry.graphics_set = table.deepcopy(data.raw[source_type][source].graphics_set)
    entry.circuit_connector = table.deepcopy(data.raw[source_type][source].circuit_connector)
    entry.fluid_boxes = table.deepcopy(data.raw[source_type][source].fluid_boxes)
    entry.corpse = table.deepcopy(data.raw[source_type][source].corpse)
    entry = graphics_tinter.tint(entry, tint)

    update_icon_graphics("item", source, destination, tint)
    update_icon_graphics("recipe", source, destination, tint)
    update_icon_graphics("recipe", source .. "-recycling", destination .. "-recycling", tint)
    update_icon_graphics("technology", source_tech, destination, tint)
end

return {
    update_icon_graphics = update_icon_graphics,
    update_entity_graphics = update_entity_graphics
}