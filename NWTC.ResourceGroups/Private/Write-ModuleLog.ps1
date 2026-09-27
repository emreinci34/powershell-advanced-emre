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