@{
    # Main script module file.
    RootModule = 'NWTC.ResourceGroups.psm1'

    # Module version.
    ModuleVersion = '1.1.0'

    # Unique module identifier.
    GUID = '21ba6f5f-9a3d-4d1f-9492-df24bf6daf73'

    # Module information.
    Author = 'Emre Inci'
    CompanyName = 'NWTC'
    Copyright = '(c) Emre Inci. All rights reserved.'
    Description = 'Provides enterprise functions for creating and managing Azure test resource groups.'

    # Minimum supported PowerShell version.
    PowerShellVersion = '7.0'

    # Public commands available to users.
    FunctionsToExport = @(
        'New-TestResourceGroup'
        'Get-ResourceGroupSummary'
    )

    # This module does not export cmdlets, variables, or aliases.
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()

    # Additional module information.
    PrivateData = @{
        PSData = @{
            Tags = @(
                'Azure'
                'ResourceGroup'
                'PowerShell'
                'NWTC'
            )

            ProjectUri = 'https://github.com/emreinci34/powershell-advanced-emre'

            ReleaseNotes = 'Version 1.1.0 adds Get-ResourceGroupSummary, updated documentation, improved testing, a changelog, and detailed release notes.'
        }
    }
}