# LM4: Enterprise PowerShell Functions

## Task 1: Evaluate the Existing Function

I reviewed the `New-TestResourceGroup` function that I created during LM3.

### Strengths

1. The function validates the resource group name before sending the request to Azure.
2. It supports `-WhatIf` and `-Confirm`, which makes resource creation safer.
3. It includes error handling, transcript logging, and structured output for troubleshooting and reporting.

### Areas for Improvement

1. The function currently accepts only one method for identifying a resource group and could benefit from parameter sets.
2. It does not use Begin, Process, and End blocks for efficient pipeline and bulk processing.
3. It does not track or display statistics such as the number of resource groups processed, created, skipped, or failed.
## Task 2: Add Parameter Sets

I added two parameter sets to the `New-TestResourceGroup` function. The `ResourceGroupName` parameter set allows an administrator to provide a complete resource group name. The `ProjectID` parameter set accepts a numeric project ID through a parameter or the pipeline and automatically creates a name using the `RG-<ProjectID>` format.

I first tested both parameter sets with `-WhatIf`. The function correctly displayed `lm4-emre-name-rg` when I used `-ResourceGroupName` and `RG-1001` when I used `-ProjectID 1001`.

I then tested both scenarios in Azure. The function successfully created `lm4-emre-name-rg` and `RG-1001` in the Central US region with the default tags.
## Task 3: Implement Begin, Process, and End Blocks

I reorganized the function by adding Begin, Process, and End blocks. The Begin block initializes the processed-item counter, prepares the output folder, starts one transcript, and displays a startup message.

The Process block runs once for every pipeline object. It converts each project ID into the `RG-<ProjectID>` naming format, creates the resource group, handles errors, and returns a separate structured result object.

The End block displays the total number of processed items and stops the transcript. I first tested the function with `-WhatIf` and confirmed that all three project IDs were processed without changing Azure.

I then ran `"1001", "1002", "1003" | New-TestResourceGroup`. The function successfully processed all three values and returned results for `RG-1001`, `RG-1002`, and `RG-1003`. The final summary displayed `Total items processed: 3`.
## Task 4: Improve User Feedback

I added meaningful `Write-Verbose` messages throughout the function. The messages now identify when the function starts, when parameter validation succeeds, when the function sends a resource group creation request, and when Azure confirms successful completion.

I tested the function by running `New-TestResourceGroup -ProjectID 1004 -Verbose`. The function created `RG-1004` successfully and displayed detailed progress information without changing the normal structured output.

I learned that verbose messages provide useful troubleshooting details when requested while keeping the default function output easier to read.
## Task 5: Process Multiple Resource Groups

I created a file named `ResourceGroups.txt` in the repository root. The file contained the project IDs `1005`, `1006`, and `1007`, with one value on each line.

I first used `Get-Content .\ResourceGroups.txt | New-TestResourceGroup -WhatIf` to preview the bulk operation. The function processed all three values and displayed the names `RG-1005`, `RG-1006`, and `RG-1007` without changing Azure.

I then ran `Get-Content .\ResourceGroups.txt | New-TestResourceGroup`. The function processed three objects and successfully created all three resource groups. No warnings or errors were generated.
## Task 6: Add Execution Statistics

I added counters to track the total number of requests processed, resources created, resources skipped, and errors encountered. The counters are initialized in the Begin block, updated for each object in the Process block, and displayed as a summary in the End block.

I first tested the counters with `"1008", "1009", "1010" | New-TestResourceGroup -WhatIf`. The summary reported three processed records, zero created resources, zero errors, and three skipped resources. The function also displayed a warning for each skipped operation.

I then ran the same pipeline without `-WhatIf`. The function successfully created `RG-1008`, `RG-1009`, and `RG-1010`. The final summary reported three processed records, three created resources, zero errors, and zero skipped resources.
## Task 7: Prepare for Module Development

I updated both the function README and the main repository README to document the LM4 features, project structure, requirements, usage examples, safety controls, and testing instructions.

I also updated the function's comment-based help and confirmed that it displays correctly with `Get-Help`. I replaced the original Azure-only Pester test with function-focused tests that use mocks. These tests verify the parameter sets, pipeline support, resource group naming, structured output, Azure location, safe execution with `-WhatIf`, and calls to `New-AzResourceGroup` without creating real Azure resources.

I ran the updated Pester test file successfully. All 7 tests passed with no failures or skipped tests. The completed function is now organized, documented, and prepared for conversion into a reusable PowerShell module.