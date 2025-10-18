local base_tile_sounds = require("__base__.prototypes.tile.tile-sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")

function make_scrap(name, tint, recipe_results, prerequisites, research_trigger)
  local resource = {
    name = name .. "-scrap",
    icons = { { icon = "__space-age__/graphics/icons/scrap.png", tint = tint } },
    type = "resource",
    flags = { "placeable-neutral" },
    order = "a-b-c",
    map_color = tint,
    walking_sound = base_tile_sounds.walking.ore,
    resource_patch_search_radius = 12,
    mining_visualisation_tint = { r = 0.5, g = 0.5, b = 0.5, a = 1.000 },
    factoriopedia_simulation = simulations.factoriopedia_scrap,
    collision_box = { { -0.1, -0.1 }, { 0.1, 0.1 } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    stage_counts = { 15000, 9500, 5500, 2900, 1300, 400, 150, 80 },
    stages =
    {
      sheet =
      {
        filename = "__space-age__/graphics/entity/scrap/scrap.png",
        priority = "extra-high",
        size = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5,
        tint = tint
      }
    },
    minable = {
      mining_particle = "scrap-particle",
      mining_time = 1.0,
      result = name .. "-scrap"
    },
  }

  local recipe = {
    type = "recipe",
    name = name .. "-scrap-recycling",
    icons = {
      {
        icon = "__quality__/graphics/icons/recycling.png"
      },
      {
        icon = "__space-age__/graphics/icons/scrap.png",
        scale = 0.4,
        tint = tint
      },
      {
        icon = "__quality__/graphics/icons/recycling-top.png"
      }
    },
    category = "recycling-or-hand-crafting",
    subgroup = "fulgora-processes",
    order = "a[trash]-a[trash-recycling]-" .. name .. "-scrap",
    enabled = false,
    auto_recycle = false,
    energy_required = 0.2,
    ingredients = { { type = "item", name = name .. "-scrap", amount = 1 } },
    results = recipe_results
  }

  local item = {
    type = "item",
    name = name .. "-scrap",
    icons = { { icon = "__space-age__/graphics/icons/scrap.png", tint = tint } },
    pictures =
    {
      { size = 64, filename = "__space-age__/graphics/icons/scrap.png",   scale = 0.5, mipmap_count = 4, tint = tint },
      { size = 64, filename = "__space-age__/graphics/icons/scrap-1.png", scale = 0.5, mipmap_count = 4, tint = tint },
      { size = 64, filename = "__space-age__/graphics/icons/scrap-2.png", scale = 0.5, mipmap_count = 4, tint = tint },
      { size = 64, filename = "__space-age__/graphics/icons/scrap-3.png", scale = 0.5, mipmap_count = 4, tint = tint },
      { size = 64, filename = "__space-age__/graphics/icons/scrap-4.png", scale = 0.5, mipmap_count = 4, tint = tint },
      { size = 64, filename = "__space-age__/graphics/icons/scrap-5.png", scale = 0.5, mipmap_count = 4, tint = tint }
    },
    subgroup = "fulgora-processes",
    order = "a[scrap]-a[scrap]-" .. name,
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 50,
    default_import_location = "fulgora",
    weight = 2 * kg
  }

  local tech = {
    type = "technology",
    name = name .. "-scrap-recycling",
    icons = { { icon = "__space-age__/graphics/icons/scrap.png", tint = tint } },
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = name .. "-scrap-recycling"
      }
    },
    prerequisites = prerequisites,
    research_trigger = research_trigger
  }

  data:extend { resource, recipe, item, tech }
end

make_scrap("advanced", { 0.5, 1.0, 0.5 }, {
    { type = "item", name = "scrap",            amount = 1, probability = 0.1,  show_details_in_recipe_tooltip = false },
    { type = "item", name = "neodymium-powder", amount = 1, probability = 0.05, show_details_in_recipe_tooltip = false },
    { type = "item", name = "sulfur",           amount = 1, probability = 0.05, show_details_in_recipe_tooltip = false },
    { type = "item", name = "calcite",          amount = 1, probability = 0.05, show_details_in_recipe_tooltip = false },
    { type = "item", name = "holmium-plate",    amount = 1, probability = 0.05, show_details_in_recipe_tooltip = false },
    -- TODO: more
  },
  {
    "mixed-type-1-scrap-recycling",
    "mixed-type-2-scrap-recycling"
  },
  {
    type = "craft-item",
    item = "advanced-scrap",
    count = 1
  })

make_scrap("type-1", { 0.25, 0.25, 1.0 }, {
    { type = "item", name = "scrap",          amount = 1, probability = 0.3,  show_details_in_recipe_tooltip = false },
    { type = "item", name = "cobalt-ore",     amount = 1, probability = 0.05, show_details_in_recipe_tooltip = false },
    { type = "item", name = "superconductor", amount = 1, probability = 0.05, show_details_in_recipe_tooltip = false },
    -- TODO: more
  },
  {
    "mixed-type-1-scrap-recycling"
  },
  {
    type = "craft-item",
    item = "type-1-scrap",
    count = 1
  })

make_scrap("type-2", { 1.0, 0.25, 0.25 }, {
    { type = "item", name = "scrap",          amount = 1, probability = 0.3,  show_details_in_recipe_tooltip = false },
    { type = "item", name = "boron-chunk",    amount = 1, probability = 0.05, show_details_in_recipe_tooltip = false },
    { type = "item", name = "supercapacitor", amount = 1, probability = 0.05, show_details_in_recipe_tooltip = false },
    -- TODO: more
  },
  {
    "mixed-type-2-scrap-recycling"
  },
  {
    type = "craft-item",
    item = "type-2-scrap",
    count = 1
  })

make_scrap("mixed-type-1", { 0.5, 0.5, 1.0 }, {
    { type = "item", name = "advanced-scrap", amount = 1, probability = 0.80, show_details_in_recipe_tooltip = false },
    { type = "item", name = "type-1-scrap",   amount = 1, probability = 0.20, show_details_in_recipe_tooltip = false },
  },
  {
    "electrostatic-tunnelling-drill-equipment"
  },
  {
    type = "mine-entity",
    entity = "mixed-type-1-scrap"
  })

make_scrap("mixed-type-2", { 1.0, 0.5, 0.5 }, {
    { type = "item", name = "advanced-scrap", amount = 1, probability = 0.80, show_details_in_recipe_tooltip = false },
    { type = "item", name = "type-2-scrap",   amount = 1, probability = 0.20, show_details_in_recipe_tooltip = false },
  },
  {
    "electrostatic-tunnelling-drill-equipment"
  },
  {
    type = "mine-entity",
    entity = "mixed-type-2-scrap"
  })
