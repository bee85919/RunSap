@echo off
:: RunSap.ps1 실행을 위한 배치 스크립트


set scriptPath="%~dp0RunSap.ps1"


:: RunSap.ps1 경로 확인
echo RunSap.ps1 Path : %scriptPath%


:: 관리자 권한 확인
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    :: 관리자 권한이 아닐 때 관리자 권한으로 재시작
    echo Administrator privileges are required. Restarting with administrator privileges...
    powershell.exe -Command "Start-Process cmd -ArgumentList '/c %~dp0%~nx0' -Verb RunAs"
    exit /b
)
echo Administrator privileges confirmed.


:: RunSap.ps1 실행
powershell.exe -NoProfile -ExecutionPolicy Bypass -File %scriptPath%
echo Start %scriptPath%