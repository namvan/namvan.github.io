param (
    # name of the output image
    [string]$title = ''
)

$fulldate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$onlydate = Get-Date -Format "yyyy-MM-dd"
if ($title -eq "")
{
	$title = Get-Date -Format "yyyy_MM_dd_HH_mm_ss"
}
	
$content = Get-Content -Path "2000-01-01-Sample.md"
$textInfo = (Get-Culture).TextInfo

$content = $content.replace("#Title#", $textInfo.ToTitleCase($title))
$content = $content.replace("#datetime#", $fulldate)
$filename = $title.replace(" ", "-")
$filepath = "_posts\\$onlydate-$filename.md"

Write-Host "Generated ==> $filepath"
Set-Content -Path $filepath -Value $content