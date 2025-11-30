# Architecture overview

Purpose
- Describe how the repository is organized, how modules interact, and where to place code/assets.

Top-level modules
- subterranio-base
  - Role: shared library and common assets used by all modules.
  - Contents: utilities, common data formats, shared graphics/sounds, base recipes/mechanics.
  - Build notes: built first; its outputs are consumed by other modules.

- subterranio-nauvis
  - Role: module implementing Nauvis-specific features and content.
  - Depends on: subterranio-base.
  - Placement: keep Nauvis-specific assets and data inside this folder.

- subterranio-fulgora
  - Role: Fulgora module (underground/alternate content).
  - Depends on: subterranio-base.
  - Placement: fulgora-specific assets, presets, and TODOs live here.

- subterranio (wrapper)
  - Role: integration/wrapper module that pulls base + modules together.
  - Responsibilities: compose final packaging, integration glue, cross-module compatibility fixes.
  - Build notes: built after base and modules.

Build order
1. subterranio-base
2. subterranio-nauvis and subterranio-fulgora (order between them doesn't matter if they only depend on base)
3. subterranio (wrapper/integration)

Coding & layout conventions
- Keep module public API surface small; prefer shared utilities in base.
- Assets: place module-specific assets under the module folder; reuse base assets where appropriate.
- Presets/rooms/entities: keep their definitions inside the owning module to avoid cross-module coupling.

TODO and task placement
- Per-module TODO.md: short-term, implementation-level tasks (leave pointers to issues if long-lived).
- Top-level TODO.md: high-level roadmap and cross-module tasks.
- Use issues for tracked work; link issues from TODOs.

Extending the architecture
- New module: add a new subterranio-<name> folder, declare any dependency on subterranio-base, and update the wrapper module to include it.
- Shared changes: if a feature needs to be used by multiple modules, implement it in subterranio-base and keep backward-compatible APIs.

If you'd like, I can create these three files in the workspace and add a sample .vscode/tasks.json to call make.py.