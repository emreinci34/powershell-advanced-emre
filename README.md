# PowerShell Advanced – Emre Inci

## Repository Purpose

This repository contains my work for the NWTC PowerShell Advanced course. It documents the development of a reusable Azure resource group function and its conversion into a structured PowerShell script module.

The current module is named `NWTC.ResourceGroups` and provides the public `New-TestResourceGroup` command.

## Module Features

- Standard PowerShell module structure
- Public and private function separation
- Module manifest with version information
- Explicit public function exports
- Resource group name and project ID parameter sets
- Pipeline and multiple-value processing
- `Begin`, `Process`, and `End` blocks
- Parameter validation
- Default and custom Azure tags
- `-WhatIf`, `-Confirm`, and `-Verbose` support
- Structured PowerShell output
- Execution statistics
- Private timestamped logging
- Module testing and documentation

## Repository Structure

```text
powershell-advanced-emre
│
├── NWTC.ResourceGroups
│   ├── Docs
│   ├── Logs
│   ├── Private
│   │   └── Write-ModuleLog.ps1
│   ├── Public
│   │   └── New-TestResourceGroup.ps1
│   ├── Tests
│   ├── NWTC.ResourceGroups.psd1
│   └── NWTC.ResourceGroups.psm1
│
├── create-resourcegroup
│   ├── create-resourcegroup.ps1
│   ├── create-resourcegroup.tests.ps1
│   └── README.md
│
├── lab-files
│   ├── lm1-lab.md
│   ├── lm2-lab.md
│   ├── lm3-lab.md
│   ├── lm4-lab.md
│   └── lm5-lab.md
│
├── output
├── ResourceGroups.txt
└── README.md
```

## Module Installation

Clone the repository:

```powershell
git clone https://github.com/emreinci34/powershell-advanced-emre.git
```

Move into the repository:

```powershell
Set-Location .\powershell-advanced-emre
```

Import the module through its manifest:

```powershell
Import-Module .\NWTC.ResourceGroups\NWTC.ResourceGroups.psd1 -Force
```

Verify the exported command:

```powershell
Get-Command -Module NWTC.ResourceGroups
```

## Requirements

- PowerShell 7.0 or later
- Git
- Az PowerShell module
- An active Azure account
- Permission to create Azure resource groups

Authenticate to Azure:

```powershell
Connect-AzAccount
```

## Usage Examples

Create a resource group with a complete name:

```powershell
New-TestResourceGroup `
    -ResourceGroupName "lm5-emre-example-rg"
```

Create a resource group from a project ID:

```powershell
New-TestResourceGroup -ProjectID 2001
```

Process multiple project IDs through the pipeline:

```powershell
"2001", "2002", "2003" |
    New-TestResourceGroup
```

Preview an operation safely:

```powershell
New-TestResourceGroup -ProjectID 2004 -WhatIf
```

Display detailed runtime information:

```powershell
New-TestResourceGroup -ProjectID 2004 -Verbose
```

## Logging

The private `Write-ModuleLog` helper stores timestamped log files in:

```text
NWTC.ResourceGroups\Logs
```

Log files use the following naming format:

```text
New-TestResourceGroup-Log-yyyyMMdd-HHmmss.txt
```

## Testing

The module has been tested with:

- `ResourceGroupName`
- `ProjectID`
- Pipeline input
- Multiple project IDs
- `-WhatIf`
- Verbose output
- Structured results
- Execution statistics
- Log content and location

## Version

Current module version: `1.0.0`

## Author

Emre Inci
NWTC IT – Systems Administration
