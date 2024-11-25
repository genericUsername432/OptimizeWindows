echo "This will Delete Everything from your recycle bin, and temp folder ( No need to worry about temp folder)"
pause
$run = Read-Host -Prompt "RUN ? (Y/N)"


if ("Y" -eq $run)

{

    echo "Running Tweaks"
    # Disable Windows Telemetry

    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Force
    Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" | Select-Object AllowTelemetry
    # Clear Temp Folder
    $tempPath = $env:TEMP
    Get-ChildItem -Path $tempPath -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    Write-Host "Temp folder cleared: $tempPath" -ForegroundColor Green

    # Empty The Recycle Bin
    Clear-RecycleBin -Force

    # Confirmation Message
    Write-Host "Recycle Bin has been emptied." -ForegroundColor Green
    
    #Disable Windows Indexing
    sc stop “wsearch”
    #Use 1.1.1.1 And 8.8.8.8 As Default DNS

    Set-DnsClientServerAddress -InterfaceAlias Wi-Fi -ServerAddresses "1.1.1.1","8.8.8.8"
    
    #Disable Windows Consumer Features

    Set-ItemProperty -Path "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value 1 -Force
    
    #Disable Hibernation ( For PC only)

    powercfg.exe /hibernate off

    #Disable Tracking Features

    Set-ItemProperty -Path "HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\CapabilityAccessManager\\ConsentStore\\location" -Name "Value" -Value "Deny" -Force
    Set-ItemProperty -Path "HKLM:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Sensor\\Overrides\\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Value "0" -Force
    Set-ItemProperty -Path "HKLM:\\SYSTEM\\CurrentControlSet\\Services\\lfsvc\\Service\\Configuration" -Name "Status" -Value "0" -Force
    Set-ItemProperty -Path "HKLM:\\SYSTEM\\Maps" -Name "Value" -Value "0" -Force


}
pause
