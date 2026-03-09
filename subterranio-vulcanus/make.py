import os
import json
import shutil
import subprocess
from datetime import datetime

script_directory = os.path.dirname(os.path.abspath(__file__))
with open(os.path.join(script_directory, "source", "info.json"), 'r') as file:
    data = json.load(file)

name = data["name"]
version = data["version"]
full_name = f"{name}_{version}"

source_directory = os.path.join(script_directory, "source") 
build_directory = os.path.join(script_directory, "build")
if os.path.exists(build_directory):
    shutil.rmtree(build_directory)

mod_build_directory = os.path.join(build_directory, full_name)
shutil.copytree(source_directory, mod_build_directory)
os.chdir(build_directory)
programFiles = os.getenv("ProgramFiles")
sevenZipDir = os.path.join(programFiles, "7-Zip")
subprocess.run([f"{sevenZipDir}\\7z.exe", "a", "-tzip", f"{full_name}.zip", full_name])
os.chdir(script_directory)

mods_directory = os.path.join(os.getenv("APPDATA"), "Factorio", "mods")
output_mod_path = os.path.join(mods_directory, f"{full_name}.zip")
if os.path.exists(output_mod_path):
        os.remove(output_mod_path)
shutil.move(os.path.join(build_directory, f"{full_name}.zip"), mods_directory)
shutil.rmtree(build_directory)

print(f"Built {full_name} into {mods_directory} at {datetime.now()}")
