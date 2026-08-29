# LM2 Lab: Testing, Debugging, and Source Control

## Task 1: Identify and Correct Script Errors

### Original Command

```powershell
Get-Process -Name explore
```

### Error Message Received

```text
Get-Process: Cannot find a process with the name "explore". Verify the process name and call the cmdlet again.
```

### Cause of the Error

The command failed because `explore` is not the correct name of the Windows File Explorer process. The actual process name is `explorer`, so the original command was missing the final letter `r`.

### Corrected Command

```powershell
Get-Process -Name explorer
```

### Result

The corrected command ran successfully and returned information for the `explorer` process, including its process ID, memory usage, and CPU time.

## Task 2: Add Debugging Output

### Example of Verbose Output

```text
VERBOSE: Step 1: Transcript logging has started.
VERBOSE: Step 2: Preparing resource group deployment information.
VERBOSE: Step 3: Sending the resource group creation request to Azure.
VERBOSE: Step 4: Azure confirmed the resource group operation.
VERBOSE: Final step: Completing the script and stopping the transcript.
```

The script successfully created the `lm2-emre-verbose-rg` resource group in Central US. Azure returned a provisioning state of `Succeeded`.

### Example of Debug Output

```text
DEBUG: Step 1: Transcript path was displayed.
DEBUG: Step 2: The resource group name and Azure location were displayed.
DEBUG: Step 3: New-AzResourceGroup was executed with ErrorAction Stop.
DEBUG: HTTP Method: PUT
DEBUG: Status Code: Created
DEBUG: Step 4: The command completed without a terminating error.
```

The debug test successfully created the `lm2-emre-debug-rg` resource group. The output included detailed authentication, HTTP request, HTTP response, and Azure command processing information.

### Observed Differences

Verbose output provided clear, high-level status messages that made it easy to follow the main steps of the script. Debug output provided much more technical information, including parameter values, authentication activity, HTTP requests, response status codes, and internal Azure module processing. Verbose output would be more useful for monitoring normal script execution, while debug output would be more useful when investigating a specific technical problem.
## Task 3: Create the First Pester Test

### Test Name

`Verifies that the resource group was created in Central US`

### Expected Result

The test was expected to locate the `lm2-emre-debug-rg` resource group and verify that its name was correct, its location was `centralus`, and its provisioning state was `Succeeded`.

### Actual Result

Pester successfully completed the test using version 6.1.0. The resource group matched all expected values, and the final result was:

```text
Tests Passed: 1
Tests Failed: 0
Tests Skipped: 0
Tests NotRun: 0