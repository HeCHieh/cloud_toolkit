; Cloud Toolkit Windows Installer Script
; Run with Inno Setup: iscc installer.iss

[Setup]
AppName=Cloud Toolkit
AppVersion=1.0.0
AppPublisher=Cloud Toolkit
DefaultDirName={autopf}\Cloud Toolkit
DefaultGroupName=Cloud Toolkit
OutputBaseFilename=cloud-toolkit-setup
Compression=lzma2
SolidCompression=yes
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

[Files]
Source: "build\windows\x64\release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\Cloud Toolkit"; Filename: "{app}\cloud_toolkit.exe"
Name: "{commondesktop}\Cloud Toolkit"; Filename: "{app}\cloud_toolkit.exe"

[Run]
Filename: "{app}\cloud_toolkit.exe"; Description: "Launch Cloud Toolkit"; Flags: postinstall nowait

[Messages]
WelcomeLabel2=This will install Cloud Toolkit on your computer.
