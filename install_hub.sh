# check if venv is activated, if not check if it exists and activate it, if not create it

# check if venv is activated
if [ -z "$VIRTUAL_ENV" ]; then
    # check if venv exists
    if [ -d "venv" ]; then
        # activate venv
        echo "Activating the existing venv..."
        . venv/bin/activate
    else
        # create venv
        echo "Creating a new venv..."
        python3 -m venv venv && . venv/bin/activate && pip install -U wheel setuptools black
    fi
fi

# Install the Hugging Face Hub
python -m pip install huggingface_hub
huggingface-cli login