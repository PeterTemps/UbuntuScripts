# enter all the subdirectories in current directory and pip install the requirements.txt

for dir in */; do
    echo "Installing requirements for $dir"
    pip install -r $dir/requirements.txt
done