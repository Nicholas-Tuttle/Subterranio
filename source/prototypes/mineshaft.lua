local mineshaft = table.deepcopy(data.raw["container"]["iron-chest"])
mineshaft.name = "mineshaft"
mineshaft.icons = {
    {
        icon = mineshaft.icon,
        icon_size = mineshaft.icon_size,
        tint = {r=1,g=0,b=0,a=0.3}
    },
}

local mineshaft_item = {
    type = "item",
    name = "mineshaft",
    stack_size = 1,
    icon = mineshaft.icon
}

local recipe = {
    type = "recipe",
    name = "mineshaft",
    enabled = true,
    energy_requirements = 1,
    ingredients = {
        {type = "item", name = "iron-plate", amount = 1}
    },
    results = {{type = "item", name = "mineshaft", amount = 1}}
}

data:extend{mineshaft, mineshaft_item, recipe}