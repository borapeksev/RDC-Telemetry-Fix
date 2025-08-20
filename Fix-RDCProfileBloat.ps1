<#
.SYNOPSIS
Remediates bloated user profiles caused by MSI Remote Desktop Client telemetry.

.DESCRIPTION
This script iterates through all local user profiles, removes the DiagConnectionCache registry key,
and disables EnableMSRDCTelemetry to prevent future bloating of ntuser.dat.

.NOTES
Test before running in production. Run as Administrator.
#>

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"

$sids = Get-ChildItem -Path $regPath

$excludedUsers = @('DefaultAccount','WDAGUtilityAccount','Werther','administrator')

foreach ($sid in $sids) {

    $profilePath = (Get-ItemProperty -Path $sid.PSPath).ProfileImagePath

    if ($profilePath) {

        $userName = Split-Path -Leaf $profilePath

        if ($excludedUsers -notcontains $userName) {

            $userSid = $sid.PSChildName
            Write-Output "Processing user: $userName (SID: $userSid)"

            # Remove DiagConnectionCache
            $rdcRegCache = "Registry::HKEY_USERS\$userSid\Software\Microsoft\RdClientRadc\DiagConnectionCache"
            if (Test-Path $rdcRegCache) { 
                Remove-Item -Path $rdcRegCache -Recurse -Force
                Write-Output "Removed: $rdcRegCache"
            } else {
                Write-Output "Not found: $rdcRegCache"
            }

            # Disable telemetry
            $rdcRegRoot = "Registry::HKEY_USERS\$userSid\Software\Microsoft\RdClientRadc"
            if (Test-Path $rdcRegRoot) {
                Set-ItemProperty -Path $rdcRegRoot -Name "EnableMSRDCTelemetry" -Value 0
                Write-Output "Telemetry disabled: $rdcRegRoot"
            } else {
                Write-Output "Not found: $rdcRegRoot"
            }

        }

    }

}

Write-Output "Script completed."
