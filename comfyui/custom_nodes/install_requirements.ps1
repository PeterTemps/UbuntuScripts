# Get all subdirectories in the current directory and install the requirements.txt

$directories = Get-ChildItem -Directory

foreach ($dir in $directories) {
    Write-Host "Installing requirements for $($dir.Name)"
    pip install -r "$($dir.FullName)\requirements.txt"
}