#!/bin/bash

# Change this to the -mingw or -msbuild script depending on which toolchain you want
${BASH_SOURCE%/*}/build-all-mingw.sh
#${BASH_SOURCE%/*}/build-all-msbuild.sh