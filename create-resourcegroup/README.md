# New-TestResourceGroup

## Purpose

`New-TestResourceGroup` is a reusable advanced PowerShell function that creates Azure resource groups in the Central US region. The function is included as the public command in the `NWTC.ResourceGroups` module.

It provides multiple naming methods, pipeline support, safety controls, validation, structured output, execution statistics, and timestamped module logging.

## Features

- Creates Azure resource groups in the `centralus` region.
- Provides `ResourceGroupName` and `ProjectID` parameter sets.
- Automatically converts a project ID into the `RG-<ProjectID>` format.
- Accepts multiple project IDs through the PowerShell pipeline.
- Supports `-WhatIf` and `-Confirm`.
- Validates resource group names and project IDs.
- Applies default or custom Azure tags.
- Uses `Begin`, `Process`, and `End` blocks.
- Returns one structured object for every processed resource group.
- Displays processed, created, skipped, and error counts.
- Uses the private `Write-ModuleLog` helper for timestamped logging.

## Parameters

### ResourceGroupName

Specifies the complete name of the Azure resource group. The value must contain between 1 and 90 characters.

```powershell
New-TestResourceGroup -ResourceGroupName "lm5-emre-production-rg"
```

### ProjectID

Specifies a numeric project ID between 1 and 999999. The function automatically formats the resource group name as `RG-<ProjectID>`.

```powershell
New-TestResourceGroup -ProjectID 2001
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

The `ProjectID` parameter accepts pipeline input. Multiple projects can be processed during one execution:

```powershell
"2001", "2002", "2003" | New-TestResourceGroup
```

The command creates:

- `RG-2001`
- `RG-2002`
- `RG-2003`

Project IDs can also be read from a text file:

```powershell
Get-Content .\ResourceGroups.txt |
    New-TestResourceGroup
```

## Custom Tags

```powershell
New-TestResourceGroup `
    -ProjectID 2004 `
    -Tags @{
        Department  = "Infrastructure"
        Environment = "Development"
    }
```

## Safe Testing

Use `-WhatIf` to preview an operation without creating the resource group:

```powershell
New-TestResourceGroup -ProjectID 2005 -WhatIf
```

Use `-Confirm` when interactive approval is required:

```powershell
New-TestResourceGroup -ProjectID 2005 -Confirm
```

Use `-Verbose` to display detailed runtime information:

```powershell
New-TestResourceGroup -ProjectID 2005 -Verbose
```

## Output

The function returns a `PSCustomObject` for each processed resource group. Each object contains:

- `ResourceGroupName`
- `Location`
- `Status`
- `Tags`
- `Timestamp`

At the end of execution, the function displays:

- Total records processed
- Resources created
- Errors encountered
- Resources skipped
- Log file location

## Logging

The function uses the private `Write-ModuleLog` helper. Timestamped log files are stored in the module's `Logs` folder with the following naming format:

```text
New-TestResourceGroup-Log-yyyyMMdd-HHmmss.txt
```

Logs include validation results, creation attempts, successful operations, skipped operations, errors, and final statistics.

## Requirements

- PowerShell 7.0 or later
- Az PowerShell module
- An authenticated Azure session
- Permission to create Azure resource groups

Connect to Azure before running the function:

```powershell
Connect-AzAccount
```

## Module Version

Current module version: `1.0.0`