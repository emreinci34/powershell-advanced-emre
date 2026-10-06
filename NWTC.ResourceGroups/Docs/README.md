# NWTC.ResourceGroups Module

## Overview

`NWTC.ResourceGroups` is a PowerShell module for creating and reporting on Azure resource groups in a consistent and reusable way.

- **Current Version:** `1.1.0`
- **Author:** Emre Inci
- **Company:** NWTC
- **Minimum PowerShell Version:** 7.0
- **Required Module:** Az PowerShell

## Version 1.1.0

Version `1.1.0` is a backward-compatible minor release. It adds the public `Get-ResourceGroupSummary` function while retaining the existing `New-TestResourceGroup` function.

## Public Functions

### New-TestResourceGroup

Creates one or more Azure resource groups in the Central US region.

Key capabilities:

- Complete resource group name or project ID parameter sets
- `RG-<ProjectID>` automatic naming
- Pipeline and bulk processing
- Default or custom tags
- `WhatIf` and `Confirm` safety controls
- Verbose and debug messages
- Structured output
- Execution statistics
- Timestamped module logging

Examples:

```powershell
New-TestResourceGroup `
    -ResourceGroupName "lm6-emre-example-rg"
```

```powershell
New-TestResourceGroup -ProjectID 2006
```

```powershell
"2006", "2007", "2008" |
    New-TestResourceGroup -WhatIf
```

### Get-ResourceGroupSummary

Retrieves Azure resource group information and returns structured objects containing:

- Resource group name
- Azure location
- Tags

Examples:

```powershell
Get-ResourceGroupSummary
```

```powershell
Get-ResourceGroupSummary -Verbose |
    Format-Table -AutoSize
```

## Private Function

### Write-ModuleLog

`Write-ModuleLog` is an internal helper function used by `New-TestResourceGroup` to create timestamped log entries.

The helper is loaded into module scope but is not exported to users.

## Module Structure

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

## Import the Module

From the repository root:

```powershell
Import-Module `
    .\NWTC.ResourceGroups\NWTC.ResourceGroups.psd1 `
    -Force
```

## Verify the Module

Verify the loaded version:

```powershell
Get-Module NWTC.ResourceGroups |
    Select-Object Name, Version, Path
```

Expected version:

```text
1.1.0
```

Display exported commands:

```powershell
Get-Command -Module NWTC.ResourceGroups
```

Expected public functions:

```text
Get-ResourceGroupSummary
New-TestResourceGroup
```

## Requirements

- PowerShell 7.0 or later
- Az PowerShell module
- An authenticated Azure session
- Azure permissions to view or create resource groups
- Network access to Azure

Connect to Azure if necessary:

```powershell
Connect-AzAccount
```

## Upgrade from Version 1.0.0

Remove the currently loaded module:

```powershell
Remove-Module NWTC.ResourceGroups `
    -ErrorAction SilentlyContinue
```

Import version `1.1.0`:

```powershell
Import-Module `
    .\NWTC.ResourceGroups\NWTC.ResourceGroups.psd1 `
    -Force
```

Verify the upgrade:

```powershell
Get-Module NWTC.ResourceGroups |
    Select-Object Name, Version
```

## Documentation

- `README.md` — Module installation, usage, and structure
- `CHANGELOG.md` — Version history
- `RELEASENOTES.md` — Version `1.1.0` changes, upgrade instructions, and known issues

## Logging and Troubleshooting

Timestamped resource group creation logs are stored in the `Logs` folder.

Use `-Verbose` to display additional execution information:

```powershell
New-TestResourceGroup -ProjectID 2006 -Verbose
```

```powershell
Get-ResourceGroupSummary -Verbose
```

Use `-WhatIf` before resource creation when a preview is required:

```powershell
New-TestResourceGroup -ProjectID 2006 -WhatIf
```

## Release Package

The module is distributed as:

```text
NWTC.ResourceGroups1.1.0.zip
```

Review `RELEASENOTES.md` and `CHANGELOG.md` before deploying the package.