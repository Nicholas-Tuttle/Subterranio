local graphics_updater = require("__subterranio-base__/utilities/graphics-updater")
local constants = require("scripts.constants")

table.insert(data.raw["lab"]["lab"].inputs, "biological-science-pack")
table.insert(data.raw["lab"]["biolab"].inputs, "biological-science-pack")

table.insert(data.raw["technology"]["planet-discovery-aquilo"].unit.ingredients, {"biological-science-pack", 1})
table.insert(data.raw["technology"]["planet-discovery-aquilo"].prerequisites, "biological-science-pack")

for key, _ in pairs(data.raw["mining-drill"]) do
    table.insert(data.raw["mining-drill"][key].resource_categories, "roots")
end

table.insert(data.raw["item"]["landfill"].place_as_tile.tile_condition, "gleban-subterranean-deep-water")
table.insert(data.raw["item"]["foundation"].place_as_tile.tile_condition, "gleban-subterranean-deep-water")

if mods["subterranio-nauvis"] then
    table.insert(data.raw["technology"]["high-capacity-cargo-bay"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["ice-packaging"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["packaging"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["root-clearer"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["subterranean-overgrowth-soil"].unit.ingredients, {"subterranean-science-pack", 1})
end

graphics_updater.update_entity_graphics("assembling-machine", "assembling-machine-3", "automation-3", "assembling-machine", "ice-machine", constants.gleban_biospheres_tint)
graphics_updater.update_entity_graphics("assembling-machine", "assembling-machine-3", "automation-3", "assembling-machine", "packaging-machine", constants.packaging_machine_tint)
graphics_updater.update_entity_graphics("mining-drill", "electric-mining-drill", "electric-mining-drill", "mining-drill", "root-clearer", constants.gleban_biospheres_tint)
graphics_updater.update_entity_graphics("cargo-bay", "cargo-bay", "", "cargo-bay", "high-capacity-cargo-bay", constants.gleban_biospheres_tint)
