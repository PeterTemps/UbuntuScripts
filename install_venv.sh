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

# Install packages from requirements.txt
pip install -r requirements.txt

