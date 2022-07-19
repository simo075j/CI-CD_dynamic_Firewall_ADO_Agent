function Delete-AzureSqlDatabaseServerFirewallRule {
    param([String] [Parameter(Mandatory = $true)] $resourceGroupName,
    [String] [Parameter(Mandatory = $true)] $serverName,
    [String] [Parameter(Mandatory = $true)] $firewallRuleName)
    # add some error handling if this fails
    Remove-AzSqlServerFirewallRule -FirewallRuleName $firewallRuleName -ResourceGroupName $resourceGroupName -ServerName $serverName
    }
# Set variables
    $rgName = "<ResourceGroupName>"
    $fwname = "<FirewallName>" # if used in ADO pipeline refer to $(firewallName)
    $serverName = "<SQLserverName>"
# Call function to delete FW rule    
    Delete-AzureSqlDatabaseServerFirewallRule -resourceGroupName $rgName -serverName $serverName -firewallRuleName $fwname