# NWTC.ResourceGroups Version 1.1.0 Release Notes

## Overview

Version `1.1.0` is a backward-compatible minor release of the `NWTC.ResourceGroups` PowerShell module. This release adds resource group reporting and improves documentation and testing.

## New Features

- Added the public `Get-ResourceGroupSummary` function.
- Added structured output containing resource group name, location, and tags.
- Added verbose messages for resource group summary operations.
- Added `Get-ResourceGroupSummary` to the module manifest's exported functions.
- Added a changelog to document module history.

## Bug Fixes

- No specific functional defects were identified in version `1.0.0`.
- Module import and exported-command validation were improved during testing.
- Documentation was updated to better describe the module's current functionality.

## Upgrade Instructions

1. Download or copy the updated `NWTC.ResourceGroups` module folder.
2. Replace the previous module files with the version `1.1.0` files.
3. Remove the currently loaded version:

   ```powershell
   Remove-Module NWTC.ResourceGroups -ErrorAction SilentlyContinue