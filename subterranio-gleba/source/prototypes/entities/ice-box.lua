local graphics_tinter = require("__subterranio-base__/utilities/graphics-tinter")

local item = table.deepcopy(data.raw["item"]["steel-chest"])
item.name = "ice-box"
item = graphics_tinter.tint(item, { r = 30, g = 30, b = 255 })

local recipe = table.deepcopy(data.raw["recipe"]["steel-chest"])
recipe.name = "ice-box"
recipe.ingredients = {
    { type = "item", name = "steel-chest", amount = 1 },
    { type = "item", name = "ice", amount = 10 },
    { type = "item", name = "heat-resistant-bacteria", amount = 3 },
    { type = "item", name = "cold-resistant-bacteria", amount = 3 },
}
recipe.results = {
    { type = "item", name = "ice-box", amount = 1 }
}

local ice_machine_entity = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"])
ice_machine_entity.name = "ice-machine"
ice_machine_entity.crafting_categories = { "ice-machine" }
ice_machine_entity.crafting_speed = 10
ice_machine_entity = graphics_tinter.tint(ice_machine_entity, { r = 50, g = 50, b = 255 })

local ice_machine_item = table.deepcopy(data.raw["item"]["assembling-machine-3"])
ice_machine_item.name = "ice-machine"
ice_machine_item = graphics_tinter.tint(ice_machine_item, { r = 50, g = 50, b = 255 })
ice_machine_item.place_result = "ice-machine"

local ice_packaging_tech = {
    type = "technology",
    name = "ice-packaging",
    icon_size = 128,
    icon = "__subterranio-gleba__/graphics/technology/ice-packaging.png",
    effects = {
        {
            type = "unlock-recipe",
            recipe = "ice-box"
        },
        {
            type = "unlock-recipe",
            recipe = "ice-machine"
        }
    },
    prerequisites = { "cold-resistant-bacteria", "heat-resistant-bacteria" },
    unit = {
        count = 1000,
        ingredients = {
          { "automation-science-pack", 1 },
          { "logistic-science-pack", 1 },
          { "chemical-science-pack", 1 },
          { "space-science-pack", 1 },
          { "biological-science-pack", 1 }
        },
        time = 60
    }
}

local recipe_category = {
  type = "recipe-category",
  name = "ice-machine"
}

data:extend({
    item,
    recipe,
    ice_machine_entity,
    ice_machine_item,
    ice_packaging_tech,
    recipe_category
})