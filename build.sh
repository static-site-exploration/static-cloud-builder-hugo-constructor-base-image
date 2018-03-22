
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
echo "hello from build.sh, using: $@";

# Build the package, if no content location is supplied then create a test mardown file usng cat EOF

# Verify the build is complete
