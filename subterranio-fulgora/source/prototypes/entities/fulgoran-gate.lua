local graphics_tinter = require("__subterranio-base__/utilities/graphics-tinter")

local entity = table.deepcopy(data.raw["gate"]["gate"])
entity.name = "fulgoran-gate"
entity.opening_speed = 0.0666666
entity.activation_distance = 3
entity.timeout_to_close = 5
entity.fadeout_interval = 15
entity.opening_sound = nil
entity.closing_sound = nil
local auto_target_fulgoran_gates = settings.startup["fulgoran-gate-auto-target"].value
entity.is_military_target = auto_target_fulgoran_gates
entity = graphics_tinter.tint(entity, { r = 1.0, g = 0.75, b = 0.75, a = 1 })

data:extend { entity }
