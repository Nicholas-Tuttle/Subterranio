import os
import argparse
import json
from pathlib import Path
from PIL import Image


def best_grid(image_count):
    best = None
    best_score = float("inf")

    for cols in range(1, image_count):
        if image_count % cols != 0:
            continue
        rows = image_count // cols
        score = abs(1 - (cols / rows))
        if score < best_score:
            best_score = score
            best = (cols, rows)

    if best is None:
        return image_count, 1

    return best

def create_texture_atlas(image_folder, output_path):
    absolute_directory_path = os.path.join(os.getcwd(), Path(image_folder))
    print(f"Finding images at {absolute_directory_path}")
    image_files = sorted(Path(absolute_directory_path).glob("*.png"))
    print(f"Combining images:")
    for image in image_files:
        print(f"  {image.name}")

    if not image_files:
        print("No images found, skipping")
        return

    # Load all images
    images = [Image.open(path).convert("RGBA") for path in image_files]

    # Verify all images are the same size
    tile_width, tile_height = images[0].size

    for img in images:
        if img.size != (tile_width, tile_height):
            print("All images must be the same size!")
            print(f"Expected {(tile_width, tile_height)}, got {img.size} for image {img}")

    num_images = len(images)
    cols, rows = best_grid(num_images)
    atlas_width = cols * tile_width
    atlas_height = rows * tile_height
    print(f"Creating atlas: {cols} columns x {rows} rows. Atlas size: {atlas_width} x {atlas_height}")
    atlas = Image.new("RGBA", (atlas_width, atlas_height))

    # Paste images in order, left-to-right, top-to-bottom
    for index, img in enumerate(images):
        col = index % cols
        row = index // cols

        x = col * tile_width
        y = row * tile_height

        atlas.paste(img, (x, y))

    atlas.save(output_path)
    print(f"Saved images to sprite sheet: {output_path}")

    return (len(images), rows, cols, atlas_width, atlas_height, tile_width, tile_height)

def create_lua_info_file(
        output_lua_info_path, 
        atlas_image_count, 
        lines_per_file, 
        line_length, 
        atlas_width, 
        atlas_height,
        tile_width, 
        tile_height
    ):
    with open(output_lua_info_path, "w") as lua_file:
        lua_file.write(f"""return {{
    frame_count = {atlas_image_count},
    lines_per_file = {lines_per_file},
    line_length = {line_length},
    image_width = {atlas_width},
    image_height = {atlas_height},
    tile_width = {tile_width},
    tile_height = {tile_height}
}}
""")
        print(f"Created Lua file info at location {os.path.abspath(output_lua_info_path)}")

def main(images_folder, output_image_name, output_lua_info_path):
    ## TODO: Add commands to make Blender render the output images. If possible, define the output folder in this script
    (atlas_image_count, lines_per_file, line_length, atlas_width, atlas_height, tile_width, tile_height) = create_texture_atlas(images_folder, output_image_name)
    ## TODO: take the information (file name, width, height, image count) from the texture atlas and make a lua file with constants that can be used in other files for easy importing of the sprite sheet
    create_lua_info_file(output_lua_info_path, atlas_image_count, lines_per_file, line_length, atlas_width, atlas_height, tile_width, tile_height)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog="Sprite Atlas Creator",
        description="Takes in a folder and combines all png's in that folder into a single texture sheet"
    )
    parser.add_argument("build_json_path", help="The build.json file path for these textures")
    args = parser.parse_args()

    absolute_json_path = os.path.join(os.getcwd(), Path(args.build_json_path))
    if not os.path.exists(absolute_json_path):
        print("Could not find build json path, exiting")

    with open(absolute_json_path) as json_file:
        json_info = json.load(json_file)
        json_folder = Path(absolute_json_path).parent
        images_folder = os.path.join(json_folder, json_info["images_folder"])
        output_image_path = os.path.join(json_folder, json_info["output_image_name"])
        output_lua_info_path = os.path.join(json_folder, json_info["output_lua_info_path"])
        main(images_folder, output_image_path, output_lua_info_path)