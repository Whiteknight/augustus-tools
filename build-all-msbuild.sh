#!/bin/bash
set -e

echo "Building with MSBuild"

# Make sure we have a build/Debug dir and we run cmake
if [ ! -d build ]; then
    mkdir build
fi
if [ ! -d build/Debug ]; then
    mkdir build/Debug
fi

SDLVersion=2.26.2
SDLMixerVersion=2.6.2

# Make sure we have SDL2 and SDL2_mixer. Download/unzip if we don't have them
echo "Getting SDL2"
if [ ! -d ext/SDL2 ]; then
    mkdir ext/SDL2
fi
cd ext/SDL2
    if [ ! -d SDL2-${SDLVersion} ]; then
        if [ ! -f SDL2-devel-${SDLVersion}-VC.zip ]; then
            curl -O -X GET https://www.libsdl.org/release/SDL2-devel-${SDLVersion}-VC.zip
        fi
        unzip SDL2-devel-${SDLVersion}-VC.zip
    fi
    if [ ! -d SDL2_mixer-${SDLMixerVersion} ]; then
        if [ ! -f SDL2_mixer-devel-${SDLMixerVersion}-VC.zip ]; then
            curl -O -X GET https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-devel-${SDLMixerVersion}-VC.zip
        fi
        unzip SDL2_mixer-devel-${SDLMixerVersion}-VC.zip
    fi
cd -

# Make sure we have a build/ dir and we run cmake
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
cp ext/SDL2/SDL2-${SDLVersion}/lib/x64/SDL2.dll build/Debug/
cp ext/SDL2/SDL2_mixer-${SDLMixerVersion}/lib/x64/SDL2_mixer.dll build/Debug/

# Build and run the asset_packer, and get the assets directory
# TODO: Do I need to delete old res/packed_assets folder?
rm -rf res/packed_assets
cd res/asset_packer
    if [ ! -d build ]; then
        mkdir build
    fi
    if [ ! -d build/Debug ]; then
        mkdir build/Debug
    fi
    if [ ! -f build/Debug/asset_packer.exe ]; then
        cd build
            if [ ! -f CMakeCache.txt ]; then
                cmake ..
            fi
            msbuild.exe asset_packer.sln
        cd ..
    fi
    build/Debug/asset_packer.exe ..
cd ../..
rm -rf build/Debug/assets
cp -r res/packed_assets build/Debug/assets
