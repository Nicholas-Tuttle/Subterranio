table.insert(data.raw["lab"]["lab"].inputs, "induction-science-pack")
table.insert(data.raw["lab"]["biolab"].inputs, "induction-science-pack")

table.insert(data.raw["technology"]["planet-discovery-aquilo"].unit.ingredients, {"induction-science-pack", 1})
table.insert(data.raw["technology"]["planet-discovery-aquilo"].prerequisites, "induction-science-pack")

table.insert(data.raw["technology"]["railgun"].unit.ingredients, {"induction-science-pack", 1})
table.insert(data.raw["technology"]["railgun"].prerequisites, "electromagnets")

table.insert(data.raw["recipe"]["railgun"].ingredients, {type = "item", name = "electromagnet", amount = 20})
table.insert(data.raw["recipe"]["railgun-turret"].ingredients, {type = "item", name = "electromagnet", amount = 50})

if mods["subterranio-nauvis"] then
    table.insert(out_of_map_tile_type_names, "cave-wall")

    table.insert(data.raw["technology"]["advanced-chemical-plant"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["electromagnets"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["electrostatic-shielding"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["holmium-cabling"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["induction-furnace"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["induction-science-pack"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["magnetic-asteroid-collector"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["magnetic-bearings"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["magnetic-component-processing"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["magnetic-shielding"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["neodymium-magnets"].unit.ingredients, {"subterranean-science-pack", 1})
    table.insert(data.raw["technology"]["transformer-station"].unit.ingredients, {"subterranean-science-pack", 1})
end
