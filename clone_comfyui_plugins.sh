# use git clone to clone github repo urls from comfyui_plugins.txt file to comfyui/custom_nodes folder in the current directory 


# check if comfyui/custom_nodes folder exists
if [ ! -d "comfyui/custom_nodes" ]; then
  echo "comfyui/custom_nodes folder does not exist. Please create it and run the script again."
  exit 1
fi

# check if comfyui_plugins.txt file exists
if [ ! -f "comfyui_plugins.txt" ]; then
  echo "comfyui_plugins.txt file does not exist. Please create it and run the script again."
  exit 1
fi

# read comfyui_plugins.txt file line by line and clone the github repo urls to comfyui/custom_nodes folder
while IFS= read -r line
do
  git clone $line comfyui/custom_nodes
done < comfyui_plugins.txt

echo "All plugins cloned successfully."
