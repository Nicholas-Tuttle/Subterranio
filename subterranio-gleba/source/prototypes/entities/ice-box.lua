local graphics_tinter = require("__subterranio-base__/utilities/graphics-tinter")

local item = {
    type = "item",
    name = "ice-box",
    icon = nil,
    icons = { { icon = "__base__/graphics/icons/steel-chest.png", icon_size = 64, tint = { r = 200, g = 200, b = 255 } } },
    stack_size = data.raw["item"]["steel-chest"].stack_size,
    subgroup = "packaging-and-frozen",
    order = "ice-box",
    weight = 10*kg
}

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
ice_machine_entity = graphics_tinter.tint(ice_machine_entity, { r = 50, g = 150, b = 255 })
ice_machine_entity.minable.result = "ice-machine"

local ice_machine_item = table.deepcopy(data.raw["item"]["assembling-machine-3"])
ice_machine_item.name = "ice-machine"
ice_machine_item = graphics_tinter.tint(ice_machine_item, { r = 50, g = 150, b = 255 })
ice_machine_item.place_result = "ice-machine"

local ice_machine_recipe = table.deepcopy(data.raw["recipe"]["assembling-machine-3"])
ice_machine_recipe.enabled = false
ice_machine_recipe.name = "ice-machine"
ice_machine_recipe.ingredients = {
    { type = "item", name = "assembling-machine-3", amount = 1 },
    { type = "item", name = "ice", amount = 100 },
}
ice_machine_recipe.results = {
    { type = "item", name = "ice-machine", amount = 1 }
}

local ice_packaging_tech = {
    type = "technology",
    name = "ice-packaging",
    icon_size = 64,
    icon = "__space-age__/graphics/icons/ice.png",
    effects = {
        {
            type = "unlock-recipe",
            recipe = "ice-machine"
        },
        {
            type = "unlock-recipe",
            recipe = "ice-box"
        }
    },
    prerequisites = { "cold-resistant-bacteria", "heat-resistant-bacteria", "biological-science-pack" },
    unit = {
        count = 3000,
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
    ice_machine_recipe,
    ice_packaging_tech,
    recipe_category
})