$HostName = $Env:SftpMdHostName
$UserName = $Env:SftpMdUserName
$Protocol = "Sftp"
$LocalPath = "..\snaker1985"
$RemotePath = "/public/sites/snaker.mvanvuren.nl"
$SiteRemote = "https://snaker.mvanvuren.nl"

Import-Module WinSCP

$credential = Get-Credential $UserName
$sessionOption = New-WinSCPSessionOption -HostName $HostName -Protocol $Protocol -Credential $credential
$fingerPrint = Get-WinSCPHostKeyFingerprint -SessionOption $sessionOption -Algorithm SHA-256
$sessionOption.SshHostKeyFingerprint = $fingerPrint
$session = New-WinSCPSession -SessionOption $sessionOption

Sync-WinSCPPath -WinSCPSession $session -RemotePath $RemotePath -LocalPath $LocalPath -Mode Remote -Remove:$true

Remove-WinSCPSession -WinSCPSession $session

Start-Process $SiteRemote
