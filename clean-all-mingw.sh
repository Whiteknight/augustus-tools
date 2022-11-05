#!/bin/bash

# We keep SDL binaries, they don't change

# Remove build artifacts
rm -rf build/*

# Cleanup asset_packer
rm -rf res/asset_packer/build
rm -rf res/packed_assets