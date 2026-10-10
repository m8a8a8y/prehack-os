# PreHack OS bv8 — 3.0 Learning Edition

A Debian 13 (trixie), amd64 learning environment with XFCE, PreHack Control Center, offline lessons, local Docker training resources, PreHack AI, and a Calamares installer.

This release distributes the supplied **PreHackOSbv8.iso**, unchanged. The system identifies itself as **PreHack OS 3.0 Learning Edition**; `bv8` is the original image's distribution label.

## Download the operating system

1. Download **PreHackOSbv8.iso.part01** and **PreHackOSbv8.iso.part02** below.
2. Download **reassemble.py** or **reassemble.ps1** into the same folder.
3. Run `python reassemble.py` (Python 3) or `.\reassemble.ps1` (Windows PowerShell).
4. Attach the resulting **PreHackOSbv8.iso** to an amd64 Debian virtual machine.

Each script checks both parts and verifies the finished ISO. Both parts are required. Allow at least **7.2 GB free space**. The image is split because GitHub requires each release asset to be below 2 GiB.

**Source code (zip/tar.gz)** downloads contain the documentation repository, not the ISO.

## Image identity

- Original size: **3,570,057,216 bytes** (about 3.33 GiB).
- ISO volume: **PreHack OS 3 Live**.
- ISO metadata date: **September 28, 2026**.
- SHA-256: `dbd04756ddd02e9cf76b6779d3681be5ad34cfdec4f358ab460a40c260b689f8`.

The bundled setup guide suggests **2 CPU cores, 4 GB RAM, and a 64 GB virtual disk**. Its default account is **prehack / prehack**. Change that password after installation and keep vulnerable applications within your training environment.

## Verification scope

The ISO metadata, package list, boot configuration, selected learning files, and bundled resources were inspected. Both release parts were read back and their concatenated SHA-256 matched the original image. Reassembly scripts were verified against the release parts.

Boot, installation, lab startup, online AI connections, and hardware compatibility were not tested in this publication session. A matching image build-source revision has not been established. See the repository's **WRITEUP.md**, **DOWNLOAD.md**, and **VERIFICATION.md** for details.

Third-party components retain their respective licenses.
