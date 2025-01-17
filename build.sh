#!usr/bin/env bash

# bash build.sh YYYY.M.D

echo "=== Building PrusaMMU ===";
echo "";

# Take inputs
dt=`date +"%y.%-m.%-d"alpha`;
echo "Settings:";
version="${1:-$dt}";
debug="${2:-y}";
echo "- Version: $version";
echo ""

# Delete and recreate the build directory
rm -rf Octoprint-PrusaMmu
rm -rf Octoprint-PrusaMmu.zip
mkdir Octoprint-PrusaMmu

# Copy files ans folders we need in the build
cp -r extras Octoprint-PrusaMmu/extras # this is empty so copy wont move it
cp -r octoprint_prusammu Octoprint-PrusaMmu/octoprint_prusammu
cp -r translations Octoprint-PrusaMmu/translations
cp babel.cfg Octoprint-PrusaMmu/babel.cfg
cp LICENSE.txt Octoprint-PrusaMmu/LICENSE.txt
cp MANIFEST.in Octoprint-PrusaMmu/MANIFEST.in
cp requirements.txt Octoprint-PrusaMmu/requirements.txt
cp setup.py Octoprint-PrusaMmu/setup.py

# Rewrite version
echo -n "Writing plugin version... "
sed -i "s/plugin_version = \"VERSION\"/plugin_version = \"$version\"/" Octoprint-PrusaMmu/setup.py
echo "done"

# Compress the build directory
echo -n "Zipping... ";
zip -q -r Octoprint-PrusaMmu.zip Octoprint-PrusaMmu
rm -rf Octoprint-PrusaMmu
echo "done";

echo "Done.";