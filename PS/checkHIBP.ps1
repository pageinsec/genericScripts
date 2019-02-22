#PS script to check CSV from Have I Been Pwned for existing AD users
#Change directory and file names as appropriate

cd ./HIBP 
$pwned = import-csv .\pwnedEmailAccounts.csv

foreach($user in $pwned)
{
    $userEmail = $user.Email
    $account = Get-ADUser -Filter {mail -eq $userEmail}
    if ($account)
    {
        Out-File -InputObject "$($user.Email)" -FilePath ./exists.csv -Append
    }
    else
    {
        Out-File -InputObject "$($user.Email)" -FilePath ./not.csv -Append
    }
}
cd ..
