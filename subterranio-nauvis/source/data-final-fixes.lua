local starmap_icon_util = require("__subterranio-base__.utilities.starmap-icon")
local starmap_icon_position = starmap_icon_util.position_starmap_icon(data.raw.planet.nauvis, 0.65)
data.raw.planet.subterrain.distance = starmap_icon_position.starmap_icon_distance
data.raw.planet.subterrain.orientation = starmap_icon_position.starmap_icon_orientation