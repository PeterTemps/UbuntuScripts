# using wget or aria2c to download urls from civitai.txt, ask user to select wget or aria2c, check if wget or aria2c is installed, if not, install it, download files using content-disposition to get the filename.

# ask user to select wget or aria2c
echo "Please select the downloader you want to use: 1. wget 2. aria2c"
read downloader
if [ $downloader -eq 1 ]; then
    downloader="wget"
    package="wget"
    # extra options for wget: none
    extra_options = ""

elif [ $downloader -eq 2 ]; then
    downloader="aria2c"
    package="aria2"
    # extra options for aria2c: -x 16 -s 16
    extra_options = "-x 16 -s 16"
else
    echo "Invalid input, please try again."
    exit 1
fi

# check if wget or aria2c is installed
if ! command -v $downloader &> /dev/null; then
    echo "$downloader is not installed, installing $downloader..."
    sudo apt-get install $package
fi

# download files using content-disposition to get the filename
while IFS= read -r url; do
    echo "Downloading $url..."
    $downloader --content-disposition $extra_options $url
done < civitai.txt

