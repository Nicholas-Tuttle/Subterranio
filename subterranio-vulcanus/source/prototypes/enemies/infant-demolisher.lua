local enemy_autoplace = require("__base__.prototypes.entity.enemy-autoplace-utils")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")

require("__space-age__.prototypes.entity.enemies")

local constants = require("scripts.constants")
local graphics_tinter = require("__subterranio-base__.utilities.graphics-tinter")

local scale = 0.1

-- Pulled from https://github.com/wube/factorio-data/blob/0efbfa85cd3d32f0fa4671173b603294dc188762/space-age/prototypes/entity/enemies.lua#L278
local demolisher_segment_scales =
{
    1.09, 1.27, 1.36, 1.36, 1.36, 1.36, 1.33, 1.30,
    1.37, 1.52, 1.52, 1.40, 1.41, 1.28, 1.28, 1.17,
    1.10, 1.08, 1.08, 1.09, 1.20, 1.20, 1.10, 1.10,
    0.99, 0.99, 0.99, 0.87, 0.87, 0.97, 0.87, 0.97,
    0.99, 0.87, 0.87, 0.87, 0.87, 0.77, 0.77, 0.65,
    0.64,
}

local head = make_demolisher_head("infant-demolisher", "s-k", scale, 0.25, 5000, 20, 0.85,
    simulations.factoriopedia_vulcanus_enemy_small_demolisher, space_age_sounds.demolisher.small)
head.icon = "__space-age__/graphics/icons/small-demolisher.png"
head.dying_trigger_effect[1].entity_name = "small-demolisher-corpse"
head.autoplace = {}
head.autoplace.control = "infant_demolisher"
head.autoplace.force = "enemy"
head.autoplace.probability_expression = "clamp(distance - 50, 0, 1) / 2500"
head.vision_distance = 64
head.turn_radius = 8
head.turn_smoothing = 0.5
head.patrolling_turn_radius = 16
head.territory_radius = 4
head = graphics_tinter.tint(head, constants.vulcanus_lava_tubes_tint)

data:extend({ head })

local segments = make_demolisher_segments("infant-demolisher", demolisher_segment_scales, scale, 0.25, 5000,
    space_age_sounds.demolisher.small)
for _, segment in pairs(segments) do
    segment.corpse = "small-demolisher-corpse"
    if segment.dying_trigger_effect and segment.dying_trigger_effect[1] then
        segment.dying_trigger_effect[1].entity_name = "small-demolisher-corpse"
    end
    segment = graphics_tinter.tint(segment, constants.vulcanus_lava_tubes_tint)
end

data:extend(segments)

local corpse = make_demolisher_corpse("infant-demolisher", "s-k", scale)
corpse[1].icon = "__space-age__/graphics/icons/small-demolisher-remains.png"

data:extend(corpse)

local effects = make_demolisher_effects("infant-demolisher", "s-k", scale, 0.25)
for _, effect in pairs(effects) do
    if (effect.time_before_removed) then
        effect.time_before_removed = 60 * 3
    end
end
for _, effect in pairs(effects) do
    if (effect.duration) then
        effect.duration = 60 * 3
        effect.fade_away_duration = 60 * 2
    end
end

data:extend(effects)

local autoplace = {
    type = "autoplace-control",
    name = "infant_demolisher",
    category = "enemy"
}

data:extend({ autoplace })
