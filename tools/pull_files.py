"""
Script to pull changed files in a Pull Request using a GET request to the
GitHub API.

This script initially adopted from The Turing Way from in October 2020.
doi:10.5281/zenodo.3233853
https://github.com/alan-turing-institute/the-turing-way/blob/af98c94/tests/pull_files.py

"""
import argparse

import requests


def parse_args():
    """Construct the command line interface for the script"""
    DESCRIPTION = (
        "Script to pull changed files in a Pull Request using a GET request to the GitHub API."
    )
    parser = argparse.ArgumentParser(description=DESCRIPTION)

    parser.add_argument(
        "--pull-request",
        type=str,
        default=None,
        help="If the script is be run on files changed by a pull request, parse the PR number",
    )

    return parser.parse_args()


def get_files_from_pr(pr_num: str) -> list:
    """Return a list of changed files from a GitHub Pull Request

    Arguments:
        pr_num -- Pull Request number to get modified files from

    Returns:
        List of modified filenames
    """
    pr_url = f"https://api.github.com/repos/bids-standard/bids-starter-kit/pulls/{pr_num}/files"
    resp = requests.get(pr_url)

    return [item["filename"] for item in resp.json()]


def filter_files(pr_num: str, start_phrase="src") -> list:
    """Filter modified files from a Pull Request by a start phrase

    Arguments:
        pr_num -- Number of the Pull Request to get modified files from

    Keyword Arguments:
        start_phrase -- Start phrase to filter changed files by
                        (default: {"src"})

    Returns:
        List of filenames that begin with the desired start phrase
    """
    files = get_files_from_pr(pr_num)
    return [filename for filename in files if filename.startswith(start_phrase)]


if __name__ == "__main__":
    args = parse_args()
    changed_files = filter_files(args.pull_request)
    print(changed_files)
