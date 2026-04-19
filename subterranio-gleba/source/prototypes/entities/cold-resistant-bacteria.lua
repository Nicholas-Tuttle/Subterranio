local graphics_tinter = require("__subterranio-base__/utilities/graphics-tinter")
local surface_tiles_definitions = require("prototypes.surfaces.surface-tiles-definitions")

local plant = table.deepcopy(data.raw["simple-entity"]["iron-stromatolite"])
plant.type = "plant"
plant.name = "cold-resistant-bacteria"
plant.subgroup = "trees"
plant.flags = { "placeable-neutral", "placeable-off-grid", "breaths-air" }
plant.collision_mask = nil
plant.growth_ticks = 5 * 60 * 60 -- 5 minutes
plant.minable.results = {
    {
        type = "item",
        name = "cold-resistant-bacteria",
        amount = 20
    }
}
plant.order = "a[tree]-c[gleban_biospheres]-a[seedable]-b[cold-resistant-bacteria]"
plant.emissions_per_second = nil
plant.harvest_emissions = nil
plant.autoplace = {
    probability_expression = "var('gleban_subterranean_cold-resistant-bacteria-blue_noise_expression')"
}
local tiles = {}
for _, value in pairs(surface_tiles_definitions.biomes["blue"]["tiles"]) do
    tiles[#tiles + 1] = "gleban-subterranean-" .. value .. "-blue"
end
plant.autoplace.tile_restriction = tiles
plant.colors = {
    { r = 255, g = 255, b = 255 },
    -- TODO
}
plant.agricultural_tower_tint = {
    primary = { r = 130, g = 195, b = 122 },
    secondary = { r = 53, g = 107, b = 46 }
}
plant.map_color = { r = 13, g = 222, b = 34 }
plant = graphics_tinter.tint(plant, { r = 120, g = 150, b = 255 })

local bacteria_item = table.deepcopy(data.raw["item"]["wood"])
bacteria_item.name = "cold-resistant-bacteria"
bacteria_item.icons = { { icon = "__space-age__/graphics/icons/copper-bacteria.png", tint = { r = 120, g = 150, b = 255 } } }
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
bacteria_item.spoil_ticks = 30 * 60 * 60 -- 30 minutes
bacteria_item.plant_result = "cold-resistant-bacteria"
bacteria_item.place_result = "cold-resistant-bacteria"
bacteria_item = graphics_tinter.tint(bacteria_item, { r = 120, g = 150, b = 255 })

local cold_resistant_bacteria_cultivation_recipe = {
    type = "recipe",
    name = "cold-resistant-bacteria-cultivation",
    icons = { { icon = "__space-age__/graphics/icons/copper-bacteria-cultivation.png", tint = { r = 120, g = 150, b = 255 } } },
    icon = nil,
    category = "organic",
    subgroup = "agriculture-processes",
    enabled = false,
    energy_required = 30,
    ingredients =
    {
        { type = "item",  name = "cold-resistant-bacteria", amount = 10 },
        { type = "fluid", name = "water",                   amount = 100 }
    },
    results =
    {
        { type = "item", name = "cold-resistant-bacteria", amount = 20 }
    },
    crafting_machine_tint =
    {
        primary = { r = 0.000, g = 0.457, b = 1.000, a = 1.000 },
        secondary = { r = 0.000, g = 0.196, b = 1.000, a = 1.000 },
    },
    show_amount_in_title = false,
    reset_freshness_on_craft = true,
}

local cold_resistant_bacteria_tech = {
    type = "technology",
    name = "cold-resistant-bacteria",
    icons = { { icon = "__space-age__/graphics/icons/copper-bacteria.png", tint = { r = 120, g = 150, b = 255 } } },
    icon = nil,
    prerequisites = { "water-resistant-tunnelling-drill-equipment" },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "cold-resistant-bacteria-cultivation"
        }
    },
    research_trigger =
    {
        type = "mine-entity",
        entity = "cold-resistant-bacteria"
    },
    order = "a[tree]-c[gleban_biospheres]-a[seedable]-b[cold-resistant-bacteria]"
}

data:extend({ plant, bacteria_item, cold_resistant_bacteria_cultivation_recipe, cold_resistant_bacteria_tech })
