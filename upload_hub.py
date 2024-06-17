# upload files and folders to huggingface hub using huggingface_hub library.
# command line arguments are used to specify the local path and the path in the repo.
# check if local_path and path_in_repo are provided.
# check if local_path exists.
# The repo_id is hardcoded in the script.
# Usage: python upload_hub.py --local_path ./test/ --path_in_repo test/

import argparse
import os

from huggingface_hub import HfApi

parser = argparse.ArgumentParser()
parser.add_argument("--local_path", type=str, required=True)
parser.add_argument("--path_in_repo", type=str, required=True)
args = parser.parse_args()

if not os.path.exists(args.local_path):
    raise FileNotFoundError(f"{args.local_path} does not exist")

LOCAL_PATH = args.local_path
PATH_IN_REPO = args.path_in_repo
REPO_ID = "robertfag2/ComfyUI"


print("Uploading to huggingface hub...")
api = HfApi()

print(f"Uploading {LOCAL_PATH} to {REPO_ID}")

result = api.upload_folder(
    folder_path=LOCAL_PATH,
    repo_id=REPO_ID,
    path_in_repo=PATH_IN_REPO,
    repo_type="model",
)

print(result)
