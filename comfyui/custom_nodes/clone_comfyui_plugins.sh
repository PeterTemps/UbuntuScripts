# use git clone to clone all github repos from comfyui_plugins.txt 

# check if comfyui_plugins.txt file exists
if [ ! -f "comfyui_plugins.txt" ]; then
  echo "comfyui_plugins.txt file does not exist. Please create it and run the script again."
  exit 1
fi

# read comfyui_plugins.txt file line by line and clone the github repos to plugins_directory

while IFS= read -r line
do
  # clone the github repo
  git clone $line 
done < comfyui_plugins.txt
