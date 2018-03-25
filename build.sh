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
  echo "-------------------------------------"
  echo " Using envionment builtin variables: "
  echo "-------------------------------------"
  echo ""
  echo "container_package_dir: " $container_package_dir
  echo "container_build_dir: " $container_build_dir
  echo "site_dir: " $site_dir
  echo "site_config_file: " $site_config_file
  echo "themes_dir: " $themes_dir
  echo "theme_dir_name: " $theme_dir_name
  echo ""
  echo "content_path: " $process_content_path
  echo "destination_path: " $process_destination_path
  echo ""
  echo "local_test_content_dir: " $local_test_content_dir
  echo "container_build_dir: " $container_build_dir
  echo ""
  echo "......................................................"
  
  if [ -z "$process_content_path" ] 
  then
    echo ""
    echo "Attention: process_content_path is empty!"
    echo ""
    echo "Setting process_content_path to: use builtin test content"
    process_content_path=$local_test_content_dir
    echo "$process_content_path"
    echo ""
  fi
  
  if [ -z "$process_destination_path" ] 
  then
    echo ""
    echo "Attention: destination_path is empty!"
    echo ""
    echo "Setting destination_path to: local container builder"
    process_destination_path=$container_build_dir
    echo "$destination_path"
    echo ""
  fi
  
  echo ""
  echo "---------------------------"
  echo " Running hugo using flags: "
  echo "---------------------------"
  echo ""
  echo "Running in build directory: $process_destination_path"
  echo ""
  echo "--config ${container_package_dir}/${site_dir}/${site_config_file}";
  echo "--themesDir ${container_package_dir}/${themes_dir}";
  echo "--theme ${theme_dir_name}";
  echo "--contentDir ${process_content_path}";
  echo "--destination ${process_destination_path}";
  echo ""
  
  hugo \
    --config ${container_package_dir}/${site_dir}/${site_config_file} \
    --themesDir ${container_package_dir}/${themes_dir} \
    --theme ${theme_dir_name} \
    \
    --contentDir ${process_content_path} \
    --destination ${process_destination_path} \
    
  echo ""
  echo "----------------------"
  echo " Hugo build complete: "
  echo "----------------------"
  echo ""
  echo "Files in the build directory: $process_destination_path"
  echo ""
  find ${process_destination_path}
  echo ""
  
}

if [ -d "/workspace" ] 
then
  echo "WORKSPACE TEST POSITIVE"
  ls /workspace
  echo "hello from inside container" > /workspace/hello$RANDOM.txt
  run_sequence "$@"
else 
  echo "WORKSPACE TEST NEGATIVE"
fi
