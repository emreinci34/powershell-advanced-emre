# PowerShell Advanced – Emre Inci

This repository contains my lab work and PowerShell automation projects for the PowerShell Advanced course at Northeast Wisconsin Technical College.

## Azure Resource Group Function

The main project in this repository is the `New-TestResourceGroup` advanced PowerShell function. I developed the function to create Azure resource groups in the Central US region using reusable and safer automation practices.

The function includes:

* Mandatory resource group name input with length validation
* Default and custom Azure resource tags
* Pipeline input support
* `WhatIf` and `Confirm` support
* Try, Catch, and Finally error handling
* Verbose and debug messages
* Timestamped transcript logging
* Structured `PSCustomObject` output
* Automated Pester testing

## Repository Structure

* `create-resourcegroup` – Contains the PowerShell function, Pester tests, and project documentation.
* `lab-files` – Contains my LM1, LM2, and LM3 lab summaries.
* `output` – Contains timestamped transcript files produced during script and function testing.

## Load the Function

Run the following command from the repository root:

```powershell
. .\create-resourcegroup\create-resourcegroup.ps1
```

## Example Usage

Create a resource group with default tags:

```powershell
New-TestResourceGroup -ResourceGroupName "lm3-emre-default-rg"
```

Create a resource group through the pipeline:

```powershell
"lm3-emre-pipeline-rg" | New-TestResourceGroup
```

Preview an operation safely:

```powershell
"lm3-emre-whatif-rg" | New-TestResourceGroup -WhatIf
```

## Testing

The project includes a Pester test that verifies the expected Azure resource group name, location, and provisioning state.

```powershell
Invoke-Pester .\create-resourcegroup\create-resourcegroup.tests.ps1
```

This project demonstrates how advanced PowerShell functions can make cloud administration more consistent, reusable, testable, and safe.
