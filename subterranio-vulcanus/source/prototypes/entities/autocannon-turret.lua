local constants = require("scripts.constants")

local entity = table.deepcopy(data.raw["ammo-turret"]["gun-turret"])
entity.name = "autocannon-turret"
entity.icons = { { icon = entity.icon, tint = constants.vulcanus_lava_tubes_tint } }
entity.icon = nil
entity.minable.result = "autocannon-turret"
entity.max_health = 2000
entity.rotation_speed = 0.005
entity.preparing_speed = 0.02
entity.attacking_speed = 0.1

local item = {

}

local recipe = {

}

local technology = {
    type = "technology",
    name = "autocannon-turret",
    icons = { { icon = entity.icons[1].icon, tint = constants.vulcanus_lava_tubes_tint } },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "autocannon-turret"
        },
    },
    prerequisites = { "titanium-cutting" },
    unit =
    {
        count = 2000,
        ingredients = {
            { "automation-science-pack",  1 },
            { "logistic-science-pack",    1 },
            { "military-science-pack",    1 },
            { "chemical-science-pack",    1 },
            { "space-science-pack",       1 },
            { "metallurgic-science-pack", 1 },
            { "propulsion-science-pack",  1 },
        },
        time = 60
    }
}

data:extend({ entity, item, recipe, technology })
