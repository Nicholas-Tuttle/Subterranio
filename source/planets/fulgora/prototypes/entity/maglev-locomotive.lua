local maglev_locomotive = table.deepcopy(data.raw["locomotive"]["locomotive"])
maglev_locomotive.name = "maglev-locomotive"
maglev_locomotive.max_speed = maglev_locomotive.max_speed * 5
maglev_locomotive.max_power = "3000MW"
maglev_locomotive.friction_force = 0.01

data:extend{maglev_locomotive}