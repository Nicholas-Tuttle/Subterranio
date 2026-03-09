import json
import os
import sys
import requests
import argparse

def main(modname, apikeyFilePath):
    MOD_PORTAL_URL = "https://mods.factorio.com"
    INIT_UPLOAD_URL = f"{MOD_PORTAL_URL}/api/v2/mods/releases/init_upload"

    if not os.path.exists(apikeyFilePath):
        print(f"API key file does not exist at {apikeyFilePath}")
        sys.exit(1)
    apikey = open(apikeyFilePath, "r").read().strip() 
    
    infoJson = os.path.join(os.path.dirname(os.path.realpath(__file__)), modname, "source", "info.json")
    if not os.path.exists(infoJson):
        print(f"Mod {modname} does not exist in the source directory.")
        sys.exit(1)
    jsonData = json.load(open(infoJson, "r"))
    version = jsonData.get("version", None)

    if not version:
        print(f"Mod {modname} does not have a version specified in info.json.")
        sys.exit(1)

    print(f"Preparing to upload mod {modname} version {version}...")
    print(f"Is version {version} correct? (Y/N)")

    user_input = input().strip().lower()
    if user_input != "y":
        print("Upload cancelled.")
        sys.exit(0)

    zipfilepath = os.path.join(os.getenv("APPDATA"), "Factorio", "mods", f"{modname}_{version}.zip")
    if not os.path.exists(zipfilepath):
        print(f"Zip file does not exist at {zipfilepath}")
        sys.exit(1)

    request_body = data={"mod":modname}
    request_headers = {"Authorization": f"Bearer {apikey}"}

    print(f"Initiating upload for mod {modname} version {version}")
    print(f"Using zip file at {zipfilepath}")
    response = requests.post(
    	INIT_UPLOAD_URL,
    	data=request_body,
    	headers=request_headers)

    if not response.ok:	
        print(f"init_upload failed: {response.text}")
        sys.exit(1)

    upload_url = response.json()["upload_url"]
    print(f"Upload URL received: {upload_url}")

    with open(zipfilepath, "rb") as f:	
        request_body = {"file": f}	
        response = requests.post(upload_url, files=request_body)

    if not response.ok:	
        print(f"upload failed: {response.text}")	
        sys.exit(1)
    print(f"upload successful: {response.text}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Upload a Factorio mod to the mod portal.")
    parser.add_argument("apikeyFilePath", type=str, help="The API key file path for authentication.")
    parser.add_argument("modname", type=str, help="The name of the mod to upload.")
    args = parser.parse_args()

    main(args.modname, args.apikeyFilePath)

