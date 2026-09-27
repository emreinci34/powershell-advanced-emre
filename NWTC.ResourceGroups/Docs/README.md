# NWTC.ResourceGroups Module

## Module Purpose

`NWTC.ResourceGroups` is a PowerShell script module designed to provide consistent and safe Azure resource group creation. The module currently exports the `New-TestResourceGroup` function and uses the private `Write-ModuleLog` helper for internal logging.

The module separates user-facing commands from internal functionality, supports bulk administration, and provides structured results and execution statistics.

## Features

- Creates Azure resource groups in the Central US region.
- Supports `ResourceGroupName` and `ProjectID` parameter sets.
- Converts project IDs into the `RG-<ProjectID>` naming format.
- Accepts multiple project IDs through the PowerShell pipeline.
- Uses `Begin`, `Process`, and `End` blocks.
- Validates resource group names and project IDs.
- Applies default or custom tags.
- Supports `-WhatIf`, `-Confirm`, and `-Verbose`.
- Returns structured `PSCustomObject` results.
- Tracks processed, created, skipped, and error counts.
- Stores timestamped execution logs.
- Keeps internal helper functions private.
- Exports only approved public functions.

## Module Structure

```text
NWTC.ResourceGroups
│
├── Docs
│   └── README.md
├── Logs
├── Private
│   └── Write-ModuleLog.ps1
├── Public
│   └── New-TestResourceGroup.ps1
├── Tests
├── NWTC.ResourceGroups.psd1
└── NWTC.ResourceGroups.psm1
```

## Requirements

- PowerShell 7.0 or later
- Az PowerShell module
- An authenticated Azure session
- Permission to create Azure resource groups

Install the Az module if necessary:

```powershell
Install-Module Az
```

Connect to Azure:

```powershell
Connect-AzAccount
```

## Installation Instructions

Clone the repository:

```powershell
git clone https://github.com/emreinci34/powershell-advanced-emre.git
```

Change to the repository directory:

```powershell
Set-Location .\powershell-advanced-emre
```

Import the module through its manifest:

```powershell
Import-Module `
    .\NWTC.ResourceGroups\NWTC.ResourceGroups.psd1 `
    -Force
```

Verify the module:

```powershell
Test-ModuleManifest `
    .\NWTC.ResourceGroups\NWTC.ResourceGroups.psd1
```

View the public commands:

```powershell
Get-Command -Module NWTC.ResourceGroups
```

## Usage Examples

### Create a Resource Group by Name

```powershell
New-TestResourceGroup `
    -ResourceGroupName "lm5-emre-production-rg"
```

### Create a Resource Group by Project ID

```powershell
New-TestResourceGroup -ProjectID 2001
```

This creates a resource group named `RG-2001`.

### Process Multiple Project IDs

```powershell
"2001", "2002", "2003" |
    New-TestResourceGroup
```

### Preview an Operation

```powershell
New-TestResourceGroup `
    -ProjectID 2004 `
    -WhatIf
```

### Request Confirmation

```powershell
New-TestResourceGroup `
    -ProjectID 2004 `
    -Confirm
```

### Use Custom Tags

```powershell
New-TestResourceGroup `
    -ProjectID 2005 `
    -Tags @{
        Department  = "Infrastructure"
        Environment = "Production"
    }
```

### Display Verbose Information

```powershell
New-TestResourceGroup `
    -ProjectID 2006 `
    -Verbose
```

## Output

The module returns one structured object for each processed resource group. Each object includes:

- Resource group name
- Azure location
- Operation status
- Tags
- Timestamp

The module also displays an end-of-run summary containing:

- Total records processed
- Resources created
- Errors encountered
- Resources skipped
- Log file location

## Logging

The private `Write-ModuleLog` function stores logs in the module's `Logs` folder.

Log file naming format:

```text
New-TestResourceGroup-Log-yyyyMMdd-HHmmss.txt
```

Log entries include timestamps, severity levels, validation results, creation attempts, successful operations, skipped operations, errors, and execution statistics.

## Version Information

- Module name: `NWTC.ResourceGroups`
- Current version: `1.0.0`
- PowerShell requirement: `7.0` or later
- Author: Emre Inci
- Repository: `https://github.com/emreinci34/powershell-advanced-emre`