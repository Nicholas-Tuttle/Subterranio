import os
import subprocess

print("----- Building all mods at once")

mods = ["subterranio", "subterranio-base", "subterranio-nauvis"]

script_directory = os.path.dirname(os.path.abspath(__file__))
for mod in mods:
    print(f"--- Building {mod}")
    os.chdir(os.path.join(script_directory, mod))
    subprocess.run(["python", ".\make.py"])
    os.chdir(script_directory)
    print(f"--- Done building {mod}")
