; Cloud Toolkit Windows Installer
[Setup]
AppName=Cloud Toolkit
AppVersion=1.0.0
AppVerName=Cloud Toolkit 1.0.0
AppPublisher=Cloud Toolkit
DefaultDirName={autopf}\Cloud Toolkit
DefaultGroupName=Cloud Toolkit
OutputBaseFilename=cloud-toolkit-windows
OutputDir=output
Compression=lzma2
SolidCompression=yes
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
 
[Files]
Source: "build\\windows\\runner\\Release\\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs
 
[Icons]
Name: "{group}\Cloud Toolkit"; Filename: "{app}\cloud_toolkit.exe"
Name: "{commondesktop}\Cloud Toolkit"; Filename: "{app}\cloud_toolkit.exe"
 
[Run]
Filename: "{app}\cloud_toolkit.exe"; Description: "Launch Cloud Toolkit"; Flags: postinstall nowait

