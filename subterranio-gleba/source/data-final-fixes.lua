local utility_constants = data.raw["utility-constants"].default

local function item_or_entity_localized_name_expression(item_key)
    return { "?", { "item-name." .. item_key }, { "item-description." .. item_key }, { "entity-name." .. item_key } }
end

local function get_items_to_add_frozen_and_thaw_recipes(type)
    local items_to_add = {}
    for item_key, item_value in pairs(data.raw[type]) do
        if (item_value.spoil_ticks ~= nil and item_value.spoil_ticks > 0)
            and (item_value.spoil_result ~= nil or item_value.spoil_to_trigger_result ~= nil)
            and (item_value.hidden == nil or item_value.hidden == false)
            and (item_value.hidden_in_factoriopedia == nil or item_value.hidden_in_factoriopedia == false)
            and item_value.subgroup ~= "other" then
            items_to_add[item_key] = item_value
        end
    end
    return items_to_add
end

local function add_frozen_and_thaw_recipes(item_key, item_value)
    local sanitized_subgroup = item_value.subgroup or "unknown"
    local sanitized_subgroup_order = data.raw["item-subgroup"][sanitized_subgroup] and data.raw["item-subgroup"][sanitized_subgroup].order or "zzz"
    local sanitized_order = item_value.order or "zzz"

    if data.raw["item-subgroup"]["frozen-" .. sanitized_subgroup] == nil then
        data:extend({
            {
                type = "item-subgroup",
                name = "frozen-" .. sanitized_subgroup,
                group = "packaging-and-frozen",
                order = "a-" .. sanitized_subgroup_order
            }
        })
    end

    if data.raw["item-subgroup"]["thawed-" .. sanitized_subgroup] == nil then
        data:extend({
            {
                type = "item-subgroup",
                name = "thawed-" .. sanitized_subgroup,
                group = "packaging-and-frozen",
                order = "b-" .. sanitized_subgroup_order
            }
        })
    end

    local frozen_item = {
        type = "item",
        name = "frozen-" .. item_key,
        icon = nil,
        icons = table.deepcopy(item_value.icons),
        subgroup = "frozen-" .. sanitized_subgroup,
        order = "frozen-" .. sanitized_order,
        stack_size = item_value.stack_size,
        localised_name = { "item-name.frozen", { "item-name." .. item_key } },
    }

    if item_value.icon ~= nil then
        frozen_item.icons = { { icon = item_value.icon, icon_size = item_value.icon_size }, { icon = "__core__/graphics/icons/alerts/frozen-icon.png", icon_size = 64, scale = 0.3, shift = { 13, -13 } } }
    elseif frozen_item.icons ~= nil then
        frozen_item.icons[#frozen_item.icons + 1] = { icon = "__core__/graphics/icons/alerts/frozen-icon.png", icon_size = 64, scale = 0.3, shift = { 13, -13 } }
    end

    -- log("Created frozen version of item: " .. serpent.line(item_value) .. " -> " .. serpent.line(frozen_item))

    local frozen_recipe = {
        type = "recipe",
        name = "frozen-" .. item_key,
        category = "ice-machine",
        subgroup = "frozen-" .. sanitized_subgroup,
        order = "frozen-" .. sanitized_order,
        energy_required = 1,
        icons = frozen_item.icons,
        enabled = false,
        ingredients = {
            { type = "item", name = item_key,  amount = 1 },
            { type = "item", name = "ice-box", amount = 1 }
        },
        results = {
            { type = "item", name = "frozen-" .. item_key, amount = 1 }
        },
        allow_productivity = false,
        allow_quality = false,
        auto_recycle = false,
        localised_name = { "item-name.frozen", item_or_entity_localized_name_expression(item_key) },
    }

    local thawed_recipe = {
        type = "recipe",
        name = "thaw-" .. item_key,
        category = "crafting",
        subgroup = "thawed-" .. sanitized_subgroup,
        order = "thawed-" .. sanitized_order,
        energy_required = 1,
        icons = table.deepcopy(frozen_item.icons),
        enabled = false,
        ingredients = {
            { type = "item", name = "frozen-" .. item_key, amount = 1 }
        },
        results = {
            { type = "item", name = item_key,  amount = 1, percent_spoiled = 0.5, probability = 0.9 },
            { type = "item", name = "ice-box", amount = 1, probability = 0.5 },
        },
        allow_productivity = false,
        allow_quality = false,
        auto_recycle = false,
        main_product = item_key,
        localised_name = { "item-name.thawed", item_or_entity_localized_name_expression(item_key) },
    }
    thawed_recipe.icons[#thawed_recipe.icons].icon = "__base__/graphics/icons/signal/signal-fire.png"
    thawed_recipe.icons[#thawed_recipe.icons].icon_size = 64
    thawed_recipe.icons[#thawed_recipe.icons].tint = { r = 255, g = 0, b = 0 }

    data.raw["technology"]["ice-packaging"].effects[#data.raw["technology"]["ice-packaging"].effects + 1] = {
        type = "unlock-recipe",
        recipe = "frozen-" .. item_key
    }

    data.raw["technology"]["ice-packaging"].effects[#data.raw["technology"]["ice-packaging"].effects + 1] = {
        type = "unlock-recipe",
        recipe = "thaw-" .. item_key
    }

    data:extend({ frozen_item, frozen_recipe, thawed_recipe })
end

local function get_items_to_add_packed_and_unpacked_recipes(type)
    local items_to_add = {}
    for item_key, item_value in pairs(data.raw[type]) do
        if (item_value.stack_size == nil or item_value.stack_size > 1)
            and (item_value.weight == nil or item_value.weight <= 1000000)
            and (item_value.hidden == nil or item_value.hidden == false)
            and (item_value.hidden_in_factoriopedia == nil or item_value.hidden_in_factoriopedia == false)
            and item_value.subgroup ~= "other"
            and item_value.name ~= "packaging" then
            items_to_add[item_key] = item_value
        end
    end
    return items_to_add
end

local function add_packed_and_unpacked_recipes(item_key, item_value)
    local sanitized_subgroup = item_value.subgroup or "unknown"
    local sanitized_subgroup_order = data.raw["item-subgroup"][sanitized_subgroup] and data.raw["item-subgroup"][sanitized_subgroup].order or "zzz"
    local sanitized_order = item_value.order or "zzz"

    if data.raw["item-subgroup"]["packaged-" .. sanitized_subgroup] == nil then
        data:extend({
            {
                type = "item-subgroup",
                name = "packaged-" .. sanitized_subgroup,
                group = "packaging-and-frozen",
                order = "c" .. sanitized_subgroup_order
            }
        })
    end

    if data.raw["item-subgroup"]["unpacked-" .. sanitized_subgroup] == nil then
        data:extend({
            {
                type = "item-subgroup",
                name = "unpacked-" .. sanitized_subgroup,
                group = "packaging-and-frozen",
                order = "d" .. sanitized_subgroup_order
            }
        })
    end

    local packed_stack_size = math.min(item_value.weight and (1000000 / item_value.weight) or item_value.stack_size, 65535)

    local packed_item = {
        type = "item",
        name = "packed-" .. item_key,
        icon = nil,
        icons = table.deepcopy(item_value.icons),
        subgroup = "packaged-" .. sanitized_subgroup,
        order = "packed-" .. sanitized_order,
        stack_size = 1,
        localised_name = { "item-name.packed", item_or_entity_localized_name_expression(item_key) },
        weight = 1000 * kg / 5
    }

    local box_icon_size = 64
    local base_item_scale = 0.375
    if item_value.icons ~= nil then
        packed_item.icons = {}
        table.insert(packed_item.icons,
            { icon = "__base__/graphics/icons/wooden-chest.png", icon_size = box_icon_size, tint = { r = 150, g = 255, b = 150 } })
        for _, icon in pairs(item_value.icons) do
            local copied_icon = table.deepcopy(icon)
            copied_icon.scale = box_icon_size / (copied_icon.icon_size or 64) * base_item_scale
            table.insert(packed_item.icons, copied_icon)
        end
    else
        packed_item.icons = { { icon = "__base__/graphics/icons/wooden-chest.png", icon_size = box_icon_size, tint = { r = 150, g = 255, b = 150 } },
            { icon = item_value.icon,                            icon_size = item_value.icon_size, scale = box_icon_size / (item_value.icon_size or 64) * base_item_scale } }
    end

    local packed_recipe = {
        type = "recipe",
        name = "packed-" .. item_key,
        category = "packaging",
        subgroup = "packaged-" .. sanitized_subgroup,
        order = "a-packed-" .. sanitized_order,
        energy_required = 10,
        icons = packed_item.icons,
        enabled = false,
        ingredients = {
            { type = "item", name = item_key,    amount = packed_stack_size },
            { type = "item", name = "packaging", amount = packed_stack_size }
        },
        results = {
            { type = "item", name = "packed-" .. item_key, amount = 1 }
        },
        localised_name = { "item-name.packed", { "?", { "item-name." .. item_key }, { "item-description." .. item_key } } },
        allow_productivity = false,
        allow_quality = false,
        auto_recycle = false,
    }

    local unpacked_recipe = {
        type = "recipe",
        name = "unpack-" .. item_key,
        category = "packaging",
        subgroup = "unpacked-" .. sanitized_subgroup,
        order = "b-unpack-" .. sanitized_order,
        energy_required = 10,
        icons = packed_item.icons,
        enabled = false,
        ingredients = {
            { type = "item", name = "packed-" .. item_key, amount = 1 }
        },
        results = {
            { type = "item", name = item_key, amount = item_value.stack_size }
        },
        localised_name = { "item-name.unpacked", { "item-name." .. item_key } },
        allow_productivity = false,
        allow_quality = false,
        auto_recycle = false,
    }

    data.raw["technology"]["packaging"].effects[#data.raw["technology"]["packaging"].effects + 1] = {
        type = "unlock-recipe",
        recipe = "packed-" .. item_key
    }

    data.raw["technology"]["packaging"].effects[#data.raw["technology"]["packaging"].effects + 1] = {
        type = "unlock-recipe",
        recipe = "unpack-" .. item_key
    }

    data:extend({ packed_item, packed_recipe, unpacked_recipe })
end

local types = { "item", "capsule" }
for _, type in pairs(types) do
    local items_to_add_frozen_and_thaw_recipes = get_items_to_add_frozen_and_thaw_recipes(type)
    for item_key, item_value in pairs(items_to_add_frozen_and_thaw_recipes) do
        add_frozen_and_thaw_recipes(item_key, item_value)
    end
    local items_to_add_packed_and_unpacked_recipes = get_items_to_add_packed_and_unpacked_recipes(type)
    for item_key, item_value in pairs(items_to_add_packed_and_unpacked_recipes) do
        add_packed_and_unpacked_recipes(item_key, item_value)
    end
end

local starmap_icon_util = require("__subterranio-base__.utilities.starmap-icon")
local starmap_icon_position = starmap_icon_util.position_starmap_icon(data.raw.planet.gleba, 0.7)
data.raw.planet.gleban_biospheres.distance = starmap_icon_position.starmap_icon_distance
data.raw.planet.gleban_biospheres.orientation = starmap_icon_position.starmap_icon_orientation
