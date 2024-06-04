# PowerShell Script to automate the process


### 변수 설정
$vmFolder   = "C:\Program Files\Oracle\VirtualBox" # Virtual Box 폴더 경로
$vmName     = "ABAP"                               # Virtual Machine 이름
$sapGui     = "C:\Program Files (x86)\SAP\FrontEnd\SAPgui\saplogon.exe"  # SAP GUI 실행 파일 경로
$vmUser     = "npladm"                             # npladm
$vmPassword = "Down1oad"                           # npladm 비밀 번호


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


### 가상 머신 내에서 명령어 실행
Start-Process "$vmFolder\VBoxManage.exe" -ArgumentList "guestcontrol `"$vmName`" run --username `$vmUser` --password `$vmPassword` --exe `/bin/sh` -- -c `"su - npladm -c 'Down1oad; startsap all'`""
Write-Output "SAP Server Started..."


### SAP GUI 실행
Start-Process "$sapGui"


Write-Output "SAP GUI Started..."