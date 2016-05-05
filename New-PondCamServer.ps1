New-NanoServerImage -DeploymentType Guest -Edition Standard -MediaPath K:\ -BasePath U:\iso\web-02 -TargetPath 'U:\Hyper-V\Virtual Hard Disks\Web-02.vhdx' -ComputerName web-02 -EnableRemoteManagementPort

$cred = Get-Credential ~\administrator
$session = New-PSSession -ComputerName 10.101.2.128 -Credential $cred
$cim = New-CIMSession -ComputerName 10.101.2.128 -Credential $cred
$nodePath = 'C:\Program Files\nodejs'
$app = "N:\Documents\src\pondcam\*"

New-NetFirewallRule -cimsession $cim -Name "Webserver" -DisplayName "Web Server" -Description "Node.js Web Server for PondCam" -Profile Any -Direction Inbound -LocalPort 3000 -Program c:\nodejs\node.exe -Protocol TCP
New-NetFirewallRule -cimsession $cim -Name "Websocket" -DisplayName "Web Socket" -Description "Node.js Web Socket for PondCam Stream" -Profile Any -Direction Inbound -LocalPort 9999 -Program c:\nodejs\node.exe -Protocol TCP

Copy-Item -ToSession $session -Path $nodePath -Destination "C:\" -Recurse -Force
Invoke-Command -Session $session -ScriptBlock{
    $env:path += ";C:\nodejs";
    setx PATH $env:PATH /M
}

Copy-Item -ToSession $session -Path $app -Destination "c:\app" -Recurse -Force
