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

set -e;

# Test hugo works
test hugo;

echo "ARGUMENTS:."; echo "$@"

if [ -z "$@" ]
then
  echo "hello from build.sh, NO ARGUMENTS RECIEVED"
else
  echo "hello from build.sh, using arguments: $@"
fi

# Setup the variables that can be easily overridden
content_path="${container_package_dir}/${content_dir}";
destination_path="${container_build_dir}"

# if $1 or $2 are set then override some of the default values already set in the image
if [ -n "$1" ]
then
  content_path="$1"
elif [ -n "$2" ]
then
  destination_path="$2"
fi

echo "Running hugo using the following flags:";
echo "--config ${container_package_dir}/${site_dir}/${site_config_file}";
echo "--themesDir ${container_package_dir}/${themes_dir}";
echo "--theme ${theme_dir_name}";
echo "--contentDir ${content_path}";
echo "--destination ${destination_path}";

hugo \
  --config ${container_package_dir}/${site_dir}/${site_config_file} \
  --themesDir ${container_package_dir}/${themes_dir} \
  --theme ${theme_dir_name} \
  \
  --contentDir ${content_path} \
  --destination ${destination_path} \



# Verify the build is complete
