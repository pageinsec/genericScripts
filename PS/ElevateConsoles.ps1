#Function to elevate ISE to admin prompt
Function ISE-Admin {
    Start-Process powershell_ise -Verb RunAs
    Exit
}

#Function to elevate PS to admin prompt
Function PS-Admin {
    Start-Process powershell -Verb RunAs
}

#Function to run CMD prompt as admin
Function CMD-Admin {
    Start-Process cmd -Verb RunAs
}
