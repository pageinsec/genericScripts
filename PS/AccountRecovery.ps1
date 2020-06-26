#Set server for email to use to create service desk ticket, etc.
Set-Variable -Name PSEmailServier -Value <IP>

#Function to generate new random password
Function New-SecurePassword {
$Password = ("!@#$%0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".tochararray() | sort {Get-Random})[0..9] -Join ''
$Password = $Password + "1zyx}!"
echo $Password
}

# Change password to random secure password
Function Reset-Password
{
    $user = Read-Host -Prompt 'Enter user name: '
    echo 'Are you sure you want to reset the password for:' $user
    $check = Read-Host -Prompt 'Y or N'
    if ($check -eq 'Y')
    {
        $pwd = New-SecurePassword
        Set-ADAccountPassword -Identity $user -Reset -NewPassword ($pwd | ConvertTo-SecureString -AsPlainText -Force)
    }
    else
    {
        echo 'Password for '$user' not reset.'
    }
}

# Initiate a logout and securepassword reset for user
Function Reset-User
{ 
    $anonUser = "anonymous"
    $anonPass = ConvertTo-SecureString "anonymous" -AsPlainText -Force
    $anonCred = New-Object System.Management.Automation.PSCredential($anonUser,$anonPass)

    Connect-AzureAD
    $batch = Read-Host -Prompt 'Single (s) or Batch (b)?'
    if ($batch -eq 'b')
    {
        $file = Read-Host -Prompt 'Enter file path to csv'
        $logout = import-csv $file
        echo 'Are you sure you want to reset the passwords and initiate AzureAD logouts for all users in:' $file
        $check = Read-Host -Prompt 'Y or N'
        if ($check -eq 'Y')
        {
            foreach($user in $logout)
            {
                $pwd = New-SecurePassword
                $reason = 'Account activity indicates account has been compromised.'
                $userEmail = $user.Email
                # Update DOMAIN
                Get-AzureADUser -ObjectId "$userEmail@DOMAIN" | Revoke-AzureADUserAllRefreshToken
                Set-ADAccountPassword -Identity $user -Reset -NewPassword ($pwd | ConvertTo-SecureString -AsPlainText -Force)
                #Update info for environment
                Send-MailMessage -From <email> -To <servicedeskemail> -Credential $anonCred -Subject '<subject>' -Port <port> -BodyAsHTML "Hello,<br><p>Account logout and password lockout have been done for the user below.</p><p>User: $user</p><p>Reason: $reason</p><p>Please contact <email> if you need additional information.</p><p>Thank you</><p><organization> Cyber Security</p>"      
            }      
        }
        else
        {
            echo 'Reset cancelled'
        }
    }
            
    else
    {
        $user = Read-Host -Prompt 'Enter user name: '
        $username = Get-ADUser -Identity $user -Properties * | Select DisplayName
        Write-Host "User - "$username.DisplayName
        Write-Host "Change password and initiate AzureAD logouts for - $user"
        $check = Read-Host -Prompt 'Y or N'
        if ($check -eq 'Y')
        {
            $pwd = New-SecurePassword
            Get-AzureADUser -ObjectId "$user@DOMAIN" | Revoke-AzureADUserAllRefreshToken
            Set-ADAccountPassword -Identity $user -Reset -NewPassword ($pwd | ConvertTo-SecureString -AsPlainText -Force)
            #$reason = Read-Host -Prompt 'Reason for lockout: '
            # Update details for environment
            Send-MailMessage -From <email> -To <servicedeskemail> -Credential $anonCred -Subject '<subject>' -Port <port> -BodyAsHTML "Hello,<br><p>Account logout and password lockout have been done for the user below.</p><p>User: $user</p><p>Reason: $reason</p><p>Please contact <email> if you need additional information.</p><p>Thank you</><p><organization> Cyber Security</p>"      
        }
        else
        {
            echo 'Reset cancelled'
        }

    }   
}

#Revoke Azure AD sessions, use with Set-Password if walking a user through account reset
Function Revoke-AD
{
    Connect-AzureAD
    $user = Read-Host -Prompt 'Enter user name: '
    $username = Get-ADUser -Identity $user -Properties * | Select DisplayName
    Write-Host "User - "$username.DisplayName
    Write-Host "Revoke Azure AD sessions for - $user"
    $check = Read-Host -Prompt 'y or n'
    if ($check -eq 'y')
    {
        Get-AzureADUser -ObjectId "$user@DOMAIN" | Revoke-AzureADUserAllRefreshToken
        Write-Host "Azure AD sessions for "$username.DisplayName" - "$user" revoked."
    }
    else
    {
        Write-Host "Azure AD sessions for "$username.DisplayName" - "$user" not revoked."
    }
}
