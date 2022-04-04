#!/bin/bash

# We keep SDL binaries, they don't change

# Remove build artifacts
rm -rf build/*

# Cleanup asset_packer
rm -rf res/asset_packer/Debug
rm res/asset_packer/CMakeCache.txt
rm -rf res/asset_packer/CMakeFiles
rm res/asset_packer/*.vcxproj
rm res/asset_packer/*.vcxproj.filters
rm res/asset_packer/*.sln
rm res/asset_packer/cmake_install.cmake
rm -rf res/packed_assets