# Azure Resource Group PowerShell Function

## Project Purpose

This project contains a reusable advanced PowerShell function named `New-TestResourceGroup`. The function creates one or more Azure resource groups in the Central US region while providing validation, parameter sets, pipeline processing, safe execution controls, transcript logging, structured output, and execution statistics.

## Function Features

- Supports separate `ResourceGroupName` and `ProjectID` parameter sets.
- Automatically converts a project ID into the `RG-<ProjectID>` naming format.
- Accepts multiple project IDs through the PowerShell pipeline.
- Uses Begin, Process, and End blocks for efficient bulk processing.
- Validates resource group names and project IDs.
- Applies default or custom Azure resource tags.
- Supports `-WhatIf` and `-Confirm` through `SupportsShouldProcess`.
- Provides optional detailed progress information through `-Verbose`.
- Uses Try and Catch blocks for error handling.
- Records execution activity in timestamped transcript files.
- Returns a structured `PSCustomObject` for every processed resource.
- Reports the number of resources processed, created, skipped, and failed.

## Files Included

- `create-resourcegroup.ps1` – Contains the `New-TestResourceGroup` function.
- `create-resourcegroup.tests.ps1` – Contains automated Pester tests for the function.
- `README.md` – Documents the function, features, and usage.

The repository root also contains `ResourceGroups.txt`, which can provide multiple project IDs for bulk processing. Transcript files are stored in the repository's `output` folder.

## Requirements

- PowerShell 7
- Az PowerShell module
- An authenticated Azure session
- Permission to create Azure resource groups

## Usage

Load the function into the current PowerShell session:

```powershell
. .\create-resourcegroup\create-resourcegroup.ps1
```

Create a resource group using a complete name:

```powershell
New-TestResourceGroup -ResourceGroupName "lm4-emre-example-rg"
```

Create a resource group using a project ID:

```powershell
New-TestResourceGroup -ProjectID 2001
```

The command above creates a resource group named `RG-2001`.

Process multiple project IDs through the pipeline:

```powershell
"2001", "2002", "2003" | New-TestResourceGroup
```

Process project IDs stored in a text file:

```powershell
Get-Content .\ResourceGroups.txt | New-TestResourceGroup
```

Preview a bulk operation without changing Azure:

```powershell
Get-Content .\ResourceGroups.txt |
    New-TestResourceGroup -WhatIf
```

Display detailed runtime information:

```powershell
New-TestResourceGroup -ProjectID 2004 -Verbose
```

Use custom tags:

```powershell
New-TestResourceGroup -ProjectID 2005 -Tags @{
    Department  = "Development"
    Environment = "Production"
}
```

## Function Output

The function returns one structured object for every processed resource group. Each object contains:

- Resource group name
- Azure location
- Operation status
- Tags
- Timestamp

At the end of execution, the function displays a summary containing:

- Total records processed
- Resources created
- Errors encountered
- Resources skipped
- Transcript location

## Safety and Troubleshooting

Use `-WhatIf` to preview changes before creating resources. Use `-Confirm` when interactive approval is required. For additional troubleshooting details, use `-Verbose` and review the timestamped transcript in the `output` folder.