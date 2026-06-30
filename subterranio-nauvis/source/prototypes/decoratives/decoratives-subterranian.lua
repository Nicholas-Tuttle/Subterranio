local hit_effects = require("__base__.prototypes.entity.hit-effects")
local decorative_trigger_effects = require("__base__.prototypes.decorative.decorative-trigger-effects")
local graphics_tinter = require("__subterranio-base__.utilities.graphics-tinter")

local subterranean_rock_tint = { .5, .5, .6 }

data:extend {
	--- TINTABLE ROCKS
	--- BIG ROCKS
	{
		name = "huge-subterranean-rock",
		type = "simple-entity",
		flags = { "placeable-neutral", "placeable-off-grid" },
		icon = "__space-age__/graphics/icons/huge-volcanic-rock.png",
		subgroup = "grass",
		order = "b[decorative]-l[rock]-f[huge-volcanic-rock]",
		collision_box = { { -1.5, -1.1 }, { 1.5, 1.1 } },
		selection_box = { { -1.7, -1.3 }, { 1.7, 1.3 } },
		damaged_trigger_effect = hit_effects.rock(),
		dying_trigger_effect = decorative_trigger_effects.huge_rock(),
		minable =
		{
			mining_particle = "stone-particle",
			mining_time = 1,
			results =
			{
				{ type = "item", name = "stone",      amount_min = 6,  amount_max = 18 },
				{ type = "item", name = "iron-ore",   amount_min = 9,  amount_max = 27 },
				{ type = "item", name = "copper-ore", amount_min = 6,  amount_max = 18 },
				{ type = "item", name = "coal",       amount_min = 20, amount_max = 40 },
			},
		},
		map_color = { 61, 57, 53 },
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
			layers =
			{
				graphics_tinter.tint(util.sprite_load("__space-age__/graphics/decorative/vulcanus-rocks/vulcanus-rock-huge", { scale = 0.5, variation_count = 15, multiply_shift = 0.5 }), subterranean_rock_tint)
			}
		},
	},
	{
		name = "big-subterranean-rock",
		type = "simple-entity",
		flags = { "placeable-neutral", "placeable-off-grid" },
		icon = "__space-age__/graphics/icons/big-volcanic-rock.png",
		subgroup = "grass",
		order = "b[decorative]-l[rock]-f[big-volcanic-rock]",
		collision_box = { { -0.75, -0.75 }, { 0.75, 0.75 } },
		selection_box = { { -1.0, -1.0 }, { 1.0, 0.75 } },
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
				{ type = "item", name = "stone",      amount_min = 2, amount_max = 12 },
				{ type = "item", name = "iron-ore",   amount_min = 5, amount_max = 9 },
				{ type = "item", name = "copper-ore", amount_min = 3, amount_max = 7 },
				{ type = "item", name = "coal",       amount_min = 7, amount_max = 14 },
			}
		},
		resistances =
		{
			{
				type = "fire",
				percent = 100
			}
		},
		map_color = { 61, 57, 53 },
		count_as_rock_for_filtered_deconstruction = true,
		mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
		impact_category = "stone",
		pictures =
		{
			layers =
			{
				graphics_tinter.tint(util.sprite_load("__space-age__/graphics/decorative/vulcanus-rocks/vulcanus-rock-big", { scale = 0.5, variation_count = 16, multiply_shift = 0.5 }), subterranean_rock_tint),
				util.sprite_load("__space-age__/graphics/decorative/vulcanus-rocks/vulcanus-rock-big-emissive", { scale = 0.5, variation_count = 16, multiply_shift = 0.5, draw_as_glow = true })
			}
		}
	}
}
