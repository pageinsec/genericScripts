# Change password to default, known string for easy password reset, requires password change at next logon

# Require password change at next logon
Function Set-Password
{
    $user = Read-Host -Prompt 'Enter user name: '
    $pass = $user
    $username = Get-ADUser -Identity $user -Properties * | Select DisplayName
    Write-Host "User - "$username.DisplayName
    Write-Host "Change password for - $user"
    $check = Read-Host -Prompt 'y or n'
    if ($check -eq 'y')
    {
        Set-ADAccountPassword -Identity $user -Reset -NewPassword($pass | ConvertTo-SecureString -AsPlainText -Force)
        Set-ADUser $user -ChangePasswordAtLogon $true
        Write-Host "Password for "$username.DisplayName" - "$user" set to "$pass" and will require a password change at next logon."
    }
    else
    {
        Write-Host "Password for "$username.DisplayName" - "$user" not changed."
    }
}
    
# Change password to default, known string for easy password reset, do NOT require password change at next logon
# Use for Chromebooks
# Require password change at next logon
Function Set-ChromebookPassword
{
    $user = Read-Host -Prompt 'Enter user name: '
    $pass = $user
    $username = Get-ADUser -Identity $user -Properties * | Select DisplayName
    Write-Host "User - "$username.DisplayName
    Write-Host "Change password for - $user"
    $check = Read-Host -Prompt 'y or n'
    if ($check -eq 'y')
    {
        Set-ADAccountPassword -Identity $user -Reset -NewPassword($pass | ConvertTo-SecureString -AsPlainText -Force)
        Set-ADUser $user -ChangePasswordAtLogon $false
        Write-Host "Password for "$username.DisplayName" - "$user" set to "$pass" and will NOT require a password change at next logon."
    }
    else
    {
        Write-Host "Password for "$username.DisplayName" - "$user" not changed."
    }
}
