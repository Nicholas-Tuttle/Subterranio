local graphics_updater = require("__subterranio-base__/utilities/graphics-updater")
local constants = require("scripts.constants")

table.insert(data.raw["lab"]["lab"].inputs, "induction-science-pack")
table.insert(data.raw["lab"]["biolab"].inputs, "induction-science-pack")

table.insert(data.raw["technology"]["planet-discovery-aquilo"].unit.ingredients, {"induction-science-pack", 1})
table.insert(data.raw["technology"]["planet-discovery-aquilo"].prerequisites, "induction-science-pack")

table.insert(data.raw["technology"]["railgun"].unit.ingredients, {"induction-science-pack", 1})
table.insert(data.raw["technology"]["railgun"].prerequisites, "electromagnets")

table.insert(data.raw["recipe"]["railgun"].ingredients, {type = "item", name = "electromagnet", amount = 20})
table.insert(data.raw["recipe"]["railgun-turret"].ingredients, {type = "item", name = "electromagnet", amount = 50})

table.insert(out_of_map_tile_type_names, "subway-out-of-map")

if mods["subterranio-nauvis"] then
    table.insert(data.raw["technology"]["advanced-chemical-plant"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["electromagnets"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["electrostatic-shielding"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["holmium-cabling"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["induction-furnace"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["induction-science-pack"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["magnetic-asteroid-collector"].unit.ingredients, {"subterranean-science-pack", 1})
    -- table.insert(data.raw["technology"]["magnetic-bearings"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["magnetic-component-processing"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["magnetic-shielding"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["neodymium-magnets"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["transformer-station"].unit.ingredients, {"subterranean-science-pack", 1})
end

graphics_updater.update_entity_graphics("assembling-machine", "assembling-machine-3", "automation-3", "assembling-machine", "magnetic-component-assembler", constants.fulgoran_subway_tint)
graphics_updater.update_entity_graphics("electric-pole", "substation", "electric-energy-distribution-2", "electric-pole", "transformer-station", constants.fulgoran_subway_tint)
graphics_updater.update_entity_graphics("asteroid-collector", "asteroid-collector", "", "asteroid-collector", "magnetic-asteroid-collector", constants.fulgoran_subway_tint)
