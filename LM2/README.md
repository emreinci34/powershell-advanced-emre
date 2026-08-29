# LM2: Testing, Debugging, and Source Control

## Project Purpose

This project demonstrates how testing, debugging, and source control can improve the reliability and maintainability of PowerShell automation. I updated my Azure resource group script to provide verbose and debug output, corrected a PowerShell process-name error, created an automated Pester test, and tracked the completed work with Git and GitHub.

## Files Included

- `lm2-lab.md` – Documents the corrected PowerShell command, verbose and debug output, observed differences, and Pester test results.
- `create-resourcegroup.tests.ps1` – Contains a Pester test that verifies the Azure resource group name, location, and provisioning state.
- `../LM1/create-resourcegroup.ps1` – Updated Azure resource group script containing `Write-Verbose`, `Write-Debug`, error handling, and transcript logging.
- `../LM1/Logs/` – Contains transcripts from the verbose and debug script executions.

## Lessons Learned

During this lab, I learned that small errors such as an incorrect process name can be identified by carefully reading the error message and finding the root cause. Verbose output provides useful high-level progress information, while debug output exposes detailed technical information that can help investigate complex failures. I also learned how Pester can automatically verify that an Azure resource was created with the expected configuration. Git and GitHub provide a clear history of these changes and make the project easier to maintain.