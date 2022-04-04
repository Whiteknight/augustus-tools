# augustus-tools
Scripts, tools and notes for developing augustus

## Use

You should have this repo somewhere nearby the Augustus repo, so you can call these scripts quickly from the root of the Augustus repo. For example, put them in the parent directory so you can invoke `../build-all.sh`

## Toolchains

There are scripts here to build with an MSBuild toolchain or a MinGW toolchain. Update `build-all.sh` and `clean-all.sh` scripts to invoke the desired toolchain.

### MSBuild Toolchain

You are using git bash to invoke MSBuild and the Microsoft `cl.exe` compiler. `msbuild.exe` should be somewhere on your `$PATH`.

These scripts call `curl` and `unzip` utilities which you should probably have as part of your git bash install already. Install them if they are missing.

### MinGW Toolchain

You are using bash on windows from Cygwin, MSys2, git bash or something like that. You are going to build with the MinGW toolchain (make, gcc, etc). MinGW tools should be somewhere on your `$PATH`.

These scripts call `curl` and `tar` utilities, which you should have installed and on your `$PATH`.

## Scripts

### build-all.sh

Run from the root of the augustus repository.

Downloads SDL2, builds the `augustus.exe` executable, packs the assets and makes sure we have a runnable copy of augustus.exe in the `build/Debug/` directory.

### clean-all.sh

Run from the root of the augustus repository.

Cleans up build artifacts from augustus and asset_packer, and all packed/deployed assets

### rebuild-all.sh

Run from the root of the augustus repository.

Runs clean-all.sh and build-all.sh

## Editors

### VS Code

If you are using VS Code, you can copy the `launch.json` and `tasks.json` files into the `.vscode` directory at the root of the augustus repository. This will give you the ability to build augustus from the editor and (if you are using MinGW/GDB) the ability to debug the solution.