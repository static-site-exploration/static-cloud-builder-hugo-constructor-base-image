#!/bin/sh
#
# Script Name: build.sh
#
# Author: Mark Dorrill
# Date : 20.03.2018
#
# Description: NOTE! this is sh and not bash. The following script builds the hugo package using the loaded site configuation and content location supplied in arguments
#
# Run Information: This script is run by Google Cloud Builer docker image.
#
# Standard Output: Any output is sent to a file called output.log
#
# Error Log: Any errors associated with this script are sent to a file called errors.log
#

set -e

debug_checks() {

  # Test hugo works
  test hugo
  echo "running script in directory:"
  pwd
  echo "running with arguments:"
  echo "$@"
}

report_arguments() {
  
  if [ -z "$@" ]
  then
    echo ""
    echo "-------------------------"
    echo " NO ARGUMENTS RECIEVED ! "
    echo "-------------------------"
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

}

display_value() {

  if [ -z "$1" ] 
  then 
    echo "!!! VALUE IS EMPTY !!!"
  else
    echo "$1"
  fi

}

use_when_set() {

  if [ -n "$2" ]
  then 
    ${1} ${2}
  fi

}

run_sequence() {
  
  echo ""
  echo "-------------------------------------"
  echo " Using envionment builtin variables: "
  echo "-------------------------------------"
  echo ""
  echo "container_package_dir: " ${container_package_dir}
  echo "container_build_dir: " ${container_build_dir}
  echo "site_dir: " ${site_dir}
  echo "site_config_file: " ${site_config_file}
  echo "themes_dir: " ${themes_dir}
  echo "theme_dir_name: " ${theme_dir_name}
  echo ""
  echo "local_test_content_dir: " ${local_test_content_dir}
  echo "container_build_dir: " ${container_build_dir}
  echo ""
  echo "CONTENT_DIR: " $(display_value ${CONTENT_DIR} ) 
  echo "BUILD_DIR: " $(display_value ${BUILD_DIR} ) 
  echo "BASE_URL: " $(display_value ${BASE_URL} ) 
  echo ""
  echo "......................................................"
  
  if [ -z "$CONTENT_DIR" ] 
  then
    echo ""
    echo "Attention: process_content_path is empty!"
    echo ""
    echo "Setting process_content_path to: use builtin test content"
    CONTENT_DIR=${container_package_dir}/${local_test_content_dir}
    echo "${CONTENT_DIR}"
    echo ""
  fi
  
  if [ -z "$BUILD_DIR" ] 
  then
    echo ""
    echo "Attention: destination_path is empty!"
    echo ""
    echo "Setting destination_path to: local container builder"
    BUILD_DIR=${container_build_dir}
    echo "${BUILD_DIR}"
    echo ""
  fi
  
  if [ -z "$CONTENT_DIR" ] || [ -z "$BUILD_DIR" ] 
  then 
   echo "......................................................"
  fi
  
  echo ""
  echo "---------------------------"
  echo " Running hugo using flags: "
  echo "---------------------------"
  echo ""
  echo "Running in build directory: ${process_destination_path}"
  echo ""
  echo "--config ${container_package_dir}/${site_dir}/${site_config_file}";
  echo "--themesDir ${container_package_dir}/${themes_dir}";
  echo "--theme ${theme_dir_name}";
  echo "--contentDir ${CONTENT_DIR}";
  echo "--destination ${BUILD_DIR}";
  echo "$(use_when_set "--baseURL" ${BASE_URL})";
  echo ""
  
  hugo \
    --config ${container_package_dir}/${site_dir}/${site_config_file} \
    $(use_when_set "--baseURL" ${BASE_URL}) \
    --themesDir ${container_package_dir}/${themes_dir} \
    --theme ${theme_dir_name} \
    \
    --contentDir ${CONTENT_DIR} \
    --destination ${BUILD_DIR} \
    
  echo ""
  echo "----------------------"
  echo " Hugo build complete: "
  echo "----------------------"
  echo ""
  echo "Created $(find ${BUILD_DIR} | wc -l) files in the build directory: ${BUILD_DIR}"
  echo ""
    
}

if [ -d "/workspace" ] 
then
  echo ""
  echo "-------------------------"
  echo " WORKSPACE TEST POSITIVE "
  echo "-------------------------"
  echo ""
  
  debug_checks "$@"
  report_arguments "$@"
  run_sequence "$@"
else 
  echo ""
  echo "-------------------------"
  echo " WORKSPACE TEST NEGATIVE "
  echo "-------------------------"
  echo ""
fi
