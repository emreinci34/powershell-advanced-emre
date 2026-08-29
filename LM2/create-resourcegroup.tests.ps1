Describe "Azure Resource Group Creation Test" {
    BeforeAll {
        $ResourceGroupName = "lm2-emre-debug-rg"
        $ExpectedLocation = "centralus"

        $ResourceGroup = Get-AzResourceGroup `
            -Name $ResourceGroupName `
            -ErrorAction Stop
    }

    It "Verifies that the resource group was created in Central US" {
        $ResourceGroup.ResourceGroupName | Should -Be $ResourceGroupName
        $ResourceGroup.Location | Should -Be $ExpectedLocation
        $ResourceGroup.ProvisioningState | Should -Be "Succeeded"
    }
}