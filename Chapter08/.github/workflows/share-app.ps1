param(
    [string]
    $TenantId,
    [string]
    $ApplicationId,   
    [string]
    $ClientSecret,
    [string]
    $EnvironmentDisplayName,
    [string]
    $SolutionName,
    [string]
    $GroupID
)

#Modules for Power Apps Powershell Commands
Install-Module -Name Microsoft.PowerApps.Administration.PowerShell -Force
Install-Module -Name Microsoft.PowerApps.PowerShell -AllowClobber -Force

Add-PowerAppsAccount -Endpoint "prod" `
    -TenantID $TenantId `
    -ClientSecret $ClientSecret  `
    -ApplicationId $ApplicationId 

$environments = Get-AdminPowerAppEnvironment -Filter "$EnvironmentDisplayName*"
if($environments -ne $null)
{
    $EnvironmentName = $environments[0].EnvironmentName
}

Write-Host "EnvironmentName: $EnvironmentName"

$powerapps = Get-AdminPowerApp *$SolutionName* -EnvironmentName $EnvironmentName

if($powerapps -ne $null)
{
    foreach($powerapp in $powerapps)
    {
        Write-Host "DisplayName: $($powerapp.DisplayName)"
        if ($powerapp.DisplayName -eq "$SolutionName")
        {
		    $AppName=$powerapp.AppName
		    break
        }
    }
}
Write-Host "AppName: $AppName"

# add assignment to TestGroup (it will be the admin group)
Set-AdminPowerAppRoleAssignment -PrincipalType "Group" `
    -PrincipalObjectId $GroupID `
    -RoleName CanView -AppName $AppName -EnvironmentName $EnvironmentName