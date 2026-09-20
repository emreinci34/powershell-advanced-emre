function New-TestResourceGroup {
    <#
    .SYNOPSIS
    Creates Azure resource groups in the Central US region.

    .DESCRIPTION
    Creates one or more Azure resource groups using either a supplied resource
    group name or project IDs. When ProjectID is used, the function automatically
    creates names in the RG-<ProjectID> format.

    The function supports pipeline processing through Begin, Process, and End
    blocks. It validates parameters, applies tags, supports WhatIf and Confirm,
    handles errors, records transcript logs, returns structured output, and
    displays end-of-run execution statistics.

    .PARAMETER ResourceGroupName
    Specifies a complete Azure resource group name. The value must contain
    between 1 and 90 characters.

    .PARAMETER ProjectID
    Specifies a numeric project ID. The function converts the value into a
    resource group name using the RG-<ProjectID> naming convention. This
    parameter accepts multiple values through the pipeline.

    .PARAMETER Tags
    Specifies identifying tags for the resource group. If no tags are
    provided, the function uses IT as the department and Test as the
    environment.

    .EXAMPLE
    New-TestResourceGroup -ResourceGroupName "lm4-emre-name-rg"

    Creates an Azure resource group using the supplied name.

    .EXAMPLE
    New-TestResourceGroup -ProjectID 1001

    Creates an Azure resource group named RG-1001.

    .EXAMPLE
    "1001", "1002", "1003" | New-TestResourceGroup

    Processes three project IDs from the pipeline.

    .EXAMPLE
    Get-Content .\ResourceGroups.txt | New-TestResourceGroup

    Reads project IDs from a text file and processes each value.

    .EXAMPLE
    "1001", "1002", "1003" | New-TestResourceGroup -WhatIf

    Previews the operations and reports all three requests as skipped.
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

        # Prepare the transcript location.
        $repositoryRoot = Split-Path -Path $PSScriptRoot -Parent
        $logFolder = Join-Path -Path $repositoryRoot -ChildPath "output"

        if (-not (Test-Path -Path $logFolder)) {
            New-Item -Path $logFolder -ItemType Directory | Out-Null
        }

        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        $transcriptPath = Join-Path `
            -Path $logFolder `
            -ChildPath "resourcegroup-$timestamp.log"

        Start-Transcript -Path $transcriptPath

        Write-Host "Starting Azure resource group processing."
        Write-Verbose "Begin: Function processing has started."
        Write-Verbose "Begin: Transcript logging has started."
        Write-Debug "Begin: Transcript path is $transcriptPath"
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

                New-AzResourceGroup `
                    -Name $currentResourceGroupName `
                    -Location "centralus" `
                    -Tags $Tags `
                    -ErrorAction Stop | Out-Null

                $createdCount++
                $result.Status = "Created"

                Write-Verbose "Process: Azure confirmed '$currentResourceGroupName'."
                Write-Host "Resource group created successfully: $currentResourceGroupName"
            }
            else {
                $skippedCount++
                $result.Status = "Skipped"

                Write-Warning "Creation was skipped for '$currentResourceGroupName'."
            }
        }
        catch {
            $errorCount++
            $result.Status = "Error"

            Write-Debug "Process: Error received: $($_.Exception.Message)"
            Write-Error "Failed to create '$currentResourceGroupName': $($_.Exception.Message)"
        }

        # Return one result object for each processed item.
        $result
    }

    end {
        Write-Host ""
        Write-Host "Summary of Resource Group Creation:"
        Write-Host "-----------------------------------"
        Write-Host "Total Records Processed: $processedCount"
        Write-Host "Created: $createdCount"
        Write-Host "Errors: $errorCount"
        Write-Host "Skipped: $skippedCount"
        Write-Host "Transcript Location: $transcriptPath"

        Write-Verbose "End: Function processing has completed."
        Write-Debug "End: Processed=$processedCount; Created=$createdCount; Errors=$errorCount; Skipped=$skippedCount"

        Stop-Transcript
    }
}