local cave_floor = table.deepcopy(data.raw["tile"]["dirt-1"])
cave_floor.name = "cave-floor"
cave_floor.order = "z[subterrain]-a[cave-floor][dirt-1]"
cave_floor.autoplace.probability_expression = "1 - subterranean_impassable_cliffs_ridge_noise_expression"

data:extend{cave_floor}