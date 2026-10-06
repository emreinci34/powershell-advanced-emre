function Get-ResourceGroupSummary {
    <#
    .SYNOPSIS
    Displays summary information for Azure resource groups.

    .DESCRIPTION
    Retrieves Azure resource groups from the current Azure subscription and
    returns a structured summary containing each resource group's name,
    location, and tags.

    .EXAMPLE
    Get-ResourceGroupSummary

    Displays a summary of all Azure resource groups in the current subscription.

    .OUTPUTS
    PSCustomObject

    .NOTES
    Author: Emre Inci
    Module: NWTC.ResourceGroups
    Version: 1.1.0
    #>

    [CmdletBinding()]
    param()

    Write-Verbose "Retrieving Azure resource group information."

    try {
        $resourceGroups = Get-AzResourceGroup -ErrorAction Stop

        foreach ($resourceGroup in $resourceGroups) {
            [PSCustomObject]@{
                ResourceGroupName = $resourceGroup.ResourceGroupName
                Location          = $resourceGroup.Location
                Tags              = $resourceGroup.Tags
            }
        }

        Write-Verbose "Resource group summary completed successfully."
    }
    catch {
        Write-Error "Failed to retrieve resource group information: $($_.Exception.Message)"
    }
}