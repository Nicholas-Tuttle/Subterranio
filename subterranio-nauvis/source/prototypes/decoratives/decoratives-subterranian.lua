local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local decorative_trigger_effects = require("__base__.prototypes.decorative.decorative-trigger-effects")

local subterranean_rock_tint = {.5,.5,.6}

data:extend{
	--- TINTABLE ROCKS
	--- BIG ROCKS
	{
		name = "huge-subterranean-rock",
		type = "simple-entity",
		flags = {"placeable-neutral", "placeable-off-grid"},
		icon = "__space-age__/graphics/icons/huge-volcanic-rock.png",
		subgroup = "grass",
		order = "b[decorative]-l[rock]-f[huge-volcanic-rock]",
		collision_box = {{-1.5, -1.1}, {1.5, 1.1}},
		selection_box = {{-1.7, -1.3}, {1.7, 1.3}},
		damaged_trigger_effect = hit_effects.rock(),
		dying_trigger_effect = decorative_trigger_effects.huge_rock(),
		minable =
		{
			mining_particle = "stone-particle",
			mining_time = 1,
			results =
			{
				{type = "item", name = "stone", amount_min = 6, amount_max = 18},
				{type = "item", name = "iron-ore", amount_min = 9, amount_max = 27},
				{type = "item", name = "copper-ore", amount_min = 6, amount_max = 18},
				{type = "item", name = "coal", amount_min = 20, amount_max = 40},
			},
		},
		map_color = {61, 57, 53},
		count_as_rock_for_filtered_deconstruction = true,
		mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
		impact_category = "stone",
		render_layer = "object",
		max_health = 2000,
		resistances =
		{
			{
				type = "fire",
				percent = 100
			}
		},
		autoplace = {
			order = "a[landscape]-c[rock]-a[huge]",
			probability_expression = "vulcanus_rock_huge"
		},
		pictures =
		{
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-05.png",
				width = 201,
				height = 179,
				scale = 0.5,
				shift = {0.25, 0.0625},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-06.png",
				width = 233,
				height = 171,
				scale = 0.5,
				shift = {0.429688, 0.046875},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-07.png",
				width = 240,
				height = 192,
				scale = 0.5,
				shift = {0.398438, 0.03125},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-08.png",
				width = 219,
				height = 175,
				scale = 0.5,
				shift = {0.148438, 0.132812},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-09.png",
				width = 240,
				height = 208,
				scale = 0.5,
				shift = {0.3125, 0.0625},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-10.png",
				width = 243,
				height = 190,
				scale = 0.5,
				shift = {0.1875, 0.046875},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-11.png",
				width = 249,
				height = 185,
				scale = 0.5,
				shift = {0.398438, 0.0546875},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-12.png",
				width = 273,
				height = 163,
				scale = 0.5,
				shift = {0.34375, 0.0390625},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-13.png",
				width = 275,
				height = 175,
				scale = 0.5,
				shift = {0.273438, 0.0234375},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-14.png",
				width = 241,
				height = 215,
				scale = 0.5,
				shift = {0.195312, 0.0390625},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-15.png",
				width = 318,
				height = 181,
				scale = 0.5,
				shift = {0.523438, 0.03125},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-16.png",
				width = 217,
				height = 224,
				scale = 0.5,
				shift = {0.0546875, 0.0234375},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-17.png",
				width = 332,
				height = 228,
				scale = 0.5,
				shift = {0.226562, 0.046875},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-18.png",
				width = 290,
				height = 243,
				scale = 0.5,
				shift = {0.195312, 0.0390625},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-19.png",
				width = 349,
				height = 225,
				scale = 0.5,
				shift = {0.609375, 0.0234375},
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/huge-volcanic-rock/huge-volcanic-rock-20.png",
				width = 287,
				height = 250,
				scale = 0.5,
				shift = {0.132812, 0.03125},
				tint = subterranean_rock_tint
			}
		}
	},
	{
		name = "big-subterranean-rock",
		type = "simple-entity",
		flags = {"placeable-neutral", "placeable-off-grid"},
		icon = "__space-age__/graphics/icons/big-volcanic-rock.png",
		subgroup = "grass",
		order = "b[decorative]-l[rock]-f[big-volcanic-rock]",
		collision_box = {{-0.75, -0.75}, {0.75, 0.75}},
		selection_box = {{-1.0, -1.0}, {1.0, 0.75}},
		damaged_trigger_effect = hit_effects.rock(),
		render_layer = "object",
		max_health = 500,
		autoplace = {
			order = "a[landscape]-c[rock]-b[big]",
			probability_expression = "vulcanus_rock_big"
		},
		dying_trigger_effect = decorative_trigger_effects.big_rock(),
		minable =
		{
			mining_particle = "stone-particle",
			mining_time = 2,
			results =
			{
				{type = "item", name = "stone", amount_min = 2, amount_max = 12},
				{type = "item", name = "iron-ore", amount_min = 5, amount_max = 9},
				{type = "item", name = "copper-ore", amount_min = 3, amount_max = 7},
				{type = "item", name = "coal", amount_min = 7, amount_max = 14},
			}
		},
		resistances =
		{
			{
				type = "fire",
				percent = 100
			}
		},
		map_color = {61, 57, 53},
		count_as_rock_for_filtered_deconstruction = true,
		mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
		impact_category = "stone",
		pictures =
		{
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-01.png",
				width =  188 ,
				height =  127 ,
				shift = {0.304688, -0.4},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-02.png",
				width =  195 ,
				height =  135 ,
				shift = {0.0, 0.0390625},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-03.png",
				width =  205 ,
				height =  132 ,
				shift = {0.151562, 0.0},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-04.png",
				width =  144 ,
				height =  142 ,
				shift = {0.151562, 0.0},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-05.png",
				width =  130 ,
				height =  107 ,
				shift = {0.390625, 0.0},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-06.png",
				width =  165 ,
				height =  109 ,
				shift = {0.328125, 0.0703125},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-07.png",
				width =  150 ,
				height =  133 ,
				shift = {0.16875, -0.1},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-08.png",
				width =  156 ,
				height =  111 ,
				shift = {0.3, -0.2},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-09.png",
				width =  187 ,
				height =  120 ,
				shift = {0.0, 0.0},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-10.png",
				width =  225 ,
				height =  128 ,
				shift = {0.1, 0.0},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-11.png",
				width =  183 ,
				height =  144 ,
				shift = {0.325, -0.1},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-12.png",
				width =  158 ,
				height =  138 ,
				shift = {0.453125, 0.0},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-13.png",
				width =  188 ,
				height =  150 ,
				shift = {0.539062, -0.015625},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-14.png",
				width =  186 ,
				height =  160 ,
				shift = {0.0703125, 0.179688},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-15.png",
				width =  181 ,
				height =  174 ,
				shift = {0.160938, 0.0},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-16.png",
				width =  212 ,
				height =  150 ,
				shift = {0.242188, -0.195312},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-17.png",
				width =  155 ,
				height =  117 ,
				shift = {0.351562, -0.1},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-18.png",
				width =  141 ,
				height =  128 ,
				shift = {0.351562, -0.1},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-19.png",
				width =  176 ,
				height =  114 ,
				shift = {0.351562, -0.1},
				scale = 0.5,
				tint = subterranean_rock_tint
			},
			{
				filename = "__space-age__/graphics/decorative/big-volcanic-rock/big-volcanic-rock-20.png",
				width =  120 ,
				height =  125 ,
				shift = {0.351562, -0.1},
				scale = 0.5,
				tint = subterranean_rock_tint
			}
		}
	}
}