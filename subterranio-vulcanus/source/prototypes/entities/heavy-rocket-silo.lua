local graphics_tinter = require("__subterranio-base__.utilities.graphics-tinter")
local constants = require("scripts.constants")

local silo_entity = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
silo_entity.name = "heavy-rocket-silo"
silo_entity.lift_weight = 5000 * kg
silo_entity.fixed_recipe = "heavy-rocket-part"
silo_entity.order = "ea[heavy-rocket-silo]"
silo_entity.minable.result = "heavy-rocket-silo"
silo_entity.module_slots = 8
silo_entity.icons = { { icon = silo_entity.icon, tint = constants.gleban_biospheres_tint } }
silo_entity.icon = nil
silo_entity.description = { "entity-description.rocket-silo" }
silo_entity = graphics_tinter.tint(silo_entity, constants.vulcanus_lava_tubes_tint)

local silo_item = table.deepcopy(data.raw["item"]["rocket-silo"])
silo_item.name = "heavy-rocket-silo"
silo_item.order = "ea[heavy-rocket-silo]"
silo_item.place_result = "heavy-rocket-silo"
silo_item.icons = { { icon = silo_item.icon, tint = constants.gleban_biospheres_tint } }
silo_item.icon = nil
silo_item = graphics_tinter.tint(silo_item, constants.vulcanus_lava_tubes_tint)

local silo_recipe = {
    name = "heavy-rocket-silo",
    type = "recipe",
    order = "ea[heavy-rocket-silo]",
    energy_required = 60,
    enabled = false,
    categories = { "crafting-with-fluid" },
    ingredients = {
        { type = "item",  name = "steel-plate",          amount = 2000 },
        { type = "item",  name = "processing-unit",      amount = 400 },
        { type = "item",  name = "electric-engine-unit", amount = 200 },
        { type = "item",  name = "pipe",                 amount = 200 },
        { type = "item",  name = "refined-concrete",     amount = 200 },
        { type = "item",  name = "duratitanite-plate",   amount = 200 },
        { type = "fluid", name = "lubricant",            amount = 500 },
    },
    results = {
        { type = "item", name = "heavy-rocket-silo", amount = 1 },
    },
}
silo_recipe = graphics_tinter.tint(silo_recipe, constants.vulcanus_lava_tubes_tint)

local part_item = table.deepcopy(data.raw["item"]["rocket-part"])
part_item.name = "heavy-rocket-part"
part_item.order = "eb[heavy-rocket-part]"
part_item.icons = { { icon = part_item.icon, tint = constants.gleban_biospheres_tint } }
part_item.icon = nil
part_item = graphics_tinter.tint(part_item, constants.vulcanus_lava_tubes_tint)

local part_recipe = {
    name = "heavy-rocket-part",
    type = "recipe",
    order = "eb[heavy-rocket-part]",
    energy_required = 3,
    enabled = false,
    categories = { "rocket-building" },
    allow_productivity = true,
    ingredients = {
        { type = "item", name = "low-density-structure", amount = 1 },
        { type = "item", name = "processing-unit",       amount = 1 },
        { type = "item", name = "rocket-fuel",           amount = 1 },
        { type = "item", name = "aeroluminite-plate",    amount = 1 },
        { type = "item", name = "calcite",               amount = 1 },
        -- { type = "fluid", name = "thruster-fuel",         amount = 50 },
        -- { type = "fluid", name = "thruster-oxidizer",     amount = 50 },
    },
    results = {
        { type = "item", name = "heavy-rocket-part", amount = 1 },
    },
}
part_recipe = graphics_tinter.tint(part_recipe, constants.vulcanus_lava_tubes_tint)

local tech = {
    type = "technology",
    name = "heavy-rocket-silo",
    icons = { { icon = "__base__/graphics/technology/rocket-silo.png", icon_size = 256, tint = constants.vulcanus_lava_tubes_tint } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "heavy-rocket-silo"
        },
        {
            type = "unlock-recipe",
            recipe = "heavy-rocket-part"
        },
    },
    prerequisites = { "duratitanite-cutting", "aeroluminite-cutting" },
    unit =
    {
        count = 2000,
        ingredients =
        {
            { "automation-science-pack",  1 },
            { "logistic-science-pack",    1 },
            { "chemical-science-pack",    1 },
            { "production-science-pack",  1 },
            { "utility-science-pack",     1 },
            { "space-science-pack",       1 },
            { "metallurgic-science-pack", 1 },
            { "propulsion-science-pack",  1 },
        },
        time = 60
    }
}
tech = graphics_tinter.tint(tech, constants.vulcanus_lava_tubes_tint)

data:extend {
    silo_entity,
    silo_item,
    silo_recipe,
    part_item,
    part_recipe,
    tech
}
