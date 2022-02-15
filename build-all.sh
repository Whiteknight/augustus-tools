#!/bin/bash

# Make sure we have SDL2 and SDL2_mixer. Download/unzip if we don't have them
cd ext/SDL2
if [ ! -d SDL2-2.0.20 ]; then
    if [ ! -f SDL2-devel-2.0.20-VC.zip ]; then
        curl -O -X GET https://www.libsdl.org/release/SDL2-devel-2.0.20-VC.zip
    fi
    unzip SDL2-devel-2.0.20-VC.zip
fi
if [ ! -d SDL2_mixer-2.0.4 ]; then
    if [ ! -f SDL2_mixer-devel-2.0.4-VC.zip ]; then
        curl -O -X GET https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-devel-2.0.4-VC.zip
    fi
    unzip SDL2_mixer-devel-2.0.4-VC.zip
fi
cd -

# Make sure we have a build/ dir and we run cmake
if [ ! -d build ]; then
    mkdir build
fi
if [ ! -f build/CMakeCache.txt ]; then
    cd build
    cmake ..
    cd ..
fi

# Build the solution. This creates build/Debug/augustus.exe
# Make sure msbuild.exe is in your path
cd build
    msbuild.exe augustus.sln
cd ..

# Copy SDL2 and SDL2_mixer to the output dir
cp ext/SDL2/SDL2-2.0.20/lib/x64/SDL2.dll build/Debug/
cp ext/SDL2/SDL2_mixer-2.0.4/lib/x64/SDL2_mixer.dll build/Debug/

# Build and run the asset_packer, and get the assets directory
# TODO: Do I need to delete old res/packed_assets folder?
rm -rf res/packed_assets
cd res/asset_packer
if [ ! -f Debug/asset_packer.exe ]; then
    if [ ! -f CMakeCache.txt ]; then
        cmake .
    fi
    msbuild.exe asset_packer.sln
fi
Debug/asset_packer.exe ..
cd ../..
rm -rf build/Debug/assets
cp -r res/packed_assets build/Debug/assets
