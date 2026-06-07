import json
import os
import sys
import requests
import argparse

def combine_submod_descriptions():
    submods = ["subterranio-nauvis", "subterranio-fulgora", "subterranio-vulcanus", "subterranio-gleba", "subterranio-base"]
    combinedSubmodDescriptions = ""
    for submod in submods:
        submodInfoJson = os.path.join(os.path.dirname(os.path.realpath(__file__)), submod, "source", "info.json")
        submodJsonData = json.load(open(submodInfoJson, "r"))
        title = submodJsonData.get("title", None)
        submodDescriptionTitle = f"# {title.upper()}\n\n"
        submodDescriptionMarkdown = os.path.join(os.path.dirname(os.path.realpath(__file__)), submod, "source", "README.md")
        if os.path.exists(submodDescriptionMarkdown):
            combinedSubmodDescriptions += f"\n\n---\n\n"
            combinedSubmodDescriptions += submodDescriptionTitle
            combinedSubmodDescriptions += open(submodDescriptionMarkdown, "r").read()
    return combinedSubmodDescriptions

def main(modname, apikeyFilePath):
    MOD_PORTAL_URL = "https://mods.factorio.com"
    UPDATE_MOD_URL = f"{MOD_PORTAL_URL}/api/v2/mods/edit_details"

    if not os.path.exists(apikeyFilePath):
        print(f"API key file does not exist at {apikeyFilePath}")
        sys.exit(1)
    apikey = open(apikeyFilePath, "r").read().strip() 
    
    infoJson = os.path.join(os.path.dirname(os.path.realpath(__file__)), modname, "source", "info.json")
    if not os.path.exists(infoJson):
        print(f"Mod {modname} does not exist in the source directory.")
        sys.exit(1)
    jsonData = json.load(open(infoJson, "r"))
    title = jsonData.get("title", None)

    if not title:
        print(f"Mod {modname} does not have a title specified in info.json.")
        sys.exit(1)

    print(f"Updating mod {modname} details...")

    body = {
        "mod": modname,
        "title": title,
        "summary": jsonData.get("description", ""),
        "category": "content", #https://wiki.factorio.com/Mod_details_API#Category
        "tags": [
            "combat",
            "enemies",
            "environment",
            "mining",
            "fluids",
            "manufacturing",
            "power"
        ], #https://wiki.factorio.com/Mod_details_API#Tags
        "license": "default_mit", #https://wiki.factorio.com/Mod_details_API#License
        "homepage": "https://github.com/Nicholas-Tuttle/Subterranio",
        "source_url": "https://github.com/Nicholas-Tuttle/Subterranio"
    }

    descriptionMarkdown = os.path.join(os.path.dirname(os.path.realpath(__file__)), modname, "source", "README.md")
    if os.path.exists(descriptionMarkdown):
        descriptionTitle = f"# {title.upper()}\n\n"
        descriptionDiscord = "[![Discord](https://img.shields.io/badge/Discord-%235865F2.svg?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/UsAw48hP)\n\n"
        descriptionPleaseSeeMainMod = ""
        descriptionSubMods = ""
        if modname != "subterranio": 
            descriptionPleaseSeeMainMod = f"#### Please see the [Subterranio](https://mods.factorio.com/mod/subterranio) mod for more information. "
            descriptionPleaseSeeMainMod += f"This mod only implements the logic for {title}, and works best when including the other Subterranio mods.\n\n"
        else:
            descriptionSubMods = combine_submod_descriptions()
        body["description"] = descriptionTitle + descriptionDiscord + descriptionPleaseSeeMainMod + open(descriptionMarkdown, "r").read() + descriptionSubMods

    faqMarkdown = os.path.join(os.path.dirname(os.path.realpath(__file__)), modname, "source", "FAQ.md")
    if os.path.exists(faqMarkdown):
        body["faq"] = open(faqMarkdown, "r").read()

    request_headers = {"Authorization": f"Bearer {apikey}"}

    print(f"Updating mod {modname} details with request body: {body} and headers: {request_headers}")
    response = requests.post(
    	UPDATE_MOD_URL,
    	data=body,
    	headers=request_headers)

    if not response.ok:	
        print(f"Update mod details failed: {response.text}")
        sys.exit(1)
    else:
        print(f"Update mod details succeeded: {response.text}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Upload a Factorio mod to the mod portal.")
    parser.add_argument("apikeyFilePath", type=str, help="The API key file path for authentication.")
    parser.add_argument("modname", type=str, help="The name of the mod to upload.")
    args = parser.parse_args()

    main(args.modname, args.apikeyFilePath)