# Development Guide

Prerequisites
- Python 3.8+ (used by make.py)
- Git

Common commands
- Build everything
  - .\make.py in top directory
- Build a single module (example)
  - .\make.py in module directory

Typical workflow
1. Create a feature branch off main/dev.
2. Run the build and tests locally: .\make.py build && .\make.py test
3. Add unit tests for new logic.
4. Open PR with description and link to related TODO/issue.

Where to add tasks and code
- Implementation and module-specific TODOs: each module's TODO.md and source folders.
- High-level roadmap: top-level TODO.md.
