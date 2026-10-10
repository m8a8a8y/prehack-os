#!/usr/bin/env python3
"""Verify and reconstruct the original PreHackOSbv8.iso without dependencies."""

import argparse
import hashlib
from pathlib import Path

ISO_NAME = 'PreHackOSbv8.iso'
ISO_SIZE = 3_570_057_216
ISO_SHA256 = 'dbd04756ddd02e9cf76b6779d3681be5ad34cfdec4f358ab460a40c260b689f8'
PARTS = (
    ('PreHackOSbv8.iso.part01', 1_800_000_000, 'bc6d392f7aa397dd2fc4ab1c36645d44c9e8f5f94fbc8c25f488c0c674a43005'),
    ('PreHackOSbv8.iso.part02', 1_770_057_216, '7894528d6909a900358821b0275ecf391d1b2adfc0d08c9767169baac4020824'),
)
CHUNK_SIZE = 8 * 1024 * 1024


def sha256_file(path):
    digest = hashlib.sha256()
    with path.open('rb') as stream:
        while chunk := stream.read(CHUNK_SIZE):
            digest.update(chunk)
    return digest.hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, default=Path(__file__).resolve().parent,
                        help='Folder containing both downloaded ISO parts (default: script folder).')
    parser.add_argument('--verify-only', action='store_true', help='Verify the parts without creating an ISO.')
    args = parser.parse_args()
    directory = args.directory.resolve()
    output_path = directory / ISO_NAME
    if output_path.exists() and not args.verify_only:
        parser.exit(1, f'Refusing to overwrite existing file: {output_path}\n')
    try:
        for name, expected_size, expected_hash in PARTS:
            path = directory / name
            if path.stat().st_size != expected_size:
                raise ValueError(f'Incorrect size: {name}. Download this part again.')
            if sha256_file(path) != expected_hash:
                raise ValueError(f'Checksum mismatch: {name}. Download this part again.')
            print(f'Verified {name}', flush=True)
        if args.verify_only:
            print('Both ISO parts are valid.')
            return
        created = False
        try:
            digest = hashlib.sha256()
            with output_path.open('xb') as output:
                created = True
                for name, _, _ in PARTS:
                    with (directory / name).open('rb') as stream:
                        while chunk := stream.read(CHUNK_SIZE):
                            output.write(chunk)
                            digest.update(chunk)
            if output_path.stat().st_size != ISO_SIZE or digest.hexdigest() != ISO_SHA256:
                raise ValueError('The reconstructed image does not match the original ISO.')
            if sha256_file(output_path) != ISO_SHA256:
                raise ValueError('The written ISO failed its readback checksum.')
        except BaseException:
            if created:
                output_path.unlink(missing_ok=True)
            raise
        print(f'Created and verified {output_path}\nSHA-256: {ISO_SHA256}')
    except (OSError, ValueError) as error:
        parser.exit(1, f'Error: {error}\n')


if __name__ == '__main__':
    main()
