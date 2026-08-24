<#
.SYNOPSIS
Creates a new Azure resource group in the Central US region.

.DESCRIPTION
Creates an Azure resource group using the supplied ResourceGroupName.
The script validates input, handles errors, and records its activity
in a timestamped transcript file.

.PARAMETER ResourceGroupName
Specifies the Azure resource group name. The value must contain
between 1 and 90 characters.

.EXAMPLE
.\create-resourcegroup.ps1 -ResourceGroupName "lm1-emre-task5-rg"

Creates an Azure resource group named lm1-emre-task5-rg in Central US.
#>

param(
    [Parameter(Mandatory)]
    [ValidateLength(1, 90)]
    [string]$ResourceGroupName
)

# Create a Logs folder inside the LM1 directory.
$logFolder = Join-Path -Path $PSScriptRoot -ChildPath "Logs"

if (-not (Test-Path -Path $logFolder)) {
    New-Item -Path $logFolder -ItemType Directory | Out-Null
}

# Give each transcript a unique date and time.
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$transcriptPath = Join-Path -Path $logFolder -ChildPath "resourcegroup-$timestamp.log"

Start-Transcript -Path $transcriptPath

try {
    Write-Host "Creating Azure resource group: $ResourceGroupName"

    New-AzResourceGroup `
        -Name $ResourceGroupName `
        -Location "centralus" `
        -ErrorAction Stop

    Write-Host "Resource group created successfully."
}
catch {
    Write-Error "Failed to create the resource group: $($_.Exception.Message)"
}
finally {
    Write-Host "Resource group creation attempt completed."
    Write-Host "Transcript location: $transcriptPath"
    Stop-Transcript
}