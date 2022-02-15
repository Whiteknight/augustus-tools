# augustus-tools
Scripts, tools and notes for developing augustus

## Assumptions

Assumes you have VisualStudio installed, you are running from git bash, and you have `msbuild.exe` somewhere on your `$PATH`.

Calls `curl` and `unzip` which you should probably have as part of your git bash install

## Scripts

### build-all.sh

Run from the root of the augustus repository.

Downloads SDL2, builds the solution, packs the assets and makes sure we have a runnable copy of augustus.exe in the `build/Debug/` directory

### clean-all.sh

Run from the root of the augustus repository.

Cleans up build artifacts from augustus and asset_packer, and all packed/deployed assets

### rebuild-all.sh

Run from the root of the augustus repository.

Runs clean-all.sh and build-all.sh