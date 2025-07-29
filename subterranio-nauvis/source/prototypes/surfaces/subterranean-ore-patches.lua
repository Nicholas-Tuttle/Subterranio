local constants = require("constants")
require("prototypes.surfaces.impassable-cliff-walls-noise-expressions")

local function create_subterranean_ore(name, autoplace_richness_multiplier, min_patch_size, max_patch_size, seed)
    local autoplace_control_name = "subterranean-" .. name .. "-autoplace-control"
    local surface_material_autoplace_control = data.raw["autoplace-control"][name]

    -- local autoplace_frequency_setting_name = "var(control:" .. autoplace_control_name .. ":frequency)"
    local autoplace_size_setting_name = "var(\"control:" .. autoplace_control_name .. ":size\")"
    local autoplace_richness_setting_name = "var(\"control:" .. autoplace_control_name .. ":richness\")"

    local resource = table.deepcopy(data.raw["resource"][name])
    resource.name = "subterranean-" .. resource.name
    resource.localised_name = {"", "[entity=" .. name .. "]", {"entity-name." .. name}}
    resource.autoplace = {
        probability_expression = "subterranean_" .. string.gsub(name, "-", "_") .. "_noise_expression(x, y)",
        richness_expression = autoplace_richness_multiplier .. " * (sqrt(x * x + y * y) + 2) * " .. autoplace_richness_setting_name,
        has_starting_area_placement = false,
        control = autoplace_control_name,
        order = "a-g-" .. resource.order
    }
    resource.hidden_in_factoriopedia = true
    resource.order = "a-g-" .. resource.order

    data:extend{
        resource,
        {
            type = "autoplace-control",
            name = autoplace_control_name,
            localised_name = {"", "[entity=" .. name .. "]", {"entity-name." .. name}},
            richness = true,
            order = "a-g-" .. surface_material_autoplace_control.order,
            category = "resource"
        },
        {
            type = "noise-function",
            name = "subterranean_" .. string.gsub(name, "-", "_") .. "_noise_expression",
            expression = [[
                subterranean_impassable_cliffs_caverns_spot_noise(x, y, seed, min_patch_size * autoplace_size_setting, max_patch_size * autoplace_size_setting)
            ]],
            local_expressions = {
                autoplace_size_setting = autoplace_size_setting_name,
                min_patch_size = min_patch_size,
                max_patch_size = max_patch_size,
                seed = seed
            },
            parameters = {"x", "y"}
        }
    }
end

create_subterranean_ore("coal", 7, constants.coal_ore_min_patch_size, constants.coal_ore_max_patch_size, constants.coal_ore_patch_seed)
create_subterranean_ore("stone", 10, constants.stone_ore_min_patch_size, constants.stone_ore_max_patch_size, constants.stone_ore_patch_seed)
create_subterranean_ore("iron-ore", 5, constants.iron_ore_min_patch_size, constants.iron_ore_max_patch_size, constants.iron_ore_patch_seed)
create_subterranean_ore("copper-ore", 5, constants.copper_ore_min_patch_size, constants.copper_ore_max_patch_size, constants.copper_ore_patch_seed)
create_subterranean_ore("uranium-ore", 5, constants.uranium_ore_min_patch_size, constants.uranium_ore_max_patch_size, constants.uranium_ore_patch_seed)
