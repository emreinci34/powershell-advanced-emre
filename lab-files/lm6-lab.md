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
## Task 4: Create a Changelog

I created `CHANGELOG.md` in the `NWTC.ResourceGroups/Docs` folder to document the module's release history.

The changelog records version `1.0.0` as the initial release. It documents the original `New-TestResourceGroup` function, parameter sets, pipeline support, execution statistics, safety controls, and module logging.

The changelog also records version `1.1.0`. This release adds the public `Get-ResourceGroupSummary` function, updates the module documentation and manifest, and improves module import and command testing.

Maintaining a changelog gives administrators a clear record of what was added or changed in each release.
## Task 5: Create Release Notes

I created `RELEASENOTES.md` in the `NWTC.ResourceGroups/Docs` folder to communicate the changes included in version `1.1.0`.

The release notes contain sections for new features, bug fixes, upgrade instructions, known issues, and compatibility. They explain the new `Get-ResourceGroupSummary` function and provide commands for removing the previous module, importing the updated manifest, verifying the installed version, and checking the exported commands.

The known issues section documents the requirements for the Az PowerShell module, an authenticated Azure connection, suitable Azure permissions, and network availability.

I also updated the `ReleaseNotes` value in the module manifest so that its metadata accurately describes version `1.1.0`.
## Task 6: Test the Upgrade

I removed the previously loaded module and imported the updated `NWTC.ResourceGroups.psd1` manifest with the `-Force` parameter.

I used `Get-Module NWTC.ResourceGroups` to verify the loaded module. The output confirmed that version `1.1.0` was imported from the expected module path.

I then used `Get-Command -Module NWTC.ResourceGroups` to verify the exported commands. Both `Get-ResourceGroupSummary` and `New-TestResourceGroup` were available and reported version `1.1.0`.

Finally, I ran `Get-ResourceGroupSummary` with verbose output. The function successfully retrieved the Azure resource groups and displayed their resource group names, locations, and tags. These results confirmed that the module upgrade and the new public function were working correctly.
## Task 7: Publish and Distribute

I prepared version `1.1.0` of the `NWTC.ResourceGroups` module for organizational deployment.

I updated the repository README, the public function README, and the module README. The documentation now describes both public functions, version `1.1.0`, import and verification commands, upgrade instructions, requirements, troubleshooting, and release information.

I created a `Releases` folder inside `NWTC.ResourceGroups`. I then packaged the complete module as:

`NWTC.ResourceGroups/Releases/NWTC.ResourceGroups1.1.0.zip`

The package contains the module manifest, script module, public and private functions, documentation, tests, and supporting folders. The completed archive can be distributed to administrators for installation and deployment.