param($installPath, $toolsPath, $package, $project)

$libFolder = [System.IO.Path]::Combine($installPath, "lib");
$libFilePaths = [System.IO.Directory]::EnumerateFiles($libFolder, "*.dll", "TopDirectoryOnly");

$libFileNames = New-Object System.Collections.Generic.List[string];

foreach ($libFilePath in $libFilePaths)
{
    $libFileName = [System.IO.Path]::GetFileNameWithoutExtension($libFilePath);
    $libFileNames.Add($libFileName);
}

foreach ($reference in $project.Object.References)
{
    if ($libFileNames.Contains($reference.Name))
    {
        $reference.CopyLocal = $false;
    }
}