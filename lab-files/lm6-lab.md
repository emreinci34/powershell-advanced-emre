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