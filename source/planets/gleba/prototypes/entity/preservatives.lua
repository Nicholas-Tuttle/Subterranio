local preservatives = table.deepcopy(data.raw["container"]["iron-chest"])
preservatives.name = "preservatives"

local item = {
    type = "item",
    name = "preservatives",
    stack_size = 1,
    icon = "__subterranio__/graphics/entity/refrigerator.png",
    icon_size = 512
}

data:extend{preservatives, item}
