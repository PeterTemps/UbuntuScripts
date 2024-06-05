import argparse

from huggingface_hub import hf_hub_download, snapshot_download


def download_from_hub(repository, local_dir):
    snapshot_download(repository, local_dir=local_dir)


if __name__ == "__main__":
    # Parse command-line arguments
    parser = argparse.ArgumentParser(
        description="Download a repository from Hugging Face Hub"
    )
    # Add the arguments
    # The repository argument is a positional argument, which means it is required
    parser.add_argument(
        "repository", help="Name of the repository to download"
    )
    # The local_dir argument is a positional argument, which means it is required
    parser.add_argument(
        "local_dir",
        help="Local directory to save the downloaded files",
        default="./hf_hub/",
    )
    args = parser.parse_args()

    download_from_hub(args.repository, args.local_dir)
