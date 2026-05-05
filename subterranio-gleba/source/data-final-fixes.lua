for item_key, item_value in pairs(data.raw["item"]) do
    if item_value.spoil_ticks ~= nil and item_value.spoil_ticks > 0 and item_value.spoil_result ~= nil then
        local frozen_item = {
            type = "item",
            name = "frozen-" .. item_key,
            icon = item_value.icon,
            icon_size = item_value.icon_size,
            subgroup = "frozen-food",
            order = "frozen-" .. item_key,
            stack_size = item_value.stack_size
        }
        local frozen_recipe = {
            type = "recipe",
            name = "frozen-" .. item_key,
            category = "ice-machine",
            energy_required = 1,
            ingredients = {
                { type = "item", name = item_key, amount = 1 },
                { type = "item", name = "ice-box", amount = 1 }
            },
            results = {
                { type = "item", name = "frozen-" .. item_key, amount = 1 }
            }
        }
        local thawed_recipe = {
            type = "recipe",
            name = "thaw-" .. item_key,
            category = "smelting",
            energy_required = 1,
            ingredients = {
                { type = "item", name = "frozen-" .. item_key, amount = 1 }
            },
            results = {
                { type = "item", name = item_key, amount = 1, percent_spoiled = 0.5, probability = 0.9 },
                { type = "item", name = "steel-chest", amount = 1 },
            },
            allow_productivity = false,
            allow_quality = false,
            auto_recycle = false,
            main_product = item_key
        }
        data:extend({ frozen_item, frozen_recipe, thawed_recipe })
    end
end