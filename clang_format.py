#!/usr/bin/env python3
"""
clang_format.py

Recursively runs clang-format on all C/C++ source files in a codebase (single-threaded).
Usage:
    python3 clang_format.py [--path PATH] [--extensions .c .cpp .h ...] [--dry-run] [--clang-args "-style=Google"]
"""

import os
import subprocess
import argparse


def find_source_files(root, extensions):
    """
    Walk through the directory tree starting at root,
    yielding file paths that end with one of the given extensions.
    """
    for dirpath, dirnames, filenames in os.walk(root):
        for filename in filenames:
            if any(filename.endswith(ext) for ext in extensions):
                yield os.path.join(dirpath, filename)


def run_clang_format(file_path, clang_format_args, dry_run=False):
    """
    Run clang-format on a single file.
    If dry_run is True, only prints the command.
    """
    cmd = ["clang-format", "-i"] + clang_format_args + [file_path]
    if dry_run:
        print("Would run:", " ".join(cmd))
        return
    try:
        subprocess.run(cmd, check=True)
        print("Formatted:", file_path)
    except subprocess.CalledProcessError as e:
        print(f"Error formatting {file_path}:", e)


def main():
    parser = argparse.ArgumentParser(
        description="Recursively run clang-format on all C/C++ sources in a codebase."
    )
    parser.add_argument(
        "--path",
        "-p",
        default=".",
        help="Root directory of the codebase (default: current directory)",
    )
    parser.add_argument(
        "--extensions",
        "-e",
        nargs="+",
        default=[".c", ".cc", ".cpp", ".cxx", ".h", ".hh", ".hpp", ".hxx"],
        help="File extensions to include",
    )
    parser.add_argument(
        "--dry-run",
        "-n",
        action="store_true",
        help="Show the commands without executing them",
    )
    parser.add_argument(
        "--clang-args",
        nargs=argparse.REMAINDER,
        help="Additional arguments to pass to clang-format",
    )

    args = parser.parse_args()
    root = os.path.abspath(args.path)
    extensions = args.extensions
    extra_args = args.clang_args or []
    dry_run = args.dry_run

    files = list(find_source_files(root, extensions))
    if not files:
        print("No source files found with extensions:", extensions)
        return

    print(f"Found {len(files)} files. Running clang-format...")

    for f in files:
        run_clang_format(f, extra_args, dry_run)


if __name__ == "__main__":
    main()
