local function add_frozen_and_thaw_recipes(item_key, item_value)
    if (item_value.spoil_ticks ~= nil and item_value.spoil_ticks > 0) and (item_value.spoil_result ~= nil or item_value.spoil_to_trigger_result ~= nil) then
        if data.raw["item-subgroup"]["frozen-" .. item_value.subgroup] == nil then
            data:extend({
                {
                    type = "item-subgroup",
                    name = "frozen-" .. item_value.subgroup,
                    group = "packaging-and-frozen",
                    order = item_value.order
                }
            })
        end

        if data.raw["item-subgroup"]["thawed-" .. item_value.subgroup] == nil then
            data:extend({
                {
                    type = "item-subgroup",
                    name = "thawed-" .. item_value.subgroup,
                    group = "packaging-and-frozen",
                    order = item_value.order
                }
            })
        end

        local frozen_item = {
            type = "item",
            name = "frozen-" .. item_key,
            icon = nil,
            icons = item_value.icons,
            subgroup = "frozen-" .. item_value.subgroup,
            order = "frozen-" .. item_key,
            stack_size = item_value.stack_size,
            localised_name = { "item-name.frozen", {"item-name." .. item_key} },
        }

        if item_value.icon ~= nil then
            frozen_item.icons = { { icon = item_value.icon, icon_size = item_value.icon_size }, { icon = "__core__/graphics/icons/alerts/frozen-icon.png", icon_size = 64, scale = 0.3, shift = { 13, -13 } } }
        elseif frozen_item.icons ~= nil then
            frozen_item.icons[#frozen_item.icons + 1] = { icon = "__core__/graphics/icons/alerts/frozen-icon.png", icon_size = 64, scale = 0.3, shift = { 13, -13 } }
        end

        log("Created frozen version of item: " .. serpent.line(item_value) .. " -> " .. serpent.line(frozen_item))

        local frozen_recipe = {
            type = "recipe",
            name = "frozen-" .. item_key,
            category = "ice-machine",
            subgroup = "frozen-" .. item_value.subgroup,
            order = item_key,
            energy_required = 1,
            icons = frozen_item.icons,
            ingredients = {
                { type = "item", name = item_key,  amount = 1 },
                { type = "item", name = "ice-box", amount = 1 }
            },
            results = {
                { type = "item", name = "frozen-" .. item_key, amount = 1 }
            },
            localised_name = { "item-name.frozen", {"item-name." .. item_key} },
        }

        local thawed_recipe = {
            type = "recipe",
            name = "thaw-" .. item_key,
            category = "smelting",
            subgroup = "thawed-" .. item_value.subgroup,
            order = item_key,
            energy_required = 1,
            icons = table.deepcopy(frozen_item.icons),
            ingredients = {
                { type = "item", name = "frozen-" .. item_key, amount = 1 }
            },
            results = {
                { type = "item", name = item_key,      amount = 1, percent_spoiled = 0.5, probability = 0.9 },
                { type = "item", name = "ice-box", amount = 1 },
            },
            allow_productivity = false,
            allow_quality = false,
            auto_recycle = false,
            main_product = item_key,
            localised_name = { "item-name.thawed", {"item-name." .. item_key} },
        }
        thawed_recipe.icons[#thawed_recipe.icons].icon = "__base__/graphics/icons/signal/signal-fire.png"
        thawed_recipe.icons[#thawed_recipe.icons].icon_size = 64
        thawed_recipe.icons[#thawed_recipe.icons].tint = { r = 255, g = 0, b = 0 }

        data:extend({ frozen_item, frozen_recipe, thawed_recipe })
    end
end

for item_key, item_value in pairs(data.raw["item"]) do
    add_frozen_and_thaw_recipes(item_key, item_value)
end

for item_key, item_value in pairs(data.raw["capsule"]) do
    add_frozen_and_thaw_recipes(item_key, item_value)
end
