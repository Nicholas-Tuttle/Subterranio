local human_readable_id = "nauvis-subterrain"

local diamond_ore_min_cavern_size = 0.15
local diamond_ore_max_cavern_size = 0.5
local diamond_ore_min_patch_size = diamond_ore_min_cavern_size / 3
local diamond_ore_max_patch_size = diamond_ore_max_cavern_size / 3
local diamond_ore_patch_seed = 1234

local coal_ore_min_cavern_size = 0.2
local coal_ore_max_cavern_size = 0.5
local coal_ore_min_patch_size = coal_ore_min_cavern_size / 2
local coal_ore_max_patch_size = coal_ore_max_cavern_size / 3
local coal_ore_patch_seed = 2345

local stone_ore_min_cavern_size = coal_ore_min_cavern_size
local stone_ore_max_cavern_size = coal_ore_max_cavern_size
local stone_ore_min_patch_size = coal_ore_min_patch_size
local stone_ore_max_patch_size = coal_ore_max_patch_size
local stone_ore_patch_seed = 3456

local iron_ore_min_cavern_size = 0.1
local iron_ore_max_cavern_size = 0.5
local iron_ore_min_patch_size = iron_ore_min_cavern_size / 2
local iron_ore_max_patch_size = iron_ore_max_cavern_size / 4
local iron_ore_patch_seed = 4567

local copper_ore_min_cavern_size = iron_ore_min_cavern_size
local copper_ore_max_cavern_size = iron_ore_max_cavern_size
local copper_ore_min_patch_size = iron_ore_min_patch_size
local copper_ore_max_patch_size = iron_ore_max_patch_size
local copper_ore_patch_seed = 5678

local uranium_ore_min_cavern_size = 0.05
local uranium_ore_max_cavern_size = 0.1
local uranium_ore_min_patch_size = uranium_ore_min_cavern_size / 2
local uranium_ore_max_patch_size = uranium_ore_max_cavern_size / 2
local uranium_ore_patch_seed = 6789

local subterrain_pressure = 5000
local subterrain_gravity = 20

return {
    human_readable_id = human_readable_id,

    diamond_ore_min_cavern_size = diamond_ore_min_cavern_size,
    diamond_ore_max_cavern_size = diamond_ore_max_cavern_size,
    diamond_ore_min_patch_size = diamond_ore_min_patch_size,
    diamond_ore_max_patch_size = diamond_ore_max_patch_size,
    diamond_ore_patch_seed = diamond_ore_patch_seed,

    coal_ore_min_cavern_size = coal_ore_min_cavern_size,
    coal_ore_max_cavern_size = coal_ore_max_cavern_size,
    coal_ore_min_patch_size = coal_ore_min_patch_size,
    coal_ore_max_patch_size = coal_ore_max_patch_size,
    coal_ore_patch_seed = coal_ore_patch_seed,

    stone_ore_min_cavern_size = stone_ore_min_cavern_size,
    stone_ore_max_cavern_size = stone_ore_max_cavern_size,
    stone_ore_min_patch_size = stone_ore_min_patch_size,
    stone_ore_max_patch_size = stone_ore_max_patch_size,
    stone_ore_patch_seed = stone_ore_patch_seed,

    iron_ore_min_cavern_size = iron_ore_min_cavern_size,
    iron_ore_max_cavern_size = iron_ore_max_cavern_size,
    iron_ore_min_patch_size = iron_ore_min_patch_size,
    iron_ore_max_patch_size = iron_ore_max_patch_size,
    iron_ore_patch_seed = iron_ore_patch_seed,

    copper_ore_min_cavern_size = copper_ore_min_cavern_size,
    copper_ore_max_cavern_size = copper_ore_max_cavern_size,
    copper_ore_min_patch_size = copper_ore_min_patch_size,
    copper_ore_max_patch_size = copper_ore_max_patch_size,
    copper_ore_patch_seed = copper_ore_patch_seed,

    uranium_ore_min_cavern_size = uranium_ore_min_cavern_size,
    uranium_ore_max_cavern_size = uranium_ore_max_cavern_size,
    uranium_ore_min_patch_size = uranium_ore_min_patch_size,
    uranium_ore_max_patch_size = uranium_ore_max_patch_size,
    uranium_ore_patch_seed = uranium_ore_patch_seed,

    subterrain_pressure = subterrain_pressure,
    subterrain_gravity = subterrain_gravity,
}