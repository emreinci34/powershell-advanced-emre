# PowerShell Advanced – Emre Inci

This repository contains my lab work and PowerShell automation projects for the PowerShell Advanced course at Northeast Wisconsin Technical College.

## Azure Resource Group Project

The main project is the `New-TestResourceGroup` advanced PowerShell function. It creates Azure resource groups in the Central US region using reusable, safe, and scalable automation practices.

The function supports:

- Resource group names or numeric project IDs
- Automatic `RG-<ProjectID>` naming
- Parameter sets
- Parameter validation
- Default and custom tags
- Pipeline and bulk processing
- Begin, Process, and End blocks
- `-WhatIf` and `-Confirm`
- Verbose and debug output
- Error handling
- Transcript logging
- Structured object output
- End-of-run execution statistics

## Repository Structure

### `create-resourcegroup`

Contains the main PowerShell project:

- `create-resourcegroup.ps1`
- `create-resourcegroup.tests.ps1`
- `README.md`

### `lab-files`

Contains documentation from each learning module:

- `lm1-lab.md`
- `lm2-lab.md`
- `lm3-lab.md`
- `lm4-lab.md`

### `output`

Contains timestamped transcript logs created during function execution.

### `ResourceGroups.txt`

Contains project IDs used to demonstrate bulk pipeline processing.

## Example Usage

Load the function:

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

Process multiple project IDs:

```powershell
"2001", "2002", "2003" | New-TestResourceGroup
```

Process values from a text file:

```powershell
Get-Content .\ResourceGroups.txt |
    New-TestResourceGroup
```

Preview an operation safely:

```powershell
Get-Content .\ResourceGroups.txt |
    New-TestResourceGroup -WhatIf
```

## Testing

The project includes Pester tests that verify the function’s parameter sets, automatic naming behavior, Azure location, and expected resource group configuration.

Run the tests with:

```powershell
Invoke-Pester .\create-resourcegroup\create-resourcegroup.tests.ps1
```

## Learning Outcome

This project demonstrates how advanced PowerShell functions can make cloud administration safer, more consistent, reusable, testable, and ready for future module development.