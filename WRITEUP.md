# PreHack OS bv8: a cybersecurity learning environment

PreHack OS combines the pieces of a practical cybersecurity classroom in a bootable Linux environment: a desktop, learning materials, local training applications, tools for investigation, and a place to record results. Its organizing idea is straightforward: learn a concept, practice in a controlled lab, analyze the evidence, and explain what happened in a report.

This write-up describes the supplied **PreHackOSbv8.iso**. Inspection of its filesystem identifies it as **PreHack OS 3.0 Learning Edition**, with application version **3.0.0**, built on **Debian GNU/Linux 13 (trixie)**. The `bv8` name is a distribution label taken from the original filename; it does not mean the system identifies itself as version 8.

## Why bring the learning environment together?

A learner can spend a substantial part of an exercise configuring a desktop, installing tools, finding a suitable training application, and organizing notes. PreHack OS packages those activities into an environment with a common entry point. The Control Center provides access to lessons, local labs, tools, challenges, reports, and system information.

This approach can help instructors give a class a consistent starting point. Learners can spend more time understanding concepts, observing behavior, and documenting findings. A bootable image also makes it possible to explore the environment in a virtual machine before choosing a permanent installation.

## The desktop and Linux foundation

The image uses an amd64 Debian foundation with XFCE and LightDM. Its package manifest lists **XFCE 4.20.1**, **LightDM 1.32.0**, and **Calamares 3.3.14**. PreHack's dark theme, wallpaper, logo, and launchers give the desktop and learning applications a shared visual identity.

The ISO includes an El Torito boot record and hybrid disk structures, along with EFI boot files. Its GRUB configuration offers normal startup, safe graphics, forensic local-lab mode, copy-to-RAM mode, and advanced troubleshooting choices. These options are present in the image; their runtime behavior has not been tested for this release during this publication session.

The forensic option is documented as disabling swap and desktop automount behavior. It does not make storage hardware read-only. Evidence handling that requires stronger guarantees still needs an appropriate acquisition process and write protection.

## A central learning workspace

The PreHack Control Center is bundled under `/opt/prehack/control-center`. The image also includes a desktop launcher, local course content, lab definitions, and diagnostic helpers. Its learning implementation contains a SQLite database and migration support for earlier JSON progress files. Some bundled prose still refers to the older JSON location, so those older descriptions should not be taken as the complete storage design.

The learner workspace is organized around courses, labs, notes, reports, evidence, screenshots, projects, and exports under `~/PreHack`. Keeping these materials together supports a useful learning habit: record observations and conclusions while working, then turn them into a report someone else can understand.

## Offline lessons and local practice

The inspected course library contains **14 Markdown lessons** across six topic directories: cybersecurity foundations, Linux, networking, web security, digital forensics, and CTF fundamentals. Networking material includes protocols, troubleshooting, packet analysis, and segmentation. Foundation material includes identity, cryptography, and controls.

The ISO also carries **eight Docker image archives**. Their names identify resources for OWASP Juice Shop, DVWA, WebGoat, three local network components, and two adaptive-practice runtime components. Bundling these archives is intended to reduce the need to download training images during a lesson. The presence of archives has been verified; their complete integrity and container startup have not been tested in this session.

Deliberately vulnerable applications give learners a controlled place to study security weaknesses and remediation. Reports can then connect an observation to its impact, supporting evidence, and a proposed fix. Keep these applications within the intended learning environment.

## AI assistance and adaptive practice

PreHack AI includes a local documentation index for offline help. The bundled provider guide also describes optional online or local provider connections. Provider credentials belong in each user's configuration rather than in a distributed image.

Adaptive learning modules and training assets are present in this image. The bundled architecture describes local scoring, verified learning evidence, hints, and temporary practice instances. Optional AI assistance can explain material or customize teaching prose, while the documented local engine controls challenge templates and verification. These are documented capabilities, not a claim that online providers or adaptive containers were exercised during publication.

## Installing and using the image

The image includes a Calamares graphical installer. Its installation guide recommends an amd64 Debian VM with at least **2 CPU cores, 4 GB RAM, and a 64 GB virtual disk**. Those values are practical setup guidance from the bundled documentation. More memory and CPU are useful for several concurrent labs.

An installed VM is the documented preferred setup for persistent learning progress and Docker storage. A live session is useful for exploring the desktop, but its writable layer is temporary and constrained. Large container archives and lab data need real writable disk space.

The bundled guides specify the default account as **`prehack` / `prehack`** for live and installed systems. Change that password after installation. Start with the Control Center, open a lesson, practice inside the local training environment, and save notes and reports in the learner workspace.

## Distribution and verification

The original ISO is **3,570,057,216 bytes**. GitHub requires each release asset to be smaller than 2 GiB, so this release distributes the unchanged ISO as two raw byte segments. Downloaders concatenate those segments in order using the included reassembly script. The script checks each part and verifies the finished image's SHA-256.

Both parts were read back after creation, and their concatenated SHA-256 matched the original image:

```text
dbd04756ddd02e9cf76b6779d3681be5ad34cfdec4f358ab460a40c260b689f8
```

ISO metadata, boot configuration, package listings, selected application files, branding, and learning resources were inspected directly. No boot, installer, container-startup, or hardware compatibility test was performed in this session. A matching source revision has not been established, and these checks do not constitute a comprehensive security audit. [Verification details](VERIFICATION.md) make the scope explicit.

## References

The product descriptions above are based on files inside the supplied image: `/etc/os-release`, `/usr/lib/os-release`, `/opt/prehack/VERSION`, `/opt/prehack/docs/ARCHITECTURE.md`, the student and installation guides, the AI provider guide, the course library, and the ISO's package manifest and GRUB configuration.

The distribution limit is documented in [GitHub's release documentation](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases).
