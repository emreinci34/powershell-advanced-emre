# PowerShell Advanced – Emre Inci

This repository contains PowerShell projects and lab documentation created for the NWTC PowerShell Advanced course.

## Current Project

The primary project is the `NWTC.ResourceGroups` PowerShell module. The module provides reusable enterprise functions for creating and reporting on Azure resource groups.

- **Current Version:** `1.1.0`
- **Author:** Emre Inci
- **PowerShell Version:** PowerShell 7.0 or later
- **Required Module:** Az PowerShell
- **Repository:** https://github.com/emreinci34/powershell-advanced-emre

## Module Features

- Creates Azure resource groups using a complete name or project ID.
- Converts project IDs into the `RG-<ProjectID>` naming format.
- Accepts multiple project IDs through the pipeline.
- Supports `-WhatIf`, `-Confirm`, `-Verbose`, and `-Debug`.
- Applies default or custom Azure tags.
- Returns structured PowerShell objects.
- Tracks processed, created, skipped, and failed resources.
- Writes timestamped module logs.
- Reports Azure resource group names, locations, and tags.
- Includes a module manifest, changelog, release notes, and documentation.

## Public Functions

### New-TestResourceGroup

Creates one or more Azure resource groups in the Central US region.

```powershell
New-TestResourceGroup -ResourceGroupName "example-test-rg"
```

```powershell
New-TestResourceGroup -ProjectID 2001
```

```powershell
"2001", "2002", "2003" |
    New-TestResourceGroup -WhatIf
```

### Get-ResourceGroupSummary

Displays resource group names, Azure locations, and tags for the current subscription.

```powershell
Get-ResourceGroupSummary
```

```powershell
Get-ResourceGroupSummary -Verbose |
    Format-Table -AutoSize
```

## Import the Module

Import the module from the repository root:

```powershell
Import-Module .\NWTC.ResourceGroups\NWTC.ResourceGroups.psd1 -Force
```

Verify the installed version:

```powershell
Get-Module NWTC.ResourceGroups |
    Select-Object Name, Version, Path
```

Display exported commands:

```powershell
Get-Command -Module NWTC.ResourceGroups
```

## Repository Structure

```text
NWTC.ResourceGroups/
├── Docs/
│   ├── CHANGELOG.md
│   ├── README.md
│   └── RELEASENOTES.md
├── Logs/
├── Private/
│   └── Write-ModuleLog.ps1
├── Public/
│   ├── Get-ResourceGroupSummary.ps1
│   └── New-TestResourceGroup.ps1
├── Releases/
├── Tests/
├── NWTC.ResourceGroups.psd1
└── NWTC.ResourceGroups.psm1
```

Additional lab documentation is stored in the `lab-files` folder.

## Version History

### Version 1.1.0

- Added `Get-ResourceGroupSummary`.
- Updated the module manifest and documentation.
- Improved import, version, command, and functionality testing.
- Added a changelog and detailed release notes.
- Prepared the module for packaged distribution.

### Version 1.0.0

- Initial release of the `NWTC.ResourceGroups` module.
- Added `New-TestResourceGroup`.
- Added parameter sets, pipeline processing, safety controls, structured output, statistics, and logging.

## Documentation

Detailed module documentation is available in:

- `NWTC.ResourceGroups/Docs/README.md`
- `NWTC.ResourceGroups/Docs/CHANGELOG.md`
- `NWTC.ResourceGroups/Docs/RELEASENOTES.md`
- `lab-files/lm6-lab.md`

## Safety

Use `-WhatIf` to preview resource creation before making Azure changes:

```powershell
New-TestResourceGroup -ProjectID 2006 -WhatIf
```

Use `-Verbose` for additional runtime information. Review timestamped files in the module's `Logs` folder when troubleshooting.

## Author

Emre Inci
NWTC PowerShell Advanced
