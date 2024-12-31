local invisible_spider_leg = table.deepcopy(data.raw["spider-leg"]["spidertron-leg-1"])
invisible_spider_leg.name = "invisible_spider_leg"
invisible_spider_leg.graphics_set = nil

local empty_equipment_grid = table.deepcopy(data.raw["equipment-grid"]["small-equipment-grid"])
empty_equipment_grid.name = "empty-equipment-grid"
empty_equipment_grid.height = 0
empty_equipment_grid.width = 0
empty_equipment_grid.locked = true

local unit = table.deepcopy(data.raw["spider-vehicle"]["spidertron"])
unit.name = "cliff-destroyer-robot"
unit.minable = {mining_time = 0.1, result = "cliff-destroyer-robot"}
unit.guns = {}
unit.torso_rotation_speed = 0.1
unit.torso_bob_speed = 0.05
unit.vehicle_automatic_targeting_parameters = {
    auto_target_without_gunner = false,
    auto_target_with_gunner = false
}
unit.spider_engine = {
    legs = {
        leg = "invisible_spider_leg",
        mount_position = {0,0},
        ground_position = {0,0},
        walking_group = 1
    }
}
unit.is_military_target = true
unit.allow_remote_driving = false
unit.allow_passengers = false
unit.chunk_exploration_radius = 1
unit.equipment_grid = "empty-equipment-grid"
unit.inventory_size = 4
unit.trash_inventory_size = 0
unit.graphics_set = {
    autopilot_destination_on_map_visualisation = nil,
    autopilot_destination_queue_on_map_visualisation = nil,
    autopilot_destination_queue_visualisation = nil,
    autopilot_destination_visualisation = nil,
    autopilot_destination_visualisation_render_layer = nil,
    autopilot_path_visualisation_line_width = 0,
    autopilot_path_visualisation_on_map_line_width = 0,
    animation = unit.graphics_set.animation,
    base_animation = unit.graphics_set.base_animation,
    base_render_layer = unit.graphics_set.base_render_layer,
    render_layer = unit.graphics_set.render_layer,
    shadow_animation = unit.graphics_set.shadow_animation,
    shadow_base_animation = unit.graphics_set.shadow_base_animation
}

local item = {
    type = "item",
    name = "cliff-destroyer-robot",
    stack_size = 10,
    hidden = false,
    icon = "__base__/graphics/icons/spidertron.png",
    icon_tintable = "__base__/graphics/icons/spidertron-tintable.png",
    icon_tintable_mask = "__base__/graphics/icons/spidertron-tintable-mask.png",
    place_result = "cliff-destroyer-robot"
}

local recipe = {
    type = "recipe",
    name = "cliff-destroyer-robot",
    enabled = true,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "flying-robot-frame", amount = 1},
        {type = "item", name = "processing-unit", amount = 2},
        {type = "item", name = "diamond-ore", amount = 4} -- TODO: Make this diamonds, not the ore
    },
    results = {{type = "item", name = "cliff-destroyer-robot", amount = 1}}
}

data:extend{invisible_spider_leg, empty_equipment_grid, unit, item, recipe}
