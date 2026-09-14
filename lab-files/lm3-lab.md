# LM3: Advanced PowerShell Functions

## Lab Summary

In this lab, I converted my Azure resource group script into a reusable advanced PowerShell function named `New-TestResourceGroup`. I gradually added features that make the function safer, easier to reuse, and more suitable for professional automation.

## Task 1: Create a Reusable Function

I placed the existing resource group creation code inside the `New-TestResourceGroup` function. I then loaded the function into the current PowerShell session by dot-sourcing the script and verified it with `Get-Command`.

Using a function allows the same tested code to be reused without maintaining multiple copies of the script.

## Task 2: Add Parameter Validation and Tags

I kept the `ResourceGroupName` parameter mandatory and used `ValidateLength(1, 90)` to reject invalid names before sending a request to Azure.

I also added an optional `Tags` hashtable parameter with the following default values:

* Department: IT
* Environment: Test

I tested the default tags by creating `lm3-emre-default-rg`. I then supplied custom tags and created `lm3-emre-dev-rg` with Dev as the department and Development as the environment. I verified both sets of tags in the Azure portal.

## Task 3: Accept Pipeline Input

I added `ValueFromPipeline` to the `ResourceGroupName` parameter. This allowed the function to accept a resource group name directly from the PowerShell pipeline.

I tested this functionality with:

```powershell
"lm3-emre-pipeline-rg" | New-TestResourceGroup
```

The resource group was created successfully with the default tags.

## Task 4: Create Structured Output

I created a `PSCustomObject` to return useful information instead of relying only on plain text messages. The returned object includes:

* ResourceGroupName
* Location
* Status
* Tags
* Timestamp

I tested the structured output by creating `lm3-emre-output-rg`. The function returned the expected property names and reported the status as Created.

## Task 5: Add WhatIf and Confirm Support

I enabled `SupportsShouldProcess` in `CmdletBinding` and placed the Azure resource group creation code inside a `ShouldProcess` condition.

I tested `-WhatIf` with `lm3-emre-whatif-rg`. PowerShell displayed the proposed operation without creating the resource group, and the structured output showed Not Created.

I also tested `-Confirm` with `lm3-emre-confirm-rg`. PowerShell requested confirmation before performing the operation, and the resource group was created after I approved it.

## Task 6: Organize and Document the Project

I reorganized the repository into clearer project folders:

* `create-resourcegroup` contains the function, Pester tests, and project README.
* `lab-files` contains the LM1, LM2, and LM3 lab documentation.
* `output` contains the transcript log files.

I updated the function so that new timestamped transcripts are written to the repository's `output` folder. I also updated the project documentation to describe the function’s features and provide usage examples.

## What I Learned

This lab showed me how advanced PowerShell function features work together to improve automation. Parameter validation prevents invalid input, pipeline support makes the function easier to include in larger workflows, structured output allows results to be processed by other commands, and WhatIf provides a safer way to preview changes. These features make the function more reliable, maintainable, and useful for managing Azure resources.
