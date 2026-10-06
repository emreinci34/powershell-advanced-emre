# NWTC.ResourceGroups Public Functions

## Purpose

The `NWTC.ResourceGroups` module provides public PowerShell functions for creating and reporting on Azure resource groups.

Current module version: `1.1.0`

## Public Functions

- `New-TestResourceGroup`
- `Get-ResourceGroupSummary`

# New-TestResourceGroup

## Purpose

`New-TestResourceGroup` is a reusable advanced PowerShell function that creates Azure resource groups in the Central US region.

It provides multiple naming methods, pipeline support, safety controls, validation, structured output, execution statistics, and timestamped module logging.

## Features

- Creates Azure resource groups in the `centralus` region.
- Provides `ResourceGroupName` and `ProjectID` parameter sets.
- Converts project IDs into the `RG-<ProjectID>` format.
- Accepts multiple project IDs through the pipeline.
- Supports `-WhatIf` and `-Confirm`.
- Supports `-Verbose` and `-Debug`.
- Validates resource group names and project IDs.
- Applies default or custom Azure tags.
- Uses `Begin`, `Process`, and `End` blocks.
- Returns structured objects.
- Reports processed, created, skipped, and failed resources.
- Uses the private `Write-ModuleLog` helper.

## Parameters

### ResourceGroupName

Specifies a complete Azure resource group name containing between 1 and 90 characters.

```powershell
New-TestResourceGroup `
    -ResourceGroupName "lm6-emre-example-rg"
```

### ProjectID

Specifies a numeric project ID between 1 and 999999. The function creates a name using the `RG-<ProjectID>` format.

```powershell
New-TestResourceGroup -ProjectID 2006
```

### Tags

Specifies Azure tags as a hashtable. The default tags are:

```powershell
@{
    Department  = "IT"
    Environment = "Test"
}
```

## Pipeline Usage

```powershell
"2006", "2007", "2008" |
    New-TestResourceGroup
```

Use a text file for bulk processing:

```powershell
Get-Content .\ResourceGroups.txt |
    New-TestResourceGroup
```

## Safe Testing

Preview creation without changing Azure:

```powershell
New-TestResourceGroup -ProjectID 2006 -WhatIf
```

Request interactive approval:

```powershell
New-TestResourceGroup -ProjectID 2006 -Confirm
```

Display detailed runtime information:

```powershell
New-TestResourceGroup -ProjectID 2006 -Verbose
```

## Output

The function returns one `PSCustomObject` for each resource group. Each object contains:

- `ResourceGroupName`
- `Location`
- `Status`
- `Tags`
- `Timestamp`

The function also displays final execution statistics and the log file location.

# Get-ResourceGroupSummary

## Purpose

`Get-ResourceGroupSummary` retrieves Azure resource groups from the current subscription and produces a structured summary.

## Features

- Retrieves Azure resource groups using `Get-AzResourceGroup`.
- Displays resource group name, location, and tags.
- Returns structured PowerShell objects.
- Supports the common `-Verbose` parameter.
- Includes error handling for failed Azure requests.

## Usage

Display all resource group summaries:

```powershell
Get-ResourceGroupSummary
```

Display detailed processing information:

```powershell
Get-ResourceGroupSummary -Verbose
```

Format the results as a table:

```powershell
Get-ResourceGroupSummary |
    Format-Table ResourceGroupName, Location, Tags -AutoSize
```

## Output

Each returned object contains:

- `ResourceGroupName`
- `Location`
- `Tags`

Resource groups without tags may display an empty tag value.

# Logging

`New-TestResourceGroup` uses the private `Write-ModuleLog` helper. Timestamped logs are stored in the module's `Logs` folder.

# Requirements

- PowerShell 7.0 or later
- Az PowerShell module
- An authenticated Azure session
- Permission to view or create Azure resource groups

Connect to Azure when necessary:

```powershell
Connect-AzAccount
```

# Import and Verification

Import the module:

```powershell
Import-Module `
    .\NWTC.ResourceGroups\NWTC.ResourceGroups.psd1 `
    -Force
```

Verify version `1.1.0`:

```powershell
Get-Module NWTC.ResourceGroups |
    Select-Object Name, Version, Path
```

Display public commands:

```powershell
Get-Command -Module NWTC.ResourceGroups
```

# Version 1.1.0 Changes

- Added `Get-ResourceGroupSummary`.
- Added resource group reporting for name, location, and tags.
- Updated documentation.
- Improved module testing.
- Added changelog and release notes.