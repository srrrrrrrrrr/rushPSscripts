param($rgname, $name)

$vnetrule = Get-AzMariaDbVirtualNetworkRule -ResourceGroupName $rgname -ServerName $name
$vnetrulename = $vnetrule.name

$firewallrule = Get-AzResource -ResourceGroupName $rgname -ResourceType Microsoft.DBforMariaDB/servers/firewallRules -ResourceName $name -ApiVersion 2018-06-01
$firewallrulename = $firewallrule.name

if (($firewallrulename -ne $null) -and ($firewallrulename -notmatch "AllowAllWindowsAzureIps") -or ($vnetrulename -ne $null) )
{
Write-Output("The mariadb server "+ $name + " has the VNET/Firewall rules present in the server "+ $vnetrulename + " "+ $firewallrulename + ",so no action will be taken on this resource." )
}
  else
    {
        Write-Output("Public network access would be disabled for the mariadb server " + $name + ". As there is no Firewall/Vnet/Private Endpoint is present." )
        Set-AzResource -PropertyObject @{publicNetworkAccess="disabled"} -ResourceGroupName $rgname -ResourceType Microsoft.DBforMariaDB/servers -ResourceName $name -ApiVersion 2018-06-01 -Force
    }
