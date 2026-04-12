local randomized_tiles = {
    "lowland-olive-blubber",
    "lowland-olive-blubber-2",
    "lowland-olive-blubber-3",
    "lowland-brown-blubber",
    "lowland-pale-green",
    "lowland-cream-cauliflower",
    "lowland-cream-cauliflower-2",
    "lowland-dead-skin",
    "lowland-dead-skin-2",
    "lowland-cream-red",
    "lowland-red-vein",
    "lowland-red-vein-2",
    "lowland-red-vein-3",
    "lowland-red-vein-4",
    "lowland-red-vein-dead",
    "lowland-red-infection",
}

local randomized_decoratives = {
    "solo-barnacle",
    "knobbly-roots",
    "knobbly-roots-orange",
    "brown-cup",
    "curly-roots-grey",
    "veins",
    "veins-small",
    "white-carpet-grass",
    "grey-cracked-mud-decal",
    "pink-phalanges",
    "mycelium",
    "nerve-roots-dense",
    "nerve-roots-sparse",
    "brambles",
    "coral-stunted-grey",
    "coral-stunted",
    "barnacles-decal",
    "purple-nerve-roots-veins-dense",
    "purple-nerve-roots-veins-sparse",
    "coral-water",
    "gleba-spawner-slime",
}

local randomized_entities = {
    {
        ["type"] = "tree",
        ["name"] = "sunnycomb",
    },
    {
        ["type"] = "tree",
        ["name"] = "funneltrunk",
    },
    {
        ["type"] = "tree",
        ["name"] = "water-cane",
    },
}

local biomes = {
    ["blue"] = {
        ["tiles"] = {
            "lowland-pale-green",
            "lowland-brown-blubber",
            "lowland-olive-blubber-3",
            "lowland-olive-blubber-2",
            "lowland-olive-blubber",
        },
        ["map_color"] = function(index, biome_tile_count)
            return { r = 50, g = 0, b = 50 + math.min(((255.0 - 50) * (index + 1) / biome_tile_count), (255 - 50)) }
        end,
        ["decoratives"] = {
            "green-cup",
            "black-sceptre",
            "polycephalum-slime",
            "polycephalum-balloon",
            "wispy-lichen",
            "pale-lettuce-lichen-1x1",
            "pale-lettuce-lichen-3x3",
            "pale-lettuce-lichen-6x6",
            "pale-lettuce-lichen-water-1x1",
            "pale-lettuce-lichen-water-3x3",
            "pale-lettuce-lichen-water-6x6",
            "green-lettuce-lichen-1x1",
            "green-lettuce-lichen-3x3",
            "green-lettuce-lichen-6x6",
            "green-lettuce-lichen-water-1x1",
            "green-lettuce-lichen-water-3x3",
            "green-lettuce-lichen-water-6x6",
        },
        ["entity"] = {
            {
                ["type"] = "tree",
                ["name"] = "stingfrond",
            },
            {
                ["type"] = "tree",
                ["name"] = "cuttlepop",
            },
            {
                ["type"] = "tree",
                ["name"] = "slipstack",
            },
            {
                ["type"] = "tree",
                ["name"] = "hairyclubnub",
            },
        },
        ["tint"] = { r = 200, g = 200, b = 255 },
    },
    ["red"] = {
        ["tiles"] = {
            "lowland-cream-red",
            "lowland-dead-skin-2",
            "lowland-dead-skin",
            "lowland-cream-cauliflower-2",
            "lowland-cream-cauliflower",
            "lowland-olive-blubber",
        },
        ["map_color"] = function(index, biome_tile_count)
            return { r = 50 + math.min(((255.0 - 50) * (index + 1) / biome_tile_count), (255 - 50)), g = 0, b = 50 }
        end,
        ["decoratives"] = {
            "blood-grape",
            "blood-grape-vibrant",
            "yellow-coral",
            "red-lichen-decal",
            "yellow-lettuce-lichen-1x1",
            "yellow-lettuce-lichen-3x3",
            "yellow-lettuce-lichen-6x6",
            "yellow-lettuce-lichen-cups-1x1",
            "yellow-lettuce-lichen-cups-3x3",
            "yellow-lettuce-lichen-cups-6x6",
            "pale-lettuce-lichen-cups-1x1",
            "pale-lettuce-lichen-cups-3x3",
            "pale-lettuce-lichen-cups-6x6",
            "coral-land",
            "honeycomb-fungus",
            "honeycomb-fungus-1x1",
            "honeycomb-fungus-decayed",
            "matches-small",
            "split-gill-1x1",
            "split-gill-2x2",
            "split-gill-dying-1x1",
            "split-gill-dying-2x2",
            "split-gill-red-1x1",
            "split-gill-red-2x2",
            "red-nerve-roots-veins-dense",
            "red-nerve-roots-veins-sparse",
            "fuchsia-pita",
            "cream-nerve-roots-veins-dense",
            "cream-nerve-roots-veins-sparse",
            "curly-roots-orange",
        },
        ["entity"] = {
            {
                ["type"] = "tree",
                ["name"] = "teflilly",
            },
            {
                ["type"] = "tree",
                ["name"] = "lickmaw",
            },
            {
                ["type"] = "tree",
                ["name"] = "boompuff",
            },
        },
        ["tint"] = { r = 255, g = 200, b = 200 },
    },
}

return {
    randomized_tiles = randomized_tiles,
    randomized_decoratives = randomized_decoratives,
    randomized_entities = randomized_entities,
    biomes = biomes,
}
