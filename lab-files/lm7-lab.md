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