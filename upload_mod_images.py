import json
import os
import sys
import requests
import argparse

def main(modname, apikeyFilePath):
    MOD_PORTAL_URL = "https://mods.factorio.com"
    ADD_IMAGE_URL = f"{MOD_PORTAL_URL}/api/v2/mods/images/add"
    EDIT_IMAGE_URL = f"{MOD_PORTAL_URL}/api/v2/mods/images/edit"

    if not os.path.exists(apikeyFilePath):
        print(f"API key file does not exist at {apikeyFilePath}")
        sys.exit(1)
    apikey = open(apikeyFilePath, "r").read().strip()
    request_headers = {"Authorization": f"Bearer {apikey}"}

    modImagesDirectory = os.path.join(os.path.dirname(os.path.realpath(__file__)), modname, "source", "images")
    if not os.path.exists(modImagesDirectory):
        print(f"Mod {modname} does not have an images directory.")
        sys.exit(1)

    currentImageStateJson = os.path.join(os.path.dirname(os.path.realpath(__file__)), modname, "source", "images", "state.json")
    currentImageStateData = {}
    if not os.path.exists(currentImageStateJson):
        print(f"Mod {modname} does not have images currently tracked.")
    else:
        currentImageStateData = json.load(open(currentImageStateJson, "r"))

    modImages = [f for f in os.listdir(modImagesDirectory) if os.path.isfile(os.path.join(modImagesDirectory, f)) and f.endswith(".png")]
    modImages.sort()
    for image in modImages:
        if currentImageStateData and currentImageStateData.get(image, None) != None:
            print(f"Image {image} is already uploaded, skipping.")
            continue

        print(f"Uploading image {image}...")

        response = requests.post(
            ADD_IMAGE_URL,
            data={"mod": modname},
            headers=request_headers)
        
        if not response.ok:	
            print(f"Failed to get URL to upload image: {response.text}")
            sys.exit(1)

        upload_url = response.json()["upload_url"]

        with open(os.path.join(modImagesDirectory, image), "rb") as f:
            request_body = {"image": f}
            response = requests.post(upload_url, files=request_body)

        if not response.ok:
            print(f"Upload failed: {response.text}")
            sys.exit(1)

        print(f"Upload successful: {response.text}")

        uploadedImageId = response.json()["id"]
        uploadedImageUrl = response.json()["url"]
        uploadedImageThumbnailUrl = response.json()["thumbnail"]

        currentImageStateData[image] = {
            "id": uploadedImageId,
            "url": uploadedImageUrl,
            "thumbnail_url": uploadedImageThumbnailUrl
        }

    with open(currentImageStateJson, "w") as f:
        json.dump(currentImageStateData, f, indent=4)

    response = requests.post(
        EDIT_IMAGE_URL,
        data={"mod": modname, "images": ",".join([image["id"] for image in currentImageStateData.values()])},
        headers=request_headers
    )

    if not response.ok:
        print(f"Failed to set mod images: {response.text}")
        sys.exit(1)

    print(f"Set mod images successful: {response.text}")
        
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Upload mod images to the Factorio mod portal.")
    parser.add_argument("apikeyFilePath", help="The file path to the API key for authentication.")
    parser.add_argument("modname", help="The name of the mod to upload images for.")
    args = parser.parse_args()
    main(args.modname, args.apikeyFilePath)