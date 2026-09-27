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