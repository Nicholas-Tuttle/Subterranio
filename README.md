# Subterranio
A Factorio mod for exploring subterranean lands

## Requirements
* Powershell - used in build script to extract json information
* 7-Zip Used to create zip files for the mod (local and portal compatible)

## Quickstart
- Build (PowerShell): .\make.py

## Useful docs
- Architecture: ARCHITECTURE.md — explains repository layout and module responsibilities.
- Development: DEVELOPMENT.md — developer commands, build targets, and VS Code tasks.
- TODOs: multiple TODO.md files exist at the repo root and in subfolders. See the Tasks section below for consolidation guidance.

## Repository layout (high level)
- subterranio-base/ — shared library: assets, utilities, common data.
- subterranio-nauvis/ — module for Nauvis content.
- subterranio-fulgora/ — module for Fulgora content.
- subterranio/ — wrapper module that pulls modules together, packaging and integration glue.

## Tasks
- Keep short, local actionable items in per-module TODO.md files.
- Keep cross-module roadmap and high-level tasks in the top-level TODO.md.
- Prefer GitHub issues for tracked work and PR-linked tasks.

## Credits
Subterranio would not be possible without the help of these amazing, fantastic, incredible open source projects.

* Geothermal powerplant graphics from [Hurricane](https://mods.factorio.com/user/Hurricane046)
