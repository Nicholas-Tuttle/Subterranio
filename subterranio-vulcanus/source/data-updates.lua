local graphics_updater = require("__subterranio-base__/utilities/graphics-updater")
local constants = require("scripts.constants")

table.insert(data.raw["lab"]["lab"].inputs, "propulsion-science-pack")
table.insert(data.raw["lab"]["biolab"].inputs, "propulsion-science-pack")

table.insert(data.raw["technology"]["planet-discovery-aquilo"].unit.ingredients, { "propulsion-science-pack", 1 })
table.insert(data.raw["technology"]["planet-discovery-aquilo"].prerequisites, "propulsion-science-pack")

if mods["subterranio-nauvis"] then
    table.insert(data.raw["recipe"]["band-saw"].ingredients, { type = "item", name = "diamond-shard", amount = 20 })
    table.insert(data.raw["recipe"]["duratitanite-plate"].ingredients, { type = "item", name = "diamond-shard", amount = 1 })
    table.insert(data.raw["recipe"]["aeroluminite-plate"].ingredients, { type = "item", name = "diamond-shard", amount = 1 })
    table.insert(data.raw["technology"]["aeroluminite-cutting"].unit.ingredients, { "subterranean-science-pack", 1 })
    table.insert(data.raw["technology"]["lava-filtration-plant"].unit.ingredients, { "subterranean-science-pack", 1 })
    table.insert(data.raw["technology"]["pulverizer"].unit.ingredients, { "subterranean-science-pack", 1 })
    table.insert(data.raw["technology"]["duratitanite-pulverization"].unit.ingredients, { "subterranean-science-pack", 1 })
    table.insert(data.raw["technology"]["propulsion-science-pack"].unit.ingredients, { "subterranean-science-pack", 1 })
    table.insert(data.raw["technology"]["duratitanite-cutting"].unit.ingredients, { "subterranean-science-pack", 1 })
    table.insert(data.raw["technology"]["band-saw"].unit.ingredients, { "subterranean-science-pack", 1 })
    table.insert(data.raw["technology"]["alternate-metallic-asteroid-processing"].unit.ingredients, { "subterranean-science-pack", 1 })
    table.insert(data.raw["technology"]["accelerated-productivity-module"].unit.ingredients, { "subterranean-science-pack", 1 })
    table.insert(data.raw["technology"]["accelerated-productivity-module-2"].unit.ingredients, { "subterranean-science-pack", 1 })
    table.insert(data.raw["technology"]["accelerated-productivity-module-3"].unit.ingredients, { "subterranean-science-pack", 1 })
    table.insert(data.raw["technology"]["heavy-rocket-thruster"].unit.ingredients, { "subterranean-science-pack", 1 })
    table.insert(data.raw["technology"]["autocannon-turret"].unit.ingredients, { "subterranean-science-pack", 1 })
end

graphics_updater.update_entity_graphics("assembling-machine", "assembling-machine-3", "automation-3", "assembling-machine", "band-saw", constants.vulcanus_lava_tubes_tint)
graphics_updater.update_entity_graphics("assembling-machine", "crusher", "", "assembling-machine", "pulverizer", constants.vulcanus_lava_tubes_tint)
graphics_updater.update_entity_graphics("assembling-machine", "foundry", "foundry", "assembling-machine", "lava-filtration-plant", constants.vulcanus_lava_tubes_tint)
graphics_updater.update_entity_graphics("thruster", "thruster", "space-platform-thruster", "thruster", "heavy-rocket-thruster", constants.vulcanus_lava_tubes_tint)
