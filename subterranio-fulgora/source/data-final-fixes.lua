local starmap_icon_util = require("__subterranio-base__.utilities.starmap-icon")
local starmap_icon_position = starmap_icon_util.position_starmap_icon(data.raw.planet.fulgora, 0.6)
data.raw.planet.fulgoran_subway.distance = starmap_icon_position.starmap_icon_distance
data.raw.planet.fulgoran_subway.orientation = starmap_icon_position.starmap_icon_orientation
