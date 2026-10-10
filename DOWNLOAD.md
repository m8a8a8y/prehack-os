# Download and reconstruct PreHackOSbv8.iso

Open this repository's **Releases** page and select **PreHack OS bv8 — 3.0 Learning Edition**.

Download these files into the same folder:

- `PreHackOSbv8.iso.part01`
- `PreHackOSbv8.iso.part02`
- `reassemble.py` (Python 3) or `reassemble.ps1` (Windows PowerShell)

The release also includes the original ISO checksum, part checksums, and a JSON manifest. GitHub's automatic **Source code** archives contain this documentation repository, not the operating-system ISO.

Each part is a raw segment of the original ISO. Both parts are required; neither can boot independently. [GitHub's release asset limit](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases) is why the image is split.

Allow at least **7.2 GB of free space** for the downloaded parts and reconstructed ISO. Use a filesystem that supports multi-gigabyte files.

## Python 3: Windows, Linux, or macOS

From the download folder:

```bash
python reassemble.py
```

Use `python3 reassemble.py` if your system names Python 3 that way. On Windows, `py -3 reassemble.py` is another option.

## Windows PowerShell

From the download folder:

```powershell
.\reassemble.ps1
```

If your system does not allow unsigned PowerShell scripts, use the Python method above.

Both scripts verify each part against its expected size and SHA-256, refuse to overwrite an existing ISO, join the parts, and verify the result. A successful run creates **`PreHackOSbv8.iso`**.

## Verify the finished image separately

Expected SHA-256:

```text
dbd04756ddd02e9cf76b6779d3681be5ad34cfdec4f358ab460a40c260b689f8
```

Windows:

```powershell
Get-FileHash .\PreHackOSbv8.iso -Algorithm SHA256
```

Linux:

```bash
sha256sum PreHackOSbv8.iso
```

macOS:

```bash
shasum -a 256 PreHackOSbv8.iso
```

After successful verification, attach the reconstructed ISO to an amd64 VM as described in the [README](README.md). Keep the parts until you are satisfied that reconstruction succeeded.
