# LM7: Creating a Baseline Configuration with DSC

## Task 1: Examine a DSC Configuration

I examined the `dsc-config-example.ps1` file to understand the basic structure of a Desired State Configuration.

### Configuration Name

The configuration is named `CompanyBaseline`.

### Node

The configuration targets the `localhost` node. This means the configuration will be compiled and applied to the local server.

### Resource 1: AutomationFolder

The first resource is `File AutomationFolder`.

This resource ensures that a directory named `C:\Automation` exists on the server. The `Type` property identifies the item as a directory, and `Ensure = "Present"` instructs DSC to create the directory if it does not already exist.

### Resource 2: ConfigFile

The second resource is `File ConfigFile`.

This resource ensures that a file named `C:\Automation\Config.txt` exists. The file contains the text `NWTC Standard Configuration`. The `DependsOn` property requires the `AutomationFolder` resource to finish first so that the directory exists before the file is created.

### What I Learned

The example showed that a DSC configuration defines the required state of a system instead of listing only a sequence of commands. It also demonstrated how dependencies can control the order in which DSC resources are applied.
### Compilation and Validation Results

The `CompanyBaseline` configuration compiled successfully and generated the `localhost.mof` file in `DSC\CompanyBaselineExample`.

I applied the MOF file using `Start-DscConfiguration`. DSC created the `C:\Automation` directory first and then created `C:\Automation\Config.txt` with the required content.

`Test-DscConfiguration` returned `True`, confirming that the server matched the desired configuration. `Get-DscConfiguration` displayed both the `AutomationFolder` and `ConfigFile` resources as part of the active `CompanyBaseline` configuration.
## Task 2: Create My First DSC Configuration

I created a new DSC configuration file named `lm7-dsc.ps1` in the `DSC` folder.

The configuration is named `EmreBaseline` and targets the `localhost` node. I used the `WindowsFeature` DSC resource, which is different from the `File` resources used in the Task 1 example.

The `IISWebServer` resource requires the `Web-Server` Windows feature to be present. When this configuration is compiled and applied, DSC will install IIS if it is not already installed.

I verified the script in Windows PowerShell and confirmed that `EmreBaseline` was successfully recognized as a DSC configuration.
## Task 3: Generate and Review MOF Files

I compiled the `EmreBaseline` DSC configuration and generated a MOF file for the `localhost` node.

### File Location

The generated MOF file is located at:

`C:\powershell-advanced-emre\DSC\EmreBaseline\localhost.mof`

### File Purpose

The MOF file is the compiled version of the DSC configuration. It contains the desired system settings in a format that the Local Configuration Manager can read and apply to the target node.

### Information Observed

The MOF file identifies the configuration as `EmreBaseline`. It contains a `WindowsFeature` resource with the resource ID `[WindowsFeature]IISWebServer`.

The resource specifies `Name = "Web-Server"` and `Ensure = "Present"`. This means that DSC should verify that the IIS Web Server feature is installed on the local server and install it if necessary.

I also observed that the resource uses the `PSDesiredStateConfiguration` module and that the MOF file includes configuration metadata used by DSC during deployment.

## Task 4: Apply the Configuration

I applied the `EmreBaseline` MOF file by using `Start-DscConfiguration` with the `-Wait` and `-Verbose` parameters.

The Local Configuration Manager processed the `[WindowsFeature]IISWebServer` resource and successfully installed the `Web-Server` feature. The configuration job completed in approximately 199 seconds.

I verified the installation with `Get-WindowsFeature Web-Server`, which showed the IIS Web Server feature with an installation state of `Installed`.
