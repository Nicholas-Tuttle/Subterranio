if mods["subterranio-nauvis"] then
    table.insert(data.raw["recipe"]["band-saw"].ingredients, { type = "item", name = "diamond-shard", amount = 20 })
    table.insert(data.raw["recipe"]["titanium-plate"].ingredients, { type = "item", name = "diamond-shard", amount = 1 })
end
