# Azure Resource Group PowerShell Function

## Project Purpose

This project contains a reusable PowerShell advanced function named `New-TestResourceGroup`. The function creates Azure resource groups in the Central US region while applying validation, default or custom tags, safe execution controls, transcript logging, and structured output.

## Function Features

- Accepts a resource group name as a parameter or through the PowerShell pipeline.
- Validates the resource group name before sending the request to Azure.
- Applies default tags for the IT department and Test environment.
- Accepts custom tags through a hashtable parameter.
- Supports `-WhatIf` and `-Confirm` through `SupportsShouldProcess`.
- Uses Try, Catch, and Finally blocks for error handling.
- Records execution activity in timestamped transcript files.
- Returns a structured `PSCustomObject` containing the resource group name, location, status, tags, and timestamp.

## Files Included

- `create-resourcegroup.ps1` – Contains the `New-TestResourceGroup` function.
- `create-resourcegroup.tests.ps1` – Contains automated Pester tests for the function.
- `README.md` – Describes the project, function features, and usage.

Transcript files created by the function are stored in the repository's `output` folder.

## Usage

Load the function into the current PowerShell session:

```powershell
. .\create-resourcegroup\create-resourcegroup.ps1