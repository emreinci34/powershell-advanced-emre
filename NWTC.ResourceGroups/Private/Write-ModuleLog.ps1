function Write-ModuleLog {
    <#
    .SYNOPSIS
    Writes a timestamped message to a module log file.

    .DESCRIPTION
    Creates the log folder when necessary and writes a formatted message
    containing the date, time, severity level, and message text. Logging
    remains active when the calling function uses the WhatIf parameter.

    .PARAMETER Message
    Specifies the message that will be written to the log.

    .PARAMETER Path
    Specifies the complete path of the log file.

    .PARAMETER Level
    Specifies the severity of the message. Accepted values are Information,
    Warning, and Error.

    .EXAMPLE
    Write-ModuleLog `
        -Message "Resource group processing started." `
        -Path "C:\Logs\New-TestResourceGroup-Log.txt"

    Writes an informational entry to the specified log file.

    .EXAMPLE
    Write-ModuleLog `
        -Message "Resource group creation failed." `
        -Path "C:\Logs\New-TestResourceGroup-Log.txt" `
        -Level "Error"

    Writes an error entry to the specified log file.

    .NOTES
    Author: Emre Inci
    Module: NWTC.ResourceGroups
    Version: 1.0.0
    Purpose: Provides private and consistent logging for module functions.
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Message,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Path,

        [ValidateSet("Information", "Warning", "Error")]
        [string]$Level = "Information"
    )

    $logFolder = Split-Path -Path $Path -Parent

    if (-not (Test-Path -Path $logFolder)) {
        New-Item `
            -Path $logFolder `
            -ItemType Directory `
            -Force `
            -WhatIf:$false | Out-Null
    }

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[$timestamp] [$Level] $Message"

    Add-Content `
        -Path $Path `
        -Value $logEntry `
        -WhatIf:$false
}