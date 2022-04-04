#!/bin/bash
set -e

# Make sure we have a build/Debug dir and we run cmake
if [ ! -d build ]; then
    mkdir build
fi
if [ ! -d build/Debug ]; then
    mkdir build/Debug
fi

# Make sure we have SDL2 and SDL2_mixer. Download/untar if we don't have them
if [ ! -d ext/SDL2 ]; then
    mkdir ext/SDL2
fi
cd ext/SDL2
if [ ! -d SDL2-2.0.20 ]; then
    if [ ! -f SDL2-devel-2.0.20-VC.zip ]; then
        curl -O -X GET https://www.libsdl.org/release/SDL2-devel-2.0.20-mingw.tar.gz
    fi
    tar -xf SDL2-devel-2.0.20-mingw.tar.gz
fi
if [ ! -d SDL2_mixer-2.0.4 ]; then
    if [ ! -f SDL2_mixer-devel-2.0.4-VC.zip ]; then
        curl -O -X GET https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-devel-2.0.4-mingw.tar.gz
    fi
    tar -xf SDL2_mixer-devel-2.0.4-mingw.tar.gz
fi
cd -

# Copy SDL2 and SDL2_mixer to the output dir
if [ ! -e build/SDL2.dll ]; then
    cp ext/SDL2/SDL2-2.0.20/x86_64-w64-mingw32/bin/SDL2.dll build/Debug
fi
if [ ! -e build/SDL2_mixe.dll ]; then
    cp ext/SDL2/SDL2_mixer-2.0.4/x86_64-w64-mingw32/bin/SDL2_mixer.dll build/Debug
fi

if [ ! -f build/CMakeCache.txt ]; then
    cd build
        cmake .. -G "MinGW Makefiles"
    cd ..
fi


# Build the solution. This creates build/augustus.exe. Move it to the Debug folder
# Make sure buildtools (make, gcc, etc) are in your $PATH
# First delete the old .exe just to make sure we're actually building something new
if [ -e build/Debug/augustus.exe]; then
    rm build/Debug/augustus.exe
fi
cd build
    # TODO: Need to specify debug symbols -g on compiler
    make
cd ..
mv build/augustus.exe build/Debug

# Build and run the asset_packer
# TODO: Do I need to delete old res/packed_assets folder?
rm -rf res/packed_assets
cd res/asset_packer
if [ ! -f asset_packer.exe ]; then
    if [ ! -f CMakeCache.txt ]; then
        cmake . -G "MinGW Makefiles"
    fi
    make
fi
./asset_packer.exe ..
cd ../..
rm -rf build/assets
cp -r res/packed_assets build/Debug/assets
