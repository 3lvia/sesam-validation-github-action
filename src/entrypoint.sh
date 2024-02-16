#! /bin/sh

# inputs
#   INPUT_CI_NODE:
#     description: 'URL of api rest endpoint for sesam dev-node used for CI (CI node)'
#   INPUT_CI_JWT:
#     description: 'JWT token'
#   INPUT_NODE:
#     description: 'URL of api rest endpoint for sesam node you want to check against (target node)'
#   INPUT_JWT:
#     description: 'A read only JWT token for target node'
#   INPUT_SESAM_ARGS:
#     description: 'Arguments to pass to sesam-py validate command'
  
# outputs:
#   OUTPUT_REPORT:
#     description: 'Summary of the validation'
#   GITHUB_OUTPUT:
#     description: 'Output "file' from 


# sesam-py "executabel"
sesam="python3 /sesam/sesam.py "

# Workspace
# $GITHUB_WORKSPACE
test_path=$GITHUB_WORKSPACE"/node/tests"

# Install additional requirements if tests are present and have requirements.txt
if test -f $test_path/requirements.txt; then
  pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore -r $test_path/requirements.txt
fi

# $sesam $INPUT_SESAM_ARGS ???

$sesam "$@"

