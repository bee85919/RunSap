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

### VirtualBox가 완전히 실행되기를 대기 (10초)
Start-Sleep -Seconds 10

### ABAP 가상환경 실행
Start-Process "$vmFolder\VBoxManage.exe" -ArgumentList "startvm `"$vmName`" --type headless"
Write-Output "VM `"$vmName`" Started..."

### 가상 환경이 완전히 부팅되기를 대기 (30초)
Start-Sleep -Seconds 30
Write-Output "VM `"$vmName`" Started..."

### Plink를 사용하여 가상 머신 내에서 명령어 실행
$startCommand = "& `"$plinkPath`" -pw $vmPassword -P $sshPort $vmUser@$vmHost startsap all"
Invoke-Expression $startCommand
Write-Output "SAP Server Started..."

### SAP GUI 실행
Start-Process "$sapGui"
Write-Output "SAP GUI Started..."

### 사용자 입력 대기
$stopInstance = Read-Host "Do you want to stop the SAP instance? (y/n)"
if ($stopInstance -eq 'y') {
    $stopCommand = "& `"$plinkPath`" -pw $vmPassword -P $sshPort $vmUser@$vmHost stopsap"
    Invoke-Expression $stopCommand
    Write-Output "SAP Server Stopped..."
} else {
    Write-Output "SAP Server continues to run..."
}
