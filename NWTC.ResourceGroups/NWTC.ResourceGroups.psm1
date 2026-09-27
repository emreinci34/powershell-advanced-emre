# Locate all public function files in the module.
$publicFunctions = Get-ChildItem `
    -Path "$PSScriptRoot\Public\*.ps1" `
    -ErrorAction SilentlyContinue

# Load each public function into the module scope.
foreach ($function in $publicFunctions) {
    . $function.FullName
}
# Export only the functions stored in the Public folder.
Export-ModuleMember -Function $publicFunctions.BaseName