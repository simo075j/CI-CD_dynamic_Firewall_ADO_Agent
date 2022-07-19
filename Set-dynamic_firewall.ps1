function Create-AzureSqlDatabaseServerFirewallRule {
    param([String] [Parameter(Mandatory = $true)] $resourceGroupName,
    [String] [Parameter(Mandatory = $true)] $serverName)
    $ip = Invoke-RestMethod http://ipinfo.io/json | Select-Object -exp ip
    # Do we need a range? If not use ip
    [hashtable] $IPRange = @{}
    $pattern = "([0-9]+)\.([0-9]+)\.([0-9]+)\."
    $regex = New-Object -TypeName System.Text.RegularExpressions.Regex -ArgumentList $pattern
    $ipRangePrefix = $regex.Match($ip).Groups[0].Value;
    $IPRange.StartIPAddress = $ipRangePrefix + '0'
    $IPRange.EndIPAddress = $ipRangePrefix + '255'
    $firewallRuleName = [System.Guid]::NewGuid().ToString()
    New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroupName -ServerName $serverName -FirewallRuleName $firewallRuleName -StartIpAddress $IPRange.StartIPAddress -EndIpAddress $IPRange.EndIPAddress
    return $firewallRuleName
    }
# Set variables
    $serverName = "<SQLserverName>"
    $rgName = "<ResourceGroupName>"
# Call function to set firewall rule   
    $fwname = (Create-AzureSqlDatabaseServerFirewallRule -resourceGroupName $rgName -serverName $serverName)[-1]
# Set firewall name in pipeline variable for later use        
    write-host "##vso[task.setvariable variable=firewallName;]$fwname"

