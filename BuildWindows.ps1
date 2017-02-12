Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

#download gsl-master.zip from repo
$url = "https://github.com/ampl/gsl/archive/master.zip"
$output = "gsl-master.zip"

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)




if(Test-Path "gsl-x86")
{Remove-Item "gsl-x86" -Recurse -Force}

if(Test-Path "gsl-x64")
{Remove-Item "gsl-x64" -Recurse -Force}

Unzip "gsl-master.zip" $PSScriptRoot
Rename-Item -path "gsl-master" -newName "gsl-x86"

Unzip "gsl-master.zip" $PSScriptRoot
Rename-Item -path "gsl-master" -newName "gsl-x64"