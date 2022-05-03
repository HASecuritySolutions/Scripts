# Check if PowerShell v2.0 is installed
if ( (Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2).State -eq "Enabled" ) {
    # If installed, disable it
    Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2 | Out-Null
}
