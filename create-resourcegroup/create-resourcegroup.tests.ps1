BeforeAll {
    . "$PSScriptRoot\create-resourcegroup.ps1"
}

Describe "New-TestResourceGroup Function Tests" {
    BeforeEach {
        Mock Start-Transcript {}
        Mock Stop-Transcript {}
        Mock New-AzResourceGroup {}
    }

    Context "Function Design" {
        It "Includes the ResourceGroupName parameter set" {
            $parameterSets = (Get-Command New-TestResourceGroup).ParameterSets.Name

            $parameterSets | Should -Contain "ResourceGroupName"
        }

        It "Includes the ProjectID parameter set" {
            $parameterSets = (Get-Command New-TestResourceGroup).ParameterSets.Name

            $parameterSets | Should -Contain "ProjectID"
        }

        It "Allows ProjectID values from the pipeline" {
            $projectParameter = (
                Get-Command New-TestResourceGroup
            ).Parameters["ProjectID"]

            $pipelineAttribute = $projectParameter.Attributes |
                Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] }

            $pipelineAttribute.ValueFromPipeline | Should -Contain $true
        }
    }

    Context "Resource Group Naming and Output" {
        It "Uses the supplied resource group name" {
            $result = New-TestResourceGroup `
                -ResourceGroupName "pester-name-test-rg"

            $result.ResourceGroupName | Should -Be "pester-name-test-rg"
            $result.Location | Should -Be "centralus"
            $result.Status | Should -Be "Created"

            Should -Invoke New-AzResourceGroup `
                -Times 1 `
                -Exactly `
                -ParameterFilter {
                    $Name -eq "pester-name-test-rg" -and
                    $Location -eq "centralus"
                }
        }

        It "Creates the expected name from a ProjectID" {
            $result = New-TestResourceGroup -ProjectID 3001

            $result.ResourceGroupName | Should -Be "RG-3001"
            $result.Location | Should -Be "centralus"
            $result.Status | Should -Be "Created"

            Should -Invoke New-AzResourceGroup `
                -Times 1 `
                -Exactly `
                -ParameterFilter {
                    $Name -eq "RG-3001" -and
                    $Location -eq "centralus"
                }
        }

        It "Processes multiple ProjectID values from the pipeline" {
            $projectIds = 3002, 3003
            $results = @($projectIds | New-TestResourceGroup)

            $results.Count | Should -Be 2
            $results.ResourceGroupName | Should -Contain "RG-3002"
            $results.ResourceGroupName | Should -Contain "RG-3003"
            $results.Status | Should -Not -Contain "Error"

            Should -Invoke New-AzResourceGroup -Times 2 -Exactly
        }
    }

    Context "Safe Execution" {
        It "Skips resource creation when WhatIf is used" {
            $result = New-TestResourceGroup -ProjectID 3004 -WhatIf

            $result.ResourceGroupName | Should -Be "RG-3004"
            $result.Status | Should -Be "Skipped"

            Should -Invoke New-AzResourceGroup -Times 0 -Exactly
        }
    }
}