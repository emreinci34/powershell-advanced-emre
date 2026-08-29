<#
.SYNOPSIS
Creates a new Azure resource group in the Central US region.

.DESCRIPTION
Creates an Azure resource group using the supplied ResourceGroupName.
The script validates input, handles errors, records its activity in a
timestamped transcript file, and provides verbose and debug output.

.PARAMETER ResourceGroupName
Specifies the Azure resource group name. The value must contain
between 1 and 90 characters.

.EXAMPLE
.\create-resourcegroup.ps1 -ResourceGroupName "lm2-emre-verbose-rg" -Verbose

Creates an Azure resource group and displays detailed status information.
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateLength(1, 90)]
    [string]$ResourceGroupName
)

# Step 1: Prepare the transcript location.
$logFolder = Join-Path -Path $PSScriptRoot -ChildPath "Logs"

if (-not (Test-Path -Path $logFolder)) {
    New-Item -Path $logFolder -ItemType Directory | Out-Null
}

$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$transcriptPath = Join-Path -Path $logFolder -ChildPath "resourcegroup-$timestamp.log"

Start-Transcript -Path $transcriptPath

Write-Verbose "Step 1: Transcript logging has started."
Write-Debug "Step 1: Transcript path is $transcriptPath"

try {
    # Step 2: Prepare and validate the deployment information.
    Write-Verbose "Step 2: Preparing resource group deployment information."
    Write-Debug "Step 2: Resource group name is '$ResourceGroupName' and location is 'centralus'."

    Write-Host "Creating Azure resource group: $ResourceGroupName"

    # Step 3: Submit the resource group request to Azure.
    Write-Verbose "Step 3: Sending the resource group creation request to Azure."
    Write-Debug "Step 3: Executing New-AzResourceGroup with ErrorAction Stop."

    New-AzResourceGroup `
        -Name $ResourceGroupName `
        -Location "centralus" `
        -ErrorAction Stop

    Write-Verbose "Step 4: Azure confirmed the resource group operation."
    Write-Debug "Step 4: The New-AzResourceGroup command completed without a terminating error."
    Write-Host "Resource group created successfully."
}
catch {
    Write-Debug "The Catch block received this error: $($_.Exception.Message)"
    Write-Error "Failed to create the resource group: $($_.Exception.Message)"
}
finally {
    Write-Verbose "Final step: Completing the script and stopping the transcript."
    Write-Debug "The Finally block will run regardless of success or failure."
    Write-Host "Resource group creation attempt completed."
    Write-Host "Transcript location: $transcriptPath"
    Stop-Transcript
}