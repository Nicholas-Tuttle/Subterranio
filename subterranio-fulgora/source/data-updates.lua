table.insert(data.raw["lab"]["lab"].inputs, "induction-science-pack")
table.insert(data.raw["lab"]["biolab"].inputs, "induction-science-pack")

table.insert(data.raw["technology"]["planet-discovery-aquilo"].unit.ingredients, {"induction-science-pack", 1})
table.insert(data.raw["technology"]["planet-discovery-aquilo"].prerequisites, "induction-science-pack")

table.insert(data.raw["technology"]["railgun"].unit.ingredients, {"induction-science-pack", 1})
table.insert(data.raw["technology"]["railgun"].prerequisites, "electromagnets")

table.insert(data.raw["recipe"]["railgun"].ingredients, {type = "item", name = "electromagnet", amount = 20})
table.insert(data.raw["recipe"]["railgun-turret"].ingredients, {type = "item", name = "electromagnet", amount = 50})