$fileInput = New-Object System.IO.StreamReader(".\path.txt")
$lineNumber = 0
$copyFolder = ".\output_" + (Get-Date).ToString('yyyyMMddhhmmss')
while (($line = $fileInput.ReadLine()) -ne $null)
{
	if([string]::IsNullOrEmpty($line)){
		continue
	}
    $pFile = Split-Path -Path "$line" -NoQualifier
	$pFolder = Split-Path -Path "$pFile"  
	
	$pFolder = $copyFolder + $pFolder
	if(!(Test-Path -Path $pFolder)){ 	
		New-Item -Path "$pFolder" -ItemType Directory  
	}
	Copy-Item "$line" "$pFolder" -Recurse -force
	Write-Host "$pFolder"
    $lineNumber++
}
$fileInput.Dispose()
Write-Host "copy :$lineNumber file"
pause