# use wget with --content-disposition to download the models from models_url.txt to models/ directory in the current directory (pwd)

# Download the models
wget --content-disposition -i models_url.txt -P models/

# Check if the models have been downloaded
if [ -d "models" ]; then
    echo "Models have been downloaded successfully."
else
    echo "Failed to download the models."
fi