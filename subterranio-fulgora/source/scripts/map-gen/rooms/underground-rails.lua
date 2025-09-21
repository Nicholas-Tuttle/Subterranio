local consts = require("scripts.map-gen.map-gen-constants")
local blueprints = require("blueprints")

local function spawn_room(bounding_box, surface)
    local keys = {
        "rails_four_way_junction",
        "rails_straight_up_down",
        "rails_straight_left_right",
        "rails_curve_bottom_right",
        "rails_curve_bottom_left",
        "rails_curve_top_right",
        "rails_curve_top_left",
        "rails_three_way_junction_sides_bottom",
        "rails_three_way_junction_sides_top",
        "rails_three_way_junction_ends_right",
        "rails_three_way_junction_ends_left",
        "rails_dead_end_top",
        "rails_dead_end_right",
        "rails_dead_end_bottom",
        "rails_dead_end_left",
        "rails_station_top",
        "rails_station_right",
        "rails_station_bottom",
        "rails_station_left"
    }

    blueprints.generate(bounding_box, nil, surface, keys[math.random(#keys)], {
        ["concrete"] = "fulgoran-rock",
        ["refined-concrete"] = "fulgoran-sand",
        ["refined-hazard-concrete-right"] = "fulgoran-paving",
        ["refined-hazard-concrete-left"] = "fulgoran-paving"
    }, {
        ["stone-wall"] = "fulgoran-wall",
        ["gate"] = "fulgoran-gate",
        ["small-lamp"] = "fulgoran-lamp"
    })
end

local function generate_room()
    return {
        type = consts.room_types.VAULT,
        spawn_on_connection = true
    }
end

return {
    generate_room = generate_room,
    spawn_room = spawn_room
}
