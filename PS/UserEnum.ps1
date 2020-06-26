#Function to get user details
Function User-Details ($enduser) {
    if ($enduser -eq $null)
    {
    $enduser = Read-Host -Prompt 'User: '
    }
    #Adjust properties to fit your needs
    Get-ADUser $enduser -Property Name,MemberOf,PasswordLastSet,LastLogonDate
}

#Function to get group members in alpha order
Function Group-Members ($groupID) {
    if ($groupID -eq $null)
    {
    $groupID = Read-Host -Prompt 'Group: '
    }
    Get-ADGroupMember -Identity $groupID | Select-Object Name | Sort-Object Name
}

#Check for group membership for a single user
Function User-InGroup ($enduser, $groupID) {
    if ($enduser -eq $null)
    {
    $enduser = Read-Host -Prompt 'User: '
    }
    if ($groupID -eq $null)
    {
    $groupID = Read-Host -Prompt 'Group: '
    }
    $members = Get-ADGroupMember -Identity $groupID -Recursive | Select -ExpandProperty SamAccountName
    if ($members -contains $enduser)
    {
    Write-Host "$enduser is in $groupID"
    } else
    {
    Write-Host "$enduser is NOT in $groupID"
    }
}

#Check multiple users for group
Function Group-HasMembers {
    [string[]]$_userList=@()
    $_userList = Read-Host -Prompt 'Users separated by space: '
    $_userList = $_userList.Split(',').Split(' ') 
    $group = Read-Host -Prompt 'Group: '
    $members = Get-ADGroupMember -Identity $group -Recursive | Select -ExpandProperty SamAccountName
    foreach ($user in $_userList) {
        if ($members -contains $user)
        {
            Write-Host "$user is in $group"
        }
    }
}
