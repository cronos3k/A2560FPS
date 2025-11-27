# WORKING DIRECTORY POLICY - READ THIS FIRST!

## PRIMARY WORKING DIRECTORY
**ALWAYS WORK IN**: `D:\DEV\Abuse_2025`

## NEVER USE THESE FOR DEVELOPMENT:
- `D:\AIDEV\Abuse_2025` - OLD/STALE CODE - DO NOT EDIT
- Any other copies

## BEFORE STARTING ANY WORK:
1. Verify you're in `D:\DEV\Abuse_2025`
2. Check git status: `git status`
3. Create a backup: `git stash` or `git commit`

## AFTER COMPLETING ANY FEATURE:
1. Test the build
2. Commit immediately: `git add . && git commit -m "description"`
3. NEVER let uncommitted work sit for more than 1 hour

## BUILD DIRECTORY:
- Source: `D:\DEV\Abuse_2025\src\`
- Build: `D:\DEV\Abuse_2025\msvc-build\`
- Install: `D:\DEV\Abuse_2025\msvc-install\`

## LAST WORK LOSS INCIDENT:
- Date: Nov 27, 2025
- Cause: Working in wrong directory (D:\AIDEV instead of D:\DEV)
- Lost: Wall jump implementation, input remapping
- Prevention: Always verify directory before editing

