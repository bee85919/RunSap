### 실행 환경
Windows
[AS ABAP 7.52 Developer Edition](https://www.notion.so/bee-tion/ABAP-1e642d7d7a83477fb25504814c1a49d3)


### 개요

SAP GUI를 실행하기 위해서는 Oracle Vm VirtualBox의 Virtual Machine을 실행하고, npladm으로 로그인 한 뒤 startsap all 명령어를 실행하고, SAP GUI 실행파일을 실행해야 합니다. RunSap.ps1과 RunSap.bat은 이 과정을 도와주는 파일들입니다.


### 사용 방법

파일들을 다운로드 받아 같은 폴더에 압축을 풀고, RunSap.bat 파일의 바로가기 파일을 실행하면 일련의 과정들이 자동 실행되어 SAP GUI가 실행됩니다. 


### 준비

RunSap.ps1을 열어보면 변수 설정하는 부분이 있습니다. RunSap.bat 파일을 실행하기 전에 해당 변수들의 값이 올바르게 할당되어 있는지 확인해주셔야 합니다. 변수들의 목록은 다음과 같습니다. 

 -  vmFolder : Oracle Vm VirtualBox의 Virtual Box 폴더 경로
 -  vmName : Oracle Vm VirtualBox의 Virtual Machine 이름
 -  sapGui : SAP GUI 실행 파일 경로
 -  vmUser : npladm
 -  vmPassword : npladm 비밀 번호