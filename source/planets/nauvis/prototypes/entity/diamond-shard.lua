local item_sounds = require("__base__.prototypes.item_sounds")

local item = {
    type = "item",
    name = "diamond-shard",
    icon = subterrain.diamond_shard_image_path,
    icon_size = subterrain.diamond_shard_image_size,
    subgroup = "raw-resource",
    order = "h[diamond-shard]",
    inventory_move_sound = item_sounds.resource_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.resource_inventory_move,
    stack_size = 100,
    weight = 5*kg
}

local recipe = {
    type = "recipe",
    name = "diamond-shard",
    category = "smelting",
    energy_required = 5,
    ingredients = {{type = "item", name = "diamond-ore", amount = 1}},
    results = {{type="item", name="diamond-shard", amount=1}},
    allow_productivity = true
}

local tech = {
    type = "technology",
    name = "diamond-axe",
    icon = "__base__/graphics/technology/steel-axe.png",
    icon_size = 256,
    effects =
    {
      {
        type = "character-mining-speed",
        modifier = 2
      }
    },
    prerequisites = {"diamonds"},
    research_trigger =
    {
      type = "craft-item",
      item = "diamond-shard",
      count = 50
    }
}

data:extend{item, recipe, tech}