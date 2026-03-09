local entity = table.deepcopy(data.raw["wall"]["stone-wall"])
entity.name = "fulgoran-wall"

data:extend{entity}
