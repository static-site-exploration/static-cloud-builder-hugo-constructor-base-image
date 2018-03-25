#!/bin/sh

#
# Script Name: build.sh
#
# Author: Mark Dorrill
# Date : 20.03.2018
#
# Description: NOTE! this is sh and not bash. The following script builds the hugo package using the loaded site configuation and content location supplied in arguments
#
# Run Information: This script is run manually.
#
# Standard Output: Any output is sent to a file called output.log
#
# Error Log: Any errors associated with this script are sent to a file called errors.log
#

set -e

# Test hugo works
test hugo
echo "running script in directory:"
pwd
echo "running with arguments:"
echo "$@"

echo "Listing / (container root /)"
ls -a / # requires busybox or installed utils

run_sequence() {
  
  if [ -z "$@" ]
  then
    echo ""
    echo "-------------------------"
    echo " NO ARGUMENTS RECIEVED ! "
    echo "-------------------------"
    echo ""
  else
    echo ""
    echo "------------------"
    echo " Using arguments: "
    echo "------------------"
    echo ""
    echo "$@"
    echo ""
    echo "......................................................"
  fi
  
  echo ""
  echo "-----------------------------"
  echo " Using envionment variables: "
  echo "-----------------------------"
  echo ""
  echo "container_package_dir: " $container_package_dir
  echo "container_build_dir: " $container_build_dir
  echo "site_dir: " $site_dir
  echo "site_config_file: " $site_config_file
  echo "themes_dir: " $themes_dir
  echo "theme_dir_name: " $theme_dir_name
  echo "content_path: " $content_path
  echo "destination_path: " $destination_path
  echo ""
  echo "......................................................"
  
}

if [ -d "/workspace" ] 
then
  echo "WORKSPACE TEST POSITIVE"
  ls /workspace
  echo "hello from inside container" > /workspace/hello$RANDOM.txt
  run_sequence
else 
  echo "WORKSPACE TEST NEGATIVE"
fi
