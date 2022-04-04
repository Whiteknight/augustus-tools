#!/bin/bash

# We keep SDL binaries, they don't change

# Remove build artifacts
rm -rf build/*

# Cleanup asset_packer
rm res/asset_packer/asset_packer.exe
rm res/asset_packer/Makefile
rm -rf res/asset_packer/asset_packer.dir
rm -rf res/asset_packer/obj
rm -rf res/asset_packer/x64
rm -rf res/asset_packer/CMakeFiles
rm -rf res/packed_assets