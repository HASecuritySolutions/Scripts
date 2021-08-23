if (Get-Module -ListAvailable -Name ActiveDirectory) {
    Write-Host "AD Module exists"
} else {
    Write-Host "ActiveDirectory PowerShell module does not exist"
    Write-Host "This script requires the ActiveDirectory module to function"
    Write-Host " "
    $user_input = Read-Host -Prompt 'Attempt to install module? (y/n)'
    $rsatAD = Get-WindowsFeature | Where {$_.Name -eq "RSAT-AD-Tools"}
    if ($user_input.ToLower() -eq "y" -or $user_input.ToLower() -eq "yes"){
      Write-Host "Attempting to install module"
      Install-WindowsFeature RSAT-AD-PowerShell
    } else {
      Write-Host "Stopping script. Please move to a machine with the ActiveDirectory module installed or install it manually"
      exit
    }
}

$output_folder = 'C:'
$domains = (Get-ADForest).domains
foreach ($domain in $domains){
    Get-GPOReport -All -Domain $domain -ReportType HTML -Path "$output_folder\$domain.html"
    Get-GPOReport -All -Domain $domain -ReportType HTML -Path "$output_folder\$domain.xml"
}
