# LM5: Converting Functions into a PowerShell Module

## Task 1: Create the Module Structure

I created a new module folder named `NWTC.ResourceGroups` in my PowerShell repository. Inside the module folder, I created the `Public`, `Private`, `Tests`, `Logs`, and `Docs` folders. I also created the main module file named `NWTC.ResourceGroups.psm1`.

I copied my existing `New-TestResourceGroup` function from LM4 into the `Public` folder and saved it as `New-TestResourceGroup.ps1`. This structure separates the different parts of the module and will make it easier to maintain and expand in the future.

I committed the initial module structure with the commit message `Initial commit.` and pushed it to GitHub.

## Task 2: Create the Script Module

I updated `NWTC.ResourceGroups.psm1` so it searches the `Public` folder for PowerShell script files. The module uses `$PSScriptRoot` to locate its own folder and dot-sources each `.ps1` file that it finds.

I imported the module with `Import-Module` and verified the result with `Get-Command`. PowerShell displayed `New-TestResourceGroup` as a function with `NWTC.ResourceGroups` as its source. This confirmed that the public function was loaded successfully through the module.
## Task 3: Create the Module Manifest

I created a module manifest named `NWTC.ResourceGroups.psd1` for the module. The manifest identifies the module as version `1.0.0`, lists me as the author, and includes a short description of the module's purpose.

I used `Test-ModuleManifest` to validate the file. PowerShell successfully displayed the module name, version, author, and description, confirming that the manifest was created correctly.
## Task 4: Export Module Members

I added `Export-ModuleMember` to the module file and configured it to export the base names of the scripts found in the `Public` folder. This allows the module to expose only the functions intended for administrators.

After re-importing the module, I ran `Get-Command -Module NWTC.ResourceGroups`. PowerShell displayed only `New-TestResourceGroup`, confirming that the correct public function was exported.
## Task 5: Create a Private Logging Function

I created a private helper function named `Write-ModuleLog` and saved it in the module's `Private` folder. The helper accepts a message, log file path, and severity level. It creates the log folder when necessary and adds a timestamp and severity level to every entry.

I updated `NWTC.ResourceGroups.psm1` so that it loads functions from both the `Private` and `Public` folders. Only functions stored in the `Public` folder are exported. I verified this by running `Get-Command -Module NWTC.ResourceGroups`. The output displayed `New-TestResourceGroup`, but the private `Write-ModuleLog` helper was not visible to the user.

I replaced the transcript logging in `New-TestResourceGroup` with the private logging helper. The function now creates timestamped files in the module's `Logs` folder using the `New-TestResourceGroup-Log-yyyyMMdd-HHmmss.txt` naming format.

I tested the function first with `-WhatIf`. The function skipped the Azure operation and recorded the validation, skipped operation, and execution summary in the log. I then created `RG-2001` successfully. The log recorded the function start, validation success, creation attempt, successful completion, and final statistics.

This task showed me how a private helper can provide shared internal functionality without adding unnecessary commands to the module's public interface.
## Task 6: Test the Module

I tested each major feature of the `NWTC.ResourceGroups` module to verify that it operates correctly.

### ResourceGroupName Test

I tested the function with the `ResourceGroupName` parameter by using `lm5-emre-test-rg`. I first used `-WhatIf` to preview the operation and confirmed that the function reported the operation as skipped. I then ran the command without `-WhatIf`, and the resource group was created successfully in the Central US region.

### ProjectID Test

I tested the `ProjectID` parameter with the value `2002`. The function correctly applied the automatic naming convention and created a resource group named `RG-2002`.

### Pipeline and Multiple-Value Test

I sent the values `2003`, `2004`, and `2005` to the function through the PowerShell pipeline. The function processed each value individually and successfully created `RG-2003`, `RG-2004`, and `RG-2005`.

The final execution summary reported:

- Total records processed: 3
- Resources created: 3
- Errors: 0
- Resources skipped: 0

### Logging Test

I reviewed the generated log file and confirmed that it contained the function start, validation results, creation attempts, successful operations, and final execution statistics. Each entry included a timestamp and severity level.

I also verified that the log files were stored in the expected `NWTC.ResourceGroups\Logs` folder. The pipeline test created the log file `New-TestResourceGroup-Log-20260927-224018.txt`.

All tested module features worked as expected. The module accepts both parameter sets, supports pipeline input and multiple values, returns structured results, reports execution statistics, and stores accurate log information in the correct location.