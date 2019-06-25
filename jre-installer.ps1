$error.Clear()
$ErrorActionPreference = 'SilentlyContinue'
Get-Command java | SELECT Name >$null 2>&1
if ($error.Count -gt 0) {
    echo "will install java"
    [Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
    echo "getting URL for download"
    $URL=(Invoke-WebRequest -UseBasicParsing https://www.java.com/en/download/manual.jsp).Content | %{[regex]::matches($_, '(?:<a title="Download Java software for Windows Offline" href=")(.*)(?:">)').Groups[1].Value}
    echo "downloading from: $URL"
    Invoke-WebRequest -UseBasicParsing -OutFile jre8.exe $URL
    echo "installing"
    Start-Process .\jre8.exe '/s REBOOT=0 SPONSORS=0 AUTO_UPDATE=0' -wait
    echo "deleting downloaded file"
    Remove-Item -Path jre8.exe
    "installation completed"
}
else {
    echo "java already exists"
}
