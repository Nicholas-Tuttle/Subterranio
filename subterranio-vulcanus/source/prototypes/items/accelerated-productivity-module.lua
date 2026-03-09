local constants = require("scripts.constants")
local item_sounds = require("__base__.prototypes.item_sounds")

local accelerated_productivity_module_1_item = {
    type = "module",
    name = "accelerated-productivity-module",
    icons = {{ icon = "__base__/graphics/icons/productivity-module.png", tint = constants.vulcanus_lava_tubes_tint }},
    subgroup = "module",
    category = "productivity",
    tier = 1,
    order = "d[productivity]-d[accelerated-productivity-module]",
    inventory_move_sound = item_sounds.module_inventory_move,
    pick_sound = item_sounds.module_inventory_pickup,
    drop_sound = item_sounds.module_inventory_move,
    stack_size = 50,
    weight = 20 * kg,
    effect =
    {
        productivity = 0.1,
        consumption = 1.0,
        pollution = 0.2,
        speed = -0.1
    }
}

local accelerated_productivity_module_1_recipe = {
    type = "recipe",
    name = "accelerated-productivity-module",
    enabled = false,
    energy_required = 15,
    ingredients =
    {
        { type = "item", name = "speed-module",        amount = 2 },
        { type = "item", name = "productivity-module", amount = 2 },
        { type = "item", name = "tungsten-carbide",    amount = 2 },
        { type = "item", name = "tungsten-plate",      amount = 2 },
    },
    results = { { type = "item", name = "accelerated-productivity-module", amount = 1 } },
}

local accelerated_productivity_module_1_tech = {
    type = "technology",
    name = "accelerated-productivity-module",
    icons = {{ icon = "__base__/graphics/icons/productivity-module.png", tint = constants.vulcanus_lava_tubes_tint }},
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "accelerated-productivity-module"
        }
    },
    prerequisites = { "productivity-module", "speed-module", "tungsten-steel", "propulsion-science-pack" },
    unit =
    {
        count = 1000,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "metallurgic-science-pack", 1 },
            { "propulsion-science-pack", 1 },
        },
        time = 30
    },
    order = "c-k-a"
}

local accelerated_productivity_module_2_item = {
    type = "module",
    name = "accelerated-productivity-module-2",
    icons = {{ icon = "__base__/graphics/icons/productivity-module-2.png", tint = constants.vulcanus_lava_tubes_tint }},
    subgroup = "module",
    category = "productivity",
    tier = 1,
    order = "d[productivity]-d[accelerated-productivity-module-2]",
    inventory_move_sound = item_sounds.module_inventory_move,
    pick_sound = item_sounds.module_inventory_pickup,
    drop_sound = item_sounds.module_inventory_move,
    stack_size = 50,
    weight = 20 * kg,
    effect =
    {
        productivity = 0.1,
        consumption = 1.5,
        pollution = 0.3,
        speed = -0.05
    }
}

local accelerated_productivity_module_2_recipe = {
    type = "recipe",
    name = "accelerated-productivity-module-2",
    enabled = false,
    energy_required = 15,
    ingredients =
    {
        { type = "item", name = "speed-module-2", amount = 2 },
        { type = "item", name = "accelerated-productivity-module", amount = 2 },
        { type = "item", name = "aluminum-ingot",        amount = 1 },
        { type = "item", name = "titanium-powder",        amount = 10 },
    },
    results = { { type = "item", name = "accelerated-productivity-module-2", amount = 1 } },
}

local accelerated_productivity_module_2_tech = {
    type = "technology",
    name = "accelerated-productivity-module-2",
    icons = {{ icon = "__base__/graphics/icons/productivity-module-2.png", tint = constants.vulcanus_lava_tubes_tint }},
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "accelerated-productivity-module-2"
        }
    },
    prerequisites = { "accelerated-productivity-module" },
    unit =
    {
        count = 2000,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "metallurgic-science-pack", 1 },
            { "propulsion-science-pack", 1 },
        },
        time = 30
    },
    order = "c-k-b"
}

local accelerated_productivity_module_3_item = {
    type = "module",
    name = "accelerated-productivity-module-3",
    icons = {{ icon = "__base__/graphics/icons/productivity-module-3.png", tint = constants.vulcanus_lava_tubes_tint }},
    subgroup = "module",
    category = "productivity",
    tier = 1,
    order = "d[productivity]-d[accelerated-productivity-module-3]",
    inventory_move_sound = item_sounds.module_inventory_move,
    pick_sound = item_sounds.module_inventory_pickup,
    drop_sound = item_sounds.module_inventory_move,
    stack_size = 50,
    weight = 20 * kg,
    effect =
    {
        productivity = 0.1,
        consumption = 2.0,
        pollution = 0.4,
    }
}

local accelerated_productivity_module_3_recipe = {
    type = "recipe",
    name = "accelerated-productivity-module-3",
    enabled = false,
    energy_required = 15,
    ingredients =
    {
        { type = "item", name = "speed-module-3", amount = 4 },
        { type = "item", name = "accelerated-productivity-module-2", amount = 4 },
        { type = "item", name = "aluminum-plate",      amount = 20 },
        { type = "item", name = "titanium-plate",     amount = 20 },
    },
    results = { { type = "item", name = "accelerated-productivity-module-3", amount = 1 } },
}

local accelerated_productivity_module_3_tech = {
    type = "technology",
    name = "accelerated-productivity-module-3",
    icons = {{ icon = "__base__/graphics/icons/productivity-module-3.png", tint = constants.vulcanus_lava_tubes_tint }},
    effects =
    {
        {
            type = "unlock-recipe",
            recipe = "accelerated-productivity-module-3"
        }
    },
    prerequisites = { "accelerated-productivity-module-2" },
    unit =
    {
        count = 4000,
        ingredients =
        {
            { "automation-science-pack", 1 },
            { "logistic-science-pack", 1 },
            { "chemical-science-pack", 1 },
            { "production-science-pack", 1 },
            { "utility-science-pack", 1 },
            { "space-science-pack", 1 },
            { "metallurgic-science-pack", 1 },
            { "propulsion-science-pack", 1 },
        },
        time = 30
    },
    order = "c-k-c"
}

data:extend({
    accelerated_productivity_module_1_item,
    accelerated_productivity_module_1_recipe,
    accelerated_productivity_module_1_tech,
    accelerated_productivity_module_2_item,
    accelerated_productivity_module_2_recipe,
    accelerated_productivity_module_2_tech,
    accelerated_productivity_module_3_item,
    accelerated_productivity_module_3_recipe,
    accelerated_productivity_module_3_tech,
})
