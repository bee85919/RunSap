### RunSap.ps1


### 변수 설정
$vmFolder   = "C:\Program Files\Oracle\VirtualBox"  # Virtual Box 폴더 경로
$vmName     = "ABAP"                                # Virtual Machine 이름
$sapGui     = "C:\Program Files (x86)\SAP\FrontEnd\SAPgui\saplogon.exe"  # SAP GUI 실행 파일 경로
$vmUser     = "npladm"                              # npladm
$vmPassword = "Down1oad"                            # npladm 비밀번호
$plinkPath  = "C:\Program Files\PuTTY\plink.exe"    # Plink 실행 파일 경로
$sshPort    = 22                                    # SSH 포트
$vmHost     = "127.0.0.1"                           # 가상 머신 호스트 (IP 주소 또는 호스트 이름)


### Oracle VM VirtualBox 실행
Start-Process "$vmFolder\VirtualBox.exe"
Write-Output "Oracle VM VirtualBox Started..."


### Oracle VM VirtualBox 실행 대기 (5초)
Start-Sleep -Seconds 5


### openSUSE 실행
Start-Process "$vmFolder\VBoxManage.exe" -ArgumentList "startvm `"$vmName`" --type headless"
Write-Output "OpenSUSE Started..."


### openSUSE 실행 대기 (5초)
Start-Sleep -Seconds 5
Write-Output "VM $vmName Started..."


### Plink를 사용하여 가상 머신 내에서 명령어 실행
$startCommand = "& `"$plinkPath`" -pw $vmPassword -P $sshPort $vmUser@$vmHost startsap all; echo `"SAP Server Started`""
Invoke-Expression $startCommand


### SAP GUI 실행
Start-Process "$sapGui"
Write-Output "SAP GUI Started..."


### 사용자 입력 및 종료
do {
    $stopInstance = Read-Host "Do you want to stop the SAP instance? (Press 'y')"
    if ($stopInstance -eq 'y') {
        $stopCommand = "& `"$plinkPath`" -pw $vmPassword -P $sshPort $vmUser@$vmHost stopsap"
        Invoke-Expression $stopCommand
        Write-Output "SAP Server Turned off..."

        ### OpenSUSE 종료
        Start-Process "$vmFolder\VBoxManage.exe" -ArgumentList "controlvm `"$vmName`" poweroff"
        Write-Output "VM `"$vmName`" Turned off..."

        ### VirtualBox 종료
        Stop-process -name VirtualBox
        Write-Output "Oracle VM VirtualBox Turned off..."
        break
    }
} while ($stopInstance -ne 'y')
