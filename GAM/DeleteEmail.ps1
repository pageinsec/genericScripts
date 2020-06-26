# Purge email from G Suite using a GAM server

Function GAM-Delete-Mail ($recipient, $messageID) {
    # Pull current location
    $location = pwd

    if ($recipient -eq $null)
    {
      $recipient = Read-Host -Prompt 'Recipient: '
    }
    if ($messageID -eq $null)
    {
      $messageID = Read-Host -Prompt 'MessageID: '
    }
    
    # Change to correct directory
    cd C:\gamadv-xtd3 #Full path

    #GAM cmd to check for found message
    $messageCheck = gam user $recipient delete messages query "rfc822msgid:$messageID"
    Write-Host $messageCheck
    $continue = Read-Host -Prompt 'Continue with delete? Y/N: '
    if ($continue -eq 'Y')
    {
        gam user $recipient delete messages query "rfc822msgid:$messageID" doit
    } else
    {
        Write-Host "Message removal stopped."
    }

    #Go back where we were
    cd $location
}
