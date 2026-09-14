function New-TestResourceGroup {
    <#
    .SYNOPSIS
    Creates a new Azure resource group in the Central US region.

    .DESCRIPTION
    Creates an Azure resource group using the supplied ResourceGroupName.
    The function accepts pipeline input, validates parameters, applies tags,
    supports WhatIf and Confirm, handles errors, records its activity, and
    returns structured output.

    .PARAMETER ResourceGroupName
    Specifies the Azure resource group name. The value must contain
    between 1 and 90 characters and can be received from the pipeline.

    .PARAMETER Tags
    Specifies identifying tags for the resource group. If no tags are
    provided, the function uses IT as the department and Test as the
    environment.

    .EXAMPLE
    New-TestResourceGroup -ResourceGroupName "lm3-emre-default-rg"

    Creates an Azure resource group using the default tags.

    .EXAMPLE
    New-TestResourceGroup -ResourceGroupName "lm3-emre-dev-rg" -Tags @{
        Department  = "Dev"
        Environment = "Development"
    }

    Creates an Azure resource group using custom tags.

    .EXAMPLE
    "lm3-emre-pipeline-rg" | New-TestResourceGroup

    Sends the resource group name to the function through the pipeline.

    .EXAMPLE
    "lm3-emre-whatif-rg" | New-TestResourceGroup -WhatIf

    Shows what the function would do without creating the resource group.

    .EXAMPLE
    "lm3-emre-confirm-rg" | New-TestResourceGroup -Confirm

    Requests confirmation before creating the resource group.
    #>

    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateLength(1, 90)]
        [string]$ResourceGroupName,

        [hashtable]$Tags = @{
            Department  = "IT"
            Environment = "Test"
        }
    )

    # Step 1: Prepare the transcript location.
    $repositoryRoot = Split-Path -Path $PSScriptRoot -Parent
    $logFolder = Join-Path -Path $repositoryRoot -ChildPath "output"

    if (-not (Test-Path -Path $logFolder)) {
        New-Item -Path $logFolder -ItemType Directory | Out-Null
    }

    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $transcriptPath = Join-Path -Path $logFolder -ChildPath "resourcegroup-$timestamp.log"

    Start-Transcript -Path $transcriptPath

    Write-Verbose "Step 1: Transcript logging has started."
    Write-Debug "Step 1: Transcript path is $transcriptPath"

    # Create a structured result object before the Try/Catch statement.
    $result = [PSCustomObject]@{
        ResourceGroupName = $ResourceGroupName
        Location          = "centralus"
        Status            = "Not Created"
        Tags              = $Tags
        Timestamp         = Get-Date
    }

    try {
        # Step 2: Prepare and validate the deployment information.
        Write-Verbose "Step 2: Preparing resource group deployment information."
        Write-Debug "Step 2: Resource group name is '$ResourceGroupName' and location is 'centralus'."
        Write-Debug "Step 2: Resource group tags are $($Tags | Out-String)."

        if ($PSCmdlet.ShouldProcess(
                "Resource Group '$ResourceGroupName'",
                "Create"
            )) {
            Write-Host "Creating Azure resource group: $ResourceGroupName"

            # Step 3: Submit the resource group request to Azure.
            Write-Verbose "Step 3: Sending the resource group creation request to Azure."
            Write-Debug "Step 3: Executing New-AzResourceGroup with tags and ErrorAction Stop."

            New-AzResourceGroup `
                -Name $ResourceGroupName `
                -Location "centralus" `
                -Tags $Tags `
                -ErrorAction Stop | Out-Null

            $result.Status = "Created"

            Write-Verbose "Step 4: Azure confirmed the resource group operation."
            Write-Debug "Step 4: The New-AzResourceGroup command completed without a terminating error."
            Write-Host "Resource group created successfully."
        }
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

    # Return the structured result object.
    $result
}