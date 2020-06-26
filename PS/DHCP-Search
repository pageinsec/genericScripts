# Search DHCP scope by computer name
# May require an elevated prompt

Function DHCP-Search 
{
    # Get computer name
    $compNAME = read-host "Enter full or partial computer name: "

    # Get DHCP servers and remove DR DHCP servers
    $dhcps = Get-DhcpServerInDC | where DnsName -match <servername>
    $dhcps
    # Loop through DHCP servers
    foreach ($dhcp in $dhcps)
    {
        $dhcpserver = $dhcp.DnsName
        echo $dhcpserver
        # Pull scope for DHCP server
        $allscope = Get-DhcpServerv4Scope -ComputerName $dhcpserver
        # Check each scope for computer
        foreach ($ScopeID in $allscope)
        {
            Get-DhcpServerv4Lease -ComputerName $dhcpserver -ScopeId $ScopeID.scopeid | where {$_.hostname -match "$compNAME"} | Select-Object AddressState, ClientId, ClientType, Hostname, IPAddress, ScopeId, ServerIP, LeaseExpiryTime | Format-Table -AutoSize
        }
    }
}
