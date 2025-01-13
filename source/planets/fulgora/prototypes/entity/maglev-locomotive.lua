local maglev_locomotive = table.deepcopy(data.raw["locomotive"]["locomotive"])
maglev_locomotive.max_speed = maglev_locomotive.max_speed * 5
maglev_locomotive.max_power = maglev_locomotive.max_power * 5
maglev_locomotive.friction_force = 0.01

data:extend(maglev_locomotive)