####################################################################
# Connect_Intune_v1.0.ps1 by Christoph Mehren - https://www.cmehren.de/2019/06/26/intune-powershell-ueber-graph-api/ (23.06.19)
# Info:
#       - Installs Graph API Module
#       - initiates Admin consent
#       - connect to MSGraph
#
#   To get a list of commands for Intune run: 
#   get-command -Module Microsoft.Graph.Intune
# 
#   more Infos at: https://github.com/microsoft/Intune-PowerShell-SDK
####################################################################


# Install Graph API  Module
If ((get-module -ListAvailable -Name Microsoft.Graph.Intune) -eq $null){
    write-host "Installing Module: Microsoft.Graph.Intune"
    
    Install-Module -Name Microsoft.Graph.Intune -force
   
}


# Provide consent if needed (interactive prompt is needed)
write-host "`n"
write-host "`n"
$Adminconsent= Read-Host  -prompt "Admin consent already done? (Y/n)"
switch ($Adminconsent) {
    y {}

    n {Connect-MSGraph -AdminConsent}

    Default {}
}


# Ask for credentials
$UPN= Read-host -Prompt "Enter UPN: "
$PW= Read-host -AsSecureString -Prompt "Enter password: "
$cred = New-Object System.Management.Automation.PSCredential ($UPN, $PW)


# Connect to MSGraph
$connection = Connect-MSGraph -PSCredential $cred


# Output connection details
write-host "`n"
if ($connection){write-host "connected sccessfull"}
$connection
