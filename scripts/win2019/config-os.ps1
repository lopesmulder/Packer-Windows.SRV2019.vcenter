# Windows 2019 - Customise OS

$ErrorActionPreference = "Stop"

#Disable Windows Admin Center Pop-up in Server Manager
Write-Host "Disable Windows Admin Center Pop-up in Server Manager"
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ServerManager" -Name "DoNotPopWACConsoleAtSMLaunch" -Value 1 -PropertyType DWord | Out-Null

# Enable RDP Connections
Write-Host "Enable RDP Connections"
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections -Type DWord -Value 0 | Out-Null
Enable-NetFirewallRule -DisplayGroup "Remote Desktop" | Out-Null

# Create C:\Temp
Write-Host "Create C:\Temp"
New-Item -Path C:\Temp -ItemType Directory | Out-Null

# Disable VMware Tools System Tray Icon
Write-Host "Disable VMware Tools icon in System Tray"
Set-ItemProperty -Path 'HKLM:\SOFTWARE\VMware, Inc.\VMware Tools' -Name 'ShowTray' -Value 0 | Out-Null

# Enable Firewall
Write-Host "Enable Windows Firewall"
netsh Advfirewall set allprofiles state on

# Clear Event Logs
Write-Host "Clear Event Logs"
Get-EventLog -LogName * | ForEach-Object { Clear-EventLog -LogName $_.Log } -Verbose | Out-Null
