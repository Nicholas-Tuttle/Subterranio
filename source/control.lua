_G.subterrain = require("scripts.constants")

require("lib.events")

require("scripts.entity.mineshaft")
require("scripts.entity.mineshaft-belt")
require("scripts.map-gen.subterranean-surface")
require("scripts.player.impassable-cliff")

subterrain.finalize_events()
