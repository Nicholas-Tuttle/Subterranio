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

return {
    diamond_image_path = "__subterranio-nauvis__/graphics/entity/diamond.png",
    diamond_image_size = 256,
    diamond_ore_image_path = "__subterranio-nauvis__/graphics/entity/diamond-ore.png",
    diamond_ore_image_size = 256,
    diamond_ore_resource_image_path = "__subterranio-nauvis__/graphics/entity/diamond-ore-1.png",
    diamond_shard_image_path = "__subterranio-nauvis__/graphics/entity/diamond-shard.png",
    diamond_shard_image_size = 256,
    subterranean_science_pack_image_path = "__subterranio-nauvis__/graphics/entity/subterranean-science-pack.png",
    subterranean_science_pack_image_size = 256,
    cave_scaffolding_image_path = "__subterranio-nauvis__/graphics/entity/cave-scaffolding.png",
    cave_scaffolding_image_size = 256,

    subterrain_starmap_icon_path = "__subterranio-nauvis__/graphics/entity/mineshaft.png",
    subterrain_starmap_icon_size = 512,

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

    subterrain_pressure = 5000,
    subterrain_gravity = 20,
}
