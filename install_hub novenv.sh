pip install -U wheel setuptools black pip pipx

git config --global credential.helper store

# Install the Hugging Face Hub
python -m pip install huggingface_hub hf_transfer
huggingface-cli login
