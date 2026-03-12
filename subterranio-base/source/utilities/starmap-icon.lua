local function position_starmap_icon(parent_planet, subterranean_depth)
    -- Convert the parent planet's orientation and distance to Cartesian coordinates
    -- Orientation is 0 to 1 going clockwise. North is 0, East is 0.25, South is 0.5, West is 0.75
    local parent_orientation = parent_planet.orientation
    local parent_distance = parent_planet.distance
    local parent_orientation_radians = ((1.25 - parent_orientation) % 1) * 2 * math.pi
    local parent_x = math.cos(parent_orientation_radians) * parent_distance
    local parent_y = math.sin(parent_orientation_radians) * parent_distance
    log("Parent planet " .. parent_planet.name .. " orientation: " .. parent_orientation .. ", distance: " .. parent_distance)
    log("Parent planet " .. parent_planet.name .. " Cartesian coordinates: x=" .. parent_x .. ", y=" .. parent_y)

    -- Calculate the starmap icon's position by offsetting from the parent planet's position
    local subterrain_y = parent_y - (subterranean_depth * 2)
    log("Starmap icon " .. parent_planet.name .. " Cartesian coordinates: x=" .. parent_x .. ", y=" .. subterrain_y)
    -- Convert back to Factorio RealOrientation coordinates to get the starmap icon's orientation and distance
    local starmap_icon_distance = math.sqrt(parent_x^2 + subterrain_y^2)
    local starmap_icon_orientation_radians = math.atan(subterrain_y / parent_x)
    local starmap_icon_orientation = (1.25 - starmap_icon_orientation_radians / (2 * math.pi)) % 1
    log("Starmap icon " .. parent_planet.name .. " distance: " .. starmap_icon_distance)
    log("Starmap icon " .. parent_planet.name .. " orientation: " .. starmap_icon_orientation)
    return {
        starmap_icon_orientation = starmap_icon_orientation,
        starmap_icon_distance = starmap_icon_distance
    }
end

return {
    position_starmap_icon = position_starmap_icon
}