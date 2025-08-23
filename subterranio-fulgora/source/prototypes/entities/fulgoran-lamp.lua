local entity = table.deepcopy(data.raw["lamp"]["small-lamp"])
entity.name = "fulgoran-lamp"
entity.energy_source = {
    type = "void",
    emissions_per_minute = nil,
    render_no_network_icon = false,
    render_no_power_icon = false
}
entity.energy_usage_per_tick = "1J"
entity.always_on = true
entity.glow_size = 8
entity.light = {intensity = 0.9, size = 40, color = {1, 0.635, 0.173}}

data:extend{entity}
