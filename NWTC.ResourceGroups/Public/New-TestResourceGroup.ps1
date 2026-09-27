function New-TestResourceGroup {
    <#
    .SYNOPSIS
    Creates Azure resource groups in the Central US region.

    .DESCRIPTION
    Creates one or more Azure resource groups using either a supplied resource
    group name or project IDs. When ProjectID is used, the function automatically
    creates names in the RG-<ProjectID> format. The function supports pipeline
    processing, validation, tags, WhatIf, Confirm, structured output, execution
    statistics, and module-based logging.

    .PARAMETER ResourceGroupName
    Specifies a complete Azure resource group name. The value must contain
    between 1 and 90 characters.

    .PARAMETER ProjectID
    Specifies a numeric project ID. The function converts the value into a
    resource group name using the RG-<ProjectID> naming convention. This
    parameter accepts multiple values through the pipeline.

    .PARAMETER Tags
    Specifies identifying tags for the resource group. If no tags are supplied,
    the function uses IT as the department and Test as the environment.

    .EXAMPLE
    New-TestResourceGroup -ResourceGroupName "lm5-emre-name-rg"

    Creates a resource group using the supplied name.

    .EXAMPLE
    New-TestResourceGroup -ProjectID 2001

    Creates an Azure resource group named RG-2001.

    .EXAMPLE
    "2001", "2002", "2003" | New-TestResourceGroup

    Processes three project IDs through the pipeline.

    .EXAMPLE
    "2001", "2002", "2003" | New-TestResourceGroup -WhatIf

    Previews the creation of three resource groups without creating them.

    .NOTES
    Author: Emre Inci
    Module: NWTC.ResourceGroups
    Version: 1.0.0
    Purpose: Provides safe and consistent Azure resource group creation.
    #>

    [CmdletBinding(
        SupportsShouldProcess = $true,
        DefaultParameterSetName = "ResourceGroupName"
    )]
    param(
        [Parameter(
            Mandatory,
            ParameterSetName = "ResourceGroupName"
        )]
        [ValidateLength(1, 90)]
        [string]$ResourceGroupName,

        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ParameterSetName = "ProjectID"
        )]
        [ValidateRange(1, 999999)]
        [int]$ProjectID,

        [hashtable]$Tags = @{
            Department  = "IT"
            Environment = "Test"
        }
    )

    begin {
        # Initialize execution statistics.
        $processedCount = 0
        $createdCount = 0
        $skippedCount = 0
        $errorCount = 0

        # Create a timestamped module log path.
        $moduleRoot = Split-Path -Path $PSScriptRoot -Parent
        $logFolder = Join-Path -Path $moduleRoot -ChildPath "Logs"
        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        $logPath = Join-Path `
            -Path $logFolder `
            -ChildPath "New-TestResourceGroup-Log-$timestamp.txt"

        Write-ModuleLog `
            -Message "New-TestResourceGroup processing started." `
            -Path $logPath

        Write-Host "Starting Azure resource group processing."
        Write-Verbose "Begin: Function processing has started."
        Write-Verbose "Begin: Module logging has started."
        Write-Debug "Begin: Log path is $logPath"
    }

    process {
        $processedCount++

        # Determine the name for the current pipeline object.
        if ($PSCmdlet.ParameterSetName -eq "ProjectID") {
            $currentResourceGroupName = "RG-$ProjectID"
        }
        else {
            $currentResourceGroupName = $ResourceGroupName
        }

        Write-Verbose "Process: Preparing '$currentResourceGroupName'."
        Write-Verbose "Process: Validation succeeded for '$currentResourceGroupName'."
        Write-Debug "Process: Parameter set is '$($PSCmdlet.ParameterSetName)'."

        Write-ModuleLog `
            -Message "Validation succeeded for '$currentResourceGroupName'." `
            -Path $logPath

        # Create a structured result for the current item.
        $result = [PSCustomObject]@{
            ResourceGroupName = $currentResourceGroupName
            Location          = "centralus"
            Status            = "Not Created"
            Tags              = $Tags
            Timestamp         = Get-Date
        }

        try {
            if ($PSCmdlet.ShouldProcess(
                    "Resource Group '$currentResourceGroupName'",
                    "Create"
                )) {
                Write-Host "Creating Azure resource group: $currentResourceGroupName"
                Write-Verbose "Process: Sending the creation request to Azure."

                Write-ModuleLog `
                    -Message "Attempting to create '$currentResourceGroupName'." `
                    -Path $logPath

                New-AzResourceGroup `
                    -Name $currentResourceGroupName `
                    -Location "centralus" `
                    -Tags $Tags `
                    -ErrorAction Stop | Out-Null

                $result.Status = "Created"
                $createdCount++

                Write-Verbose "Process: Azure confirmed '$currentResourceGroupName'."
                Write-Host "Resource group created successfully: $currentResourceGroupName"

                Write-ModuleLog `
                    -Message "Successfully created '$currentResourceGroupName'." `
                    -Path $logPath
            }
            else {
                $result.Status = "Skipped"
                $skippedCount++

                Write-Warning "Creation was skipped for '$currentResourceGroupName'."

                Write-ModuleLog `
                    -Message "Creation was skipped for '$currentResourceGroupName'." `
                    -Path $logPath `
                    -Level "Warning"
            }
        }
        catch {
            $result.Status = "Error"
            $errorCount++

            $errorMessage = $_.Exception.Message

            Write-Debug "Process: Error received: $errorMessage"
            Write-Error "Failed to create '$currentResourceGroupName': $errorMessage"

            Write-ModuleLog `
                -Message "Failed to create '$currentResourceGroupName': $errorMessage" `
                -Path $logPath `
                -Level "Error"
        }

        # Return one structured result for each processed item.
        $result
    }

    end {
        $summaryMessage = @"
Resource group processing completed.
Total Records Processed: $processedCount
Created: $createdCount
Errors: $errorCount
Skipped: $skippedCount
"@

        Write-ModuleLog `
            -Message $summaryMessage `
            -Path $logPath

        Write-Host ""
        Write-Host "Summary of Resource Group Creation:"
        Write-Host "-----------------------------------"
        Write-Host "Total Records Processed: $processedCount"
        Write-Host "Created: $createdCount"
        Write-Host "Errors: $errorCount"
        Write-Host "Skipped: $skippedCount"
        Write-Host "Log Location: $logPath"

        Write-Verbose "End: Function processing has completed."
        Write-Debug "End: A total of $processedCount item(s) were processed."
    }
}