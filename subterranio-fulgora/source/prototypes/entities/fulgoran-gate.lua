local entity = table.deepcopy(data.raw["gate"]["gate"])
entity.name = "fulgoran-gate"
entity.activation_distance = 0
entity.opening_speed = 0
entity.opening_sound = nil
entity.closing_sound = nil

data:extend{entity}
