#PS script to check CSV from Have I Been Pwned for existing AD users with passwords over a specified age
#Change directory,file names, and age as appropriate

cd ./HIBP
$pwned = import-csv .\pwnedEmailAccounts.csv
$pwdDate = (Get-Date).AddDays(-180).ToFileTime()
foreach($user in $pwned)
{
    $userEmail = $user.Email
    $account = Get-ADUser -Filter {mail -eq $userEmail} -Properties pwdLastSet | Where {$_.pwdlastset -lt $pwdDate}
    if ($account)
    {
        #Write-Host "User '$($user.Email)' exists in AD and has a password older than 1 year."
        Out-File -InputObject "$($user.Email)" -FilePath ./existsPWDAGE.csv -Append
    }
    else
    {
        #Write-Host "User '$($user.Email)' does not exist in AD."
        Out-File -InputObject "user '$($user.Email)' does not exist in AD." -FilePath ./not.txt -Append
    }
}
cd ..
