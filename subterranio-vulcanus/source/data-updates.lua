table.insert(data.raw["lab"]["lab"].inputs, "propulsion-science-pack")
table.insert(data.raw["lab"]["biolab"].inputs, "propulsion-science-pack")

table.insert(data.raw["technology"]["planet-discovery-aquilo"].unit.ingredients, { "propulsion-science-pack", 1 })
table.insert(data.raw["technology"]["planet-discovery-aquilo"].prerequisites, "propulsion-science-pack")

if mods["subterranio-nauvis"] then
    table.insert(data.raw["recipe"]["band-saw"].ingredients, { type = "item", name = "diamond-shard", amount = 20 })
    table.insert(data.raw["recipe"]["titanium-plate"].ingredients, { type = "item", name = "diamond-shard", amount = 1 })
    table.insert(data.raw["recipe"]["aluminum-plate"].ingredients, { type = "item", name = "diamond-shard", amount = 1 })
    table.insert(data.raw["technology"]["aluminum-cutting"].unit.ingredients, { "subterranean-science-pack", 1 })
    table.insert(data.raw["technology"]["titanium-pulverization"].unit.ingredients, { "subterranean-science-pack", 1 })
    table.insert(data.raw["technology"]["titanium-cutting"].unit.ingredients, { "subterranean-science-pack", 1 })
end
