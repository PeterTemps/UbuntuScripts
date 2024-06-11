# use git clone to clone all GitHub repos from comfyui_plugins.txt

# check if comfyui_plugins.txt file exists
if (-not (Test-Path "comfyui_plugins.txt")) {
  Write-Host "comfyui_plugins.txt file does not exist. Please create it and run the script again."
  exit 1
}

# read comfyui_plugins.txt file line by line and clone the GitHub repos to plugins_directory

$plugins = Get-Content "comfyui_plugins.txt"
foreach ($line in $plugins) {
  # clone the GitHub repo
  git clone --depth 1 $line
}
