local graphics_tinter = require("__subterranio-base__/utilities/graphics-tinter")
local surface_tiles_definitions = require("prototypes.surfaces.surface-tiles-definitions")

local plant = table.deepcopy(data.raw["simple-entity"]["iron-stromatolite"])
plant.type = "plant"
plant.name = "heat-resistant-bacteria"
plant.subgroup = "trees"
plant.flags = { "placeable-neutral", "placeable-off-grid", "breaths-air" }
plant.collision_mask = nil
plant.growth_ticks = 5 * 60 * 60 -- 5 minutes
plant.minable.results = {
    {
        type = "item",
        name = "heat-resistant-bacteria",
        amount = 20
    }
}
plant.order = "a[tree]-c[gleban_biospheres]-a[seedable]-b[heat-resistant-bacteria]"
plant.emissions_per_second = nil
plant.harvest_emissions = nil
plant.autoplace = {
    probability_expression = "var('gleban_subterranean_heat-resistant-bacteria-red_noise_expression')"
}
-- Keep this in sync with the tile definitions in the surface-tiles-definitions.lua file
plant.autoplace.tile_restriction = {
    "overgrowth-hot-soil",
    "gleban-subterranean-mycellium-hot",
    "gleban-subterranean-" .. surface_tiles_definitions.biomes.red.tiles[1] .. "-red",
    "gleban-subterranean-" .. surface_tiles_definitions.biomes.red.tiles[2] .. "-red",
}
plant.colors = {
    { r = 255, g = 255, b = 255 },
}
plant.agricultural_tower_tint = {
    primary = { r = 195, g = 130, b = 122 },
    secondary = { r = 107, g = 53, b = 46 }
}
plant.map_color = { r = 222, g = 13, b = 34 }
plant = graphics_tinter.tint(plant, { r = 255, g = 150, b = 120 })

local bacteria_item = table.deepcopy(data.raw["item"]["wood"])
bacteria_item.name = "heat-resistant-bacteria"
bacteria_item.icon = nil
bacteria_item.icons = { { icon = "__space-age__/graphics/icons/copper-bacteria.png", tint = { r = 255, g = 150, b = 120 } } }
bacteria_item.pictures =
{
    { size = 64, filename = "__space-age__/graphics/icons/copper-bacteria.png",   scale = 0.5, mipmap_count = 4 },
    { size = 64, filename = "__space-age__/graphics/icons/copper-bacteria-1.png", scale = 0.5, mipmap_count = 4 },
    { size = 64, filename = "__space-age__/graphics/icons/copper-bacteria-2.png", scale = 0.5, mipmap_count = 4 },
    { size = 64, filename = "__space-age__/graphics/icons/copper-bacteria-3.png", scale = 0.5, mipmap_count = 4 },
}
bacteria_item.subgroup = "subterranio-gleba-raw-materials"
bacteria_item.order = "a[gleban_biospheres]-d"
bacteria_item.spoil_result = "spoilage"
bacteria_item.spoil_ticks = 5 * 60 * 60 -- 30 minutes
bacteria_item.plant_result = nil
bacteria_item.place_result = nil
bacteria_item = graphics_tinter.tint(bacteria_item, { r = 255, g = 150, b = 120 })

local newborn_bacterium_item = table.deepcopy(data.raw["item"]["wood"])
newborn_bacterium_item.name = "heat-resistant-newborn-bacterium"
newborn_bacterium_item.icon = nil
newborn_bacterium_item.icons = { { icon = "__space-age__/graphics/icons/copper-bacteria.png", tint = { r = 200, g = 100, b = 80 } } }
newborn_bacterium_item.pictures =
{
    { size = 64, filename = "__space-age__/graphics/icons/copper-bacteria.png",   scale = 0.5, mipmap_count = 4 },
    { size = 64, filename = "__space-age__/graphics/icons/copper-bacteria-1.png", scale = 0.5, mipmap_count = 4 },
    { size = 64, filename = "__space-age__/graphics/icons/copper-bacteria-2.png", scale = 0.5, mipmap_count = 4 },
    { size = 64, filename = "__space-age__/graphics/icons/copper-bacteria-3.png", scale = 0.5, mipmap_count = 4 },
}
newborn_bacterium_item.subgroup = "subterranio-gleba-raw-materials"
newborn_bacterium_item.order = "a[gleban_biospheres]-e"
newborn_bacterium_item.spoil_result = "heat-resistant-bacteria"
newborn_bacterium_item.spoil_ticks = 6 * 60 * 60 -- 6 minutes
newborn_bacterium_item.plant_result = "heat-resistant-bacteria"
newborn_bacterium_item.place_result = "heat-resistant-bacteria"
newborn_bacterium_item = graphics_tinter.tint(newborn_bacterium_item, { r = 255, g = 150, b = 120 })

local heat_resistant_bacteria_cultivation_recipe = {
    type = "recipe",
    name = "heat-resistant-bacteria-cultivation",
    icons = { { icon = "__space-age__/graphics/icons/copper-bacteria-cultivation.png", tint = { r = 255, g = 150, b = 120 } } },
    icon = nil,
    categories = { "organic" },
    subgroup = "agriculture-processes",
    enabled = false,
    energy_required = 30,
    ingredients =
    {
        { type = "item",  name = "heat-resistant-bacteria", amount = 10 },
        { type = "item",  name = "bioflux",                 amount = 1 },
        { type = "fluid", name = "water",                   amount = 100 },
    },
    results =
    {
        { type = "item", name = "heat-resistant-bacteria",          amount = 20, reset_freshness_on_craft = true },
        { type = "item", name = "heat-resistant-newborn-bacterium", amount = 1,  reset_freshness_on_craft = true }
    },
    crafting_machine_tint =
    {
        primary = { r = 1.000, g = 0.000, b = 0.457, a = 1.000 },
        secondary = { r = 1.000, g = 0.000, b = 0.196, a = 1.000 },
    },
    show_amount_in_title = false,
}

local heat_resistant_bacteria_tech = {
    type = "technology",
    name = "heat-resistant-bacteria",
    icons = { { icon = "__space-age__/graphics/icons/copper-bacteria.png", tint = { r = 255, g = 150, b = 120 } } },
    icon = nil,
    prerequisites = { "water-resistant-tunnelling-drill-equipment" },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "heat-resistant-bacteria-cultivation"
        }
    },
    research_trigger =
    {
        type = "mine-entity",
        entities = { "heat-resistant-bacteria" }
    },
    order = "a[tree]-c[gleban_biospheres]-a[seedable]-b[heat-resistant-bacteria]"
}

data:extend({
    plant,
    bacteria_item,
    newborn_bacterium_item,
    heat_resistant_bacteria_cultivation_recipe,
    heat_resistant_bacteria_tech
})
