# LM1 Lab: Applying PowerShell Scripting Best Practices

## Task 1: Evaluate Existing Script Quality

### Original Script

```powershell
$a = Read-Host "RG Name"

New-AzResourceGroup -Name $a -Location centralus
```

### Issues Identified

1. **The variable name `$a` is not descriptive.**  
   Another administrator would not immediately know what information this variable stores. In an enterprise environment, unclear variable names make scripts harder to read, maintain, and troubleshoot.

2. **The script uses `Read-Host` instead of a parameter.**  
   This requires someone to manually enter the resource group name every time the script runs. It also makes the script harder to reuse in scheduled tasks or other automated processes.

3. **The resource group name is not validated.**  
   The script accepts input without checking whether it is valid. Incorrect input could cause the Azure command to fail and make troubleshooting more difficult.

4. **The script does not include documentation or error handling.**  
   There are no instructions explaining the script, and an Azure failure would not be handled clearly. In an enterprise environment, this could make the script difficult for other administrators to use and support.
   ## Task 2: Create Professional Documentation

### Script Purpose

The purpose of `create-resourcegroup.ps1` is to prompt an administrator for a resource group name and create that resource group in the Central US Azure region.

### Documented Parameter

`ResourceGroupName` represents the name of the Azure resource group that will be created. In the current version of the script, this value is collected interactively through the `RG Name` prompt.

### Sample Execution

```powershell
.\create-resourcegroup.ps1
## Task 3: Implement Parameter Validation

### Validation Method Selected

I used `[ValidateLength(1, 90)]` to require the ResourceGroupName value to contain between 1 and 90 characters.

### Valid Input

`lm1-emre-validation-rg`

### Invalid Input

A 91-character value generated with `("x" * 91)`.

### Testing Results

The valid input passed validation and successfully created the Azure resource group in Central US. The 91-character input was rejected by parameter validation before `New-AzResourceGroup` could run.
## Task 4: Structured Error Handling

### Error Generated

The script was tested with the invalid resource group name `lm1/emre-error-rg`. The forward slash is not permitted in an Azure resource group name.

### Error Message Received

Azure reported that the resource group name did not match the expected naming pattern.

### Catch Block Behavior

The `catch` block intercepted the terminating error and displayed a clear failure message containing the original Azure error. This prevented the script from failing without an explanation.

### Finally Block Behavior

The `finally` block displayed `Resource group creation attempt completed.` regardless of whether the operation succeeded or failed.
## Task 5: Add Logging and Improve Readability

### Transcript File Location

`C:\powershell-advanced-emre\LM1\Logs\resourcegroup-20260824-023101.log`

### Example Transcript Entry

`Resource group created successfully.`

### Readability Improvements

1. I replaced the unclear `$a` variable with the descriptive `$ResourceGroupName` parameter.
2. I improved the script by using consistent indentation, comments, and clearly organized logging and error-handling sections.