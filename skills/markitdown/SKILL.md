---
name: markitdown
description: "Convert files to Markdown using Microsoft's MarkItDown tool. Supports Word (.docx), PDF, PowerPoint (.pptx), Excel (.xlsx), HTML, images, audio, and more. Use this skill whenever the user wants to convert a document or file to Markdown format, extract text from office documents, transform files for LLM consumption, or mentions 'markitdown'. Also trigger when user says things like 'convert this file to markdown', 'extract text from PDF', 'turn this Word doc into markdown', 'read this pptx as text', or needs to process documents for RAG pipelines."
---

# MarkItDown - File to Markdown Converter

Microsoft's open-source Python tool for converting diverse file formats into clean Markdown. Useful for document extraction, RAG preprocessing, and making office documents readable as plain text.

## Supported Formats

| Format | Extensions | Notes |
|--------|-----------|-------|
| Word | `.docx` | Preserves headings, tables, lists |
| PDF | `.pdf` | Text extraction (use `--use-docintel` for scanned PDFs) |
| PowerPoint | `.pptx` | Extracts slide content |
| Excel | `.xlsx` | Converts tables to Markdown tables |
| HTML | `.html`, `.htm` | Converts to clean Markdown |
| Images | `.jpg`, `.png`, `.gif`, `.bmp`, `.tiff` | Requires OCR plugin |
| Audio | `.mp3`, `.wav` | Requires speech transcription plugin |
| Text | `.txt`, `.csv`, `.json`, `.xml` | Pass-through or structural conversion |
| Other | `.zip`, `.epub` | Archive extraction, ebook conversion |

## Prerequisites

- Python 3.10+
- `markitdown` package with all optional dependencies:
  ```bash
  pip install "markitdown[all]"
  ```
  Or install only what you need: `pip install "markitdown[docx]"`, `"markitdown[pdf]"`, etc.

## Usage

### Command Line (preferred for single files)

```bash
# Basic conversion - output to stdout
markitdown input.docx

# Save to file
markitdown input.docx -o output.md

# With explicit format hint
markitdown input.pdf --extension .pdf

# Keep base64 images in output
markitdown input.docx --keep-data-uris

# Use Azure Document Intelligence for scanned PDFs
markitdown scanned.pdf --use-docintel --endpoint "https://your-endpoint.cognitiveservices.azure.com/"
```

### Python API (preferred for batch or programmatic use)

```python
from markitdown import MarkItDown

md = MarkItDown()
result = md.convert("input.docx")
print(result.text_content)
```

### Batch Conversion Script

For converting multiple files at once, use the bundled batch script:

```bash
python scripts/convert.py <input_path> [--output-dir <dir>] [--recursive]
```

- `<input_path>`: A file or directory
- `--output-dir`: Where to save `.md` files (default: same directory as input)
- `--recursive`: Process subdirectories when input is a directory
- `--keep-data-uris`: Preserve base64-encoded images

## Workflow

1. **Identify the input file(s)** - confirm path and format with the user
2. **Choose the method**:
   - Single file: use `markitdown` CLI directly
   - Multiple files: use `scripts/convert.py`
   - Programmatic/custom: use the Python API
3. **Run conversion** - execute the appropriate command
4. **Verify output** - read the first ~50 lines of the output to confirm quality
5. **Report to user** - show the output path and a preview

## Common Patterns

### Convert and read content into context

```bash
markitdown document.docx -o document.md
```
Then use the Read tool to bring the content into the conversation.

### Convert for RAG preprocessing

```bash
python scripts/convert.py ./documents/ --output-dir ./markdown/ --recursive
```

### Handle conversion errors

If `markitdown` fails:
- Check the file isn't corrupted (try opening it manually)
- For PDFs: try `--use-docintel` if text extraction is poor
- For images: ensure OCR plugin is installed (`pip install 'markitdown[ocr]'`)
- For password-protected files: ask user for the password first

## Limitations

- Scanned PDFs without OCR produce empty or garbled output
- Complex table layouts (merged cells, nested tables) may lose structure
- Embedded macros and scripts are not converted
- Very large files (>100MB) may be slow or run out of memory
