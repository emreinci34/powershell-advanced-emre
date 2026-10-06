# LM6 Lab: Managing the Lifecycle of a PowerShell Module

## Task 1: Review Current Module Version

I reviewed the existing `NWTC.ResourceGroups.psd1` module manifest to establish a baseline before making any lifecycle changes.

### Current Module Information

- **Module Name:** `NWTC.ResourceGroups`
- **Current Version:** `1.0.0`
- **Author:** Emre Inci
- **Description:** Provides enterprise functions for creating and managing Azure test resource groups.
- **Exported Command:** `New-TestResourceGroup`

I used `Test-ModuleManifest` to validate the manifest and display its current metadata. The manifest was valid and confirmed that version `1.0.0` exports the `New-TestResourceGroup` function.

This baseline will make it possible to track the new features, documentation updates, and version changes introduced during LM6.
## Task 2: Add a New Feature

I created a new public function named `Get-ResourceGroupSummary` and stored it in the module's `Public` folder.

The function uses `Get-AzResourceGroup` to retrieve Azure resource groups from the current subscription. It returns a structured object containing:

- Resource group name
- Azure location
- Resource tags

I added `Get-ResourceGroupSummary` to the module manifest's `FunctionsToExport` list. After reimporting the module, `Get-Command -Module NWTC.ResourceGroups` displayed both `Get-ResourceGroupSummary` and `New-TestResourceGroup`.

I tested the new function with the `-Verbose` parameter. It successfully retrieved the resource groups and displayed their names, locations, and tags in a formatted table.
## Task 3: Update Module Version

I updated the `NWTC.ResourceGroups` module version from `1.0.0` to `1.1.0` in the module manifest.

This change qualifies as a minor version update because the module gained a new backward-compatible public function named `Get-ResourceGroupSummary`. The existing `New-TestResourceGroup` function remains available and its existing functionality was not removed or intentionally broken.

A patch version would normally be used only for backward-compatible bug fixes. A major version would be appropriate if the update introduced breaking changes that required users to modify their existing commands or automation.

I validated the updated manifest with `Test-ModuleManifest`. The output confirmed version `1.1.0` and showed both exported functions.