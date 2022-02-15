#!/bin/bash

echo Cleaning
${BASH_SOURCE%/*}/clean-all.sh

echo Building
${BASH_SOURCE%/*}/build-all.sh