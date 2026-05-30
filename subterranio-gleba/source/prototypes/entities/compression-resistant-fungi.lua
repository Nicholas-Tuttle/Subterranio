local graphics_tinter = require("__subterranio-base__/utilities/graphics-tinter")
local surface_tiles_definitions = require("prototypes.surfaces.surface-tiles-definitions")

local plant = table.deepcopy(data.raw["plant"]["jellystem"])
plant.name = "compression-resistant-fungi"
plant.minable.results = {
    {
        type = "item",
        name = "compression-resistant-fungi",
        amount = 20
    },
    {
        type = "item",
        name = "compression-resistant-fungi-spores",
        amount = 3,
    }
}
plant.collision_mask = {
    layers = {
        item = true,
        meltable = true,
        object = true,
        player = true,
        water_tile = true,
        is_object = true,
        -- is_lower_object = true
    }
}
plant.order = "a[tree]-c[gleban_biospheres]-a[seedable]-a[compression-resistant-fungi]"
plant.emissions_per_second = nil
plant.harvest_emissions = nil
plant.autoplace = {
    probability_expression = "var('gleban_subterranean_compression-resistant-fungi-red_noise_expression')"
}
local tiles = {
    "overgrowth-hot-soil"
}
for _, value in pairs(surface_tiles_definitions.biomes["red"]["tiles"]) do
    tiles[#tiles + 1] = "gleban-subterranean-" .. value .. "-red"
end
plant.autoplace.tile_restriction = tiles
plant.colors = {
    { r = 255, g = 255, b = 255 },
}
plant.agricultural_tower_tint = {
    primary = { r = 195, g = 130, b = 122 },
    secondary = { r = 107, g = 53, b = 46 }
}
plant.map_color = { r = 222, g = 13, b = 34 }
plant = graphics_tinter.tint(plant, { r = 255, g = 150, b = 120 })
-- Add some glow to all the "leaves"
for _, variation in ipairs(plant.variations) do
    if variation.leaves.layers == nil then
        local glow = table.deepcopy(variation.leaves)
        glow.draw_as_glow = true
        variation.leaves = {
            layers = {
                variation.leaves,
                glow
            }
        }
    end
end
plant.stateless_visualisation_variations = {}

local fungi_item = table.deepcopy(data.raw["item"]["wood"])
fungi_item.name = "compression-resistant-fungi"
fungi_item.icon = nil
fungi_item.icons = {
    {
        icon = "__space-age__/graphics/icons/nutrients.png",
        tint = { r = 120, g = 150, b = 255 }
    }
}
fungi_item.subgroup = "subterranio-gleba-raw-materials"
fungi_item.order = "a[gleban_biospheres]-a"

local spore_item = table.deepcopy(data.raw["item"]["wood"])
spore_item.name = "compression-resistant-fungi-spores"
spore_item.spoil_result = "compression-resistant-fungi-dry-spores"
spore_item.spoil_ticks = 6 * 60 * 60 -- 6 minutes
spore_item.icon = nil
spore_item.icons = {
    {
        icon = "__space-age__/graphics/icons/jellynut-seed-1.png",
        tint = { r = 120, g = 150, b = 255 }
    }
}
spore_item.subgroup = "subterranio-gleba-raw-materials"
spore_item.order = "a[gleban_biospheres]-b"
spore_item.plant_result = "compression-resistant-fungi"
spore_item.place_result = "compression-resistant-fungi"

local dry_spore_item = table.deepcopy(data.raw["item"]["wood"])
dry_spore_item.name = "compression-resistant-fungi-dry-spores"
dry_spore_item.icon = nil
dry_spore_item.icons = {
    {
        icon = "__space-age__/graphics/icons/jellynut-seed-1.png",
        tint = { r = 200, g = 220, b = 255 }
    }
}
dry_spore_item.subgroup = "subterranio-gleba-raw-materials"
dry_spore_item.order = "a[gleban_biospheres]-c"

local dry_spore_rehydration_recipe = {
    type = "recipe",
    name = "compression-resistant-fungi-dry-spores-rehydration",
    category = "crafting-with-fluid",
    energy_required = 1,
    ingredients = {
        { type = "item",  name = "compression-resistant-fungi-dry-spores", amount = 3 },
        { type = "fluid", name = "water",                                amount = 50 }
    },
    results = {
        { type = "item", name = "compression-resistant-fungi-spores", amount = 1, probability = 0.5 }
    },
    enabled = false,
}

local compression_resistant_fungi_tech = {
    type = "technology",
    name = "compression-resistant-fungi",
    icon = "__subterranio-gleba__/graphics/entity/mycellium.png",
    icon_size = 64,
    prerequisites = { "water-resistant-tunnelling-drill-equipment" },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "compression-resistant-fungi-dry-spores-rehydration"
        }
    },
    research_trigger =
    {
        type = "mine-entity",
        entity = "compression-resistant-fungi"
    },
    order = "a[tree]-c[gleban_biospheres]-a[seedable]-b[compression-resistant-fungi]"
}

data:extend {
    plant,
    fungi_item,
    spore_item,
    dry_spore_item,
    dry_spore_rehydration_recipe,
    compression_resistant_fungi_tech
}
