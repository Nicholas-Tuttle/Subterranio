table.insert(data.raw["lab"]["lab"].inputs, "subterranean-science-pack")
table.insert(data.raw["lab"]["biolab"].inputs, "subterranean-science-pack")

table.insert(data.raw["furnace"]["stone-furnace"].crafting_categories, "smelting-or-metallurgy")
table.insert(data.raw["furnace"]["steel-furnace"].crafting_categories, "smelting-or-metallurgy")
table.insert(data.raw["furnace"]["electric-furnace"].crafting_categories, "smelting-or-metallurgy")
table.insert(data.raw["assembling-machine"]["foundry"].crafting_categories, "smelting-or-metallurgy")

table.insert(data.raw["technology"]["planet-discovery-aquilo"].unit.ingredients, {"subterranean-science-pack", 1})
table.insert(data.raw["technology"]["planet-discovery-aquilo"].prerequisites, "subterranean-science-pack")

table.insert(data.raw["technology"]["quantum-processor"].unit.ingredients, {"subterranean-science-pack", 1})
table.insert(data.raw["technology"]["captive-biter-spawner"].unit.ingredients, {"subterranean-science-pack", 1})
table.insert(data.raw["technology"]["foundation"].unit.ingredients, {"subterranean-science-pack", 1})
table.insert(data.raw["technology"]["fusion-reactor"].unit.ingredients, {"subterranean-science-pack", 1})
table.insert(data.raw["technology"]["fusion-reactor-equipment"].unit.ingredients, {"subterranean-science-pack", 1})
table.insert(data.raw["technology"]["legendary-quality"].unit.ingredients, {"subterranean-science-pack", 1})
table.insert(data.raw["technology"]["railgun"].unit.ingredients, {"subterranean-science-pack", 1})
table.insert(data.raw["technology"]["railgun-damage-1"].unit.ingredients, {"subterranean-science-pack", 1})
table.insert(data.raw["technology"]["promethium-science-pack"].unit.ingredients, {"subterranean-science-pack", 1})
table.insert(data.raw["technology"]["research-productivity"].unit.ingredients, {"subterranean-science-pack", 1})

table.insert(data.raw["technology"]["tunnelling-drill-equipment"].effects, {type = "unlock-space-location", space_location = "subterrain", use_icon_overlay_constant = true})
table.insert(data.raw["technology"]["tunnelling-drill-equipment"].effects, {type = "unlock-space-location", space_location = "subterrain_level_2", use_icon_overlay_constant = true})
