table.insert(data.raw["lab"]["lab"].inputs, "biological-science-pack")
table.insert(data.raw["lab"]["biolab"].inputs, "biological-science-pack")

table.insert(data.raw["technology"]["planet-discovery-aquilo"].unit.ingredients, {"biological-science-pack", 1})
table.insert(data.raw["technology"]["planet-discovery-aquilo"].prerequisites, "biological-science-pack")

for key, _ in pairs(data.raw["mining-drill"]) do
    table.insert(data.raw["mining-drill"][key].resource_categories, "roots")
end

table.insert(data.raw["item"]["landfill"].place_as_tile.tile_condition, "gleban-subterranean-deep-water")
table.insert(data.raw["item"]["foundation"].place_as_tile.tile_condition, "gleban-subterranean-deep-water")