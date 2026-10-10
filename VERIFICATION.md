# bv8 release verification

The supplied image was inspected on **October 10, 2026**. The release files preserve its original bytes.

## Completed checks

| Check | Result |
| --- | --- |
| Original ISO exists and is readable | Passed; 3,570,057,216 bytes |
| ISO9660 metadata and directory structure | Read with `xorriso` |
| Product identity | `/etc/os-release`: PreHack OS 3.0 Learning Edition |
| Base distribution | `/usr/lib/os-release`: Debian GNU/Linux 13 (trixie) |
| Application version | `/opt/prehack/VERSION`: `3.0.0` |
| ISO volume label | `PreHack OS 3 Live` |
| ISO creation metadata | `2026092810134900`; timezone not recorded |
| Architecture | ISO disk information and package manifest identify amd64 |
| Kernel files | `vmlinuz` and `initrd.img`, including version `6.12.107+deb13-amd64` |
| Boot structures | El Torito, hybrid MBR/GPT structures, EFI files |
| GRUB choices | Normal, safe graphics, forensic local-lab, copy to RAM, troubleshooting |
| Compressed live filesystem | SquashFS listing read; selected files extracted successfully |
| Learning resources | 14 Markdown lessons in six topic directories |
| Offline container resources | Eight Docker image archives present |
| Desktop and installer packages | XFCE 4.20.1, LightDM 1.32.0, Calamares 3.3.14 listed |
| Docker packages | Docker 26.1.5 and Compose 2.26.1 listed |
| Branding | Logo and PreHack theme paths present; repository logo extracted from this ISO |
| Release part readback | Each part's SHA-256 matched its creation hash |
| Reconstructed byte stream | Concatenated SHA-256 matched the original ISO |
| GitHub asset size constraint | Both ISO parts are below 2 GiB |

## Checks not performed

- BIOS/UEFI boot to the desktop.
- Graphical installer completion and installed-system login.
- Docker archive loading, complete archive integrity checks, or lab startup.
- Online AI-provider connections or adaptive challenge startup.
- Hardware compatibility, performance benchmarking, or a comprehensive security audit.
- Proof that the current project working folder is the exact build source for this image.

Earlier project testing notes describe other images. They are not used as evidence that this supplied `bv8` image passed runtime tests.

## Checksums

| File | Bytes | SHA-256 |
| --- | ---: | --- |
| `PreHackOSbv8.iso` | 3,570,057,216 | `dbd04756ddd02e9cf76b6779d3681be5ad34cfdec4f358ab460a40c260b689f8` |
| `PreHackOSbv8.iso.part01` | 1,800,000,000 | `bc6d392f7aa397dd2fc4ab1c36645d44c9e8f5f94fbc8c25f488c0c674a43005` |
| `PreHackOSbv8.iso.part02` | 1,770,057,216 | `7894528d6909a900358821b0275ecf391d1b2adfc0d08c9767169baac4020824` |

These checksums detect changed bytes. They are not cryptographic signatures from a separately verified release author. The exact source revision is recorded as unknown in `release-manifest.json`.
