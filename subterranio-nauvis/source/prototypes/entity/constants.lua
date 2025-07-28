local diamond_image_path = "__subterranio-base__/graphics/entity/diamond.png"
local diamond_image_size = 256

return {
    diamond_image_path = diamond_image_path,
    diamond_image_size = diamond_image_size,
    diamond_tint_color = {r= 0.5, g = 0.5, b = 1.0, a = 1.0},
    diamond_tint_icon_color = {r= 0.6, g = 0.6, b = 1.0, a = 1.0},
    diamond_tint_as_overlay = false,
    diamond_tech_overlay_icon = {icon = diamond_image_path, icon_size = diamond_image_size, scale = 0.15, shift = {26, 26}}
}
