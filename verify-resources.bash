#!/bin/bash
#
# Script Name: verify-resources.bash
#
# Author: Mark Dorrill
# Date : 20.03.2018
#
# Description: The following script verifies that provided resources are accessable by current user
#
# Run Information: This script is run manually.
#
# Standard Output: Any output is sent to a file called output.log
#
# Error Log: Any errors associated with this script are sent to a file called errors.log
#

exec 1>>output.log
exec 2>>errors.log

test=$(date) 
echo "Today's date is $test"

# Ensure variables are empty
RESOURCE_TYPE="";

# Function: check arguments have been supplied
check_arguments () {
   if [ -z "$1" ] then;
      echo "ERROR: No arguments have been supplied";
   fi
}

# Function: Identify what kind of resource has been supplied
identify_resource_type () {
  
  # See if the resource is git, gcr or dir
  case "$1" in
  
    *git* )
        RESOURCE_TYPE="git"
        return 0
        ;;
        
    *gs* )  
        RESOURCE_TYPE="gcr" 
        return 0
        ;;
        
    [ -d ] )
        RESOURCE_TYPE="dir" 
        return 0
        ;;
  esac
  
  # Exit if the type could not be identified
  if [ -z "$RESOURCE_TYPE" ]
  then
  
    echo "could not identify the resource type"
    exit 1;
  
  fi
  
}

# Function: test git


# Function: test gcr


# Function: test dir


# Test all the arguments 
for i in "$@"; do
  
  RESOURCE_TYPE=""
  
  identify_resource_type i
    
  if [ "$RESOURCE_TYPE" == "git" ] then;

    # test we can access
    #ssh git@github.com
  
  elif [ "$RESOURCE_TYPE" == "gcr" ] then;

    # test we can access
    #gcloud


  elif [ "$RESOURCE_TYPE" == "gcr" ] then;
  
    # test we can access
    test
  
  fi
  
fi

done;
