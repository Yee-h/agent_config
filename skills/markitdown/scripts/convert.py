"""
Batch file-to-Markdown converter using Microsoft MarkItDown.

Usage:
    python convert.py <input_path> [--output-dir <dir>] [--recursive] [--keep-data-uris]

Arguments:
    input_path      A single file or a directory of files to convert.

Options:
    --output-dir    Directory to save .md files. Defaults to same location as input.
    --recursive     If input is a directory, process subdirectories too.
    --keep-data-uris  Keep base64-encoded images in output.
"""

import argparse
import sys
from pathlib import Path

# Supported extensions (subset that MarkItDown handles well)
SUPPORTED_EXTENSIONS = {
    ".docx", ".doc", ".pdf", ".pptx", ".ppt",
    ".xlsx", ".xls", ".csv",
    ".html", ".htm",
    ".txt", ".json", ".xml",
    ".jpg", ".jpeg", ".png", ".gif", ".bmp", ".tiff", ".tif",
    ".mp3", ".wav",
    ".zip", ".epub",
}


def convert_file(input_path: Path, output_path: Path, keep_data_uris: bool = False) -> bool:
    """Convert a single file to Markdown using MarkItDown."""
    try:
        from markitdown import MarkItDown

        md = MarkItDown()
        result = md.convert(str(input_path))

        output_path.parent.mkdir(parents=True, exist_ok=True)
        output_path.write_text(result.text_content, encoding="utf-8")
        print(f"  [OK] {input_path.name} -> {output_path.name}")
        return True
    except Exception as e:
        print(f"  [FAIL] {input_path.name}: {e}", file=sys.stderr)
        return False


def collect_files(input_path: Path, recursive: bool) -> list[Path]:
    """Collect files to convert from a path."""
    if input_path.is_file():
        return [input_path]

    if not input_path.is_dir():
        print(f"Error: {input_path} is not a file or directory.", file=sys.stderr)
        sys.exit(1)

    pattern = "**/*" if recursive else "*"
    files = [
        f for f in input_path.glob(pattern)
        if f.is_file() and f.suffix.lower() in SUPPORTED_EXTENSIONS
    ]
    return sorted(files)


def main():
    parser = argparse.ArgumentParser(
        description="Batch convert files to Markdown using MarkItDown."
    )
    parser.add_argument("input_path", type=Path, help="File or directory to convert")
    parser.add_argument("--output-dir", type=Path, default=None,
                        help="Output directory (default: same as input)")
    parser.add_argument("--recursive", action="store_true",
                        help="Process subdirectories")
    parser.add_argument("--keep-data-uris", action="store_true",
                        help="Keep base64-encoded images in output")

    args = parser.parse_args()
    input_path = args.input_path.resolve()

    if not input_path.exists():
        print(f"Error: {input_path} does not exist.", file=sys.stderr)
        sys.exit(1)

    files = collect_files(input_path, args.recursive)
    if not files:
        print("No supported files found.")
        sys.exit(0)

    print(f"Found {len(files)} file(s) to convert.\n")

    success_count = 0
    fail_count = 0

    for f in files:
        # Determine output path
        if args.output_dir:
            # Preserve relative structure under output-dir
            if input_path.is_dir():
                rel = f.relative_to(input_path)
                out = args.output_dir / rel.with_suffix(".md")
            else:
                out = args.output_dir / f.with_suffix(".md").name
        else:
            out = f.with_suffix(".md")

        if convert_file(f, out, args.keep_data_uris):
            success_count += 1
        else:
            fail_count += 1

    print(f"\nDone: {success_count} converted, {fail_count} failed.")


if __name__ == "__main__":
    main()
