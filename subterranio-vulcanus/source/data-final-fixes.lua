local starmap_icon_util = require("__subterranio-base__.utilities.starmap-icon")
local starmap_icon_position = starmap_icon_util.position_starmap_icon(data.raw.planet.vulcanus, 0.9)
data.raw.planet.vulcanus_lava_tubes.distance = starmap_icon_position.starmap_icon_distance
data.raw.planet.vulcanus_lava_tubes.orientation = starmap_icon_position.starmap_icon_orientation