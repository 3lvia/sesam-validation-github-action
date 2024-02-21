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
#   INPUT_TEST_FOLDER:
#     description: 'Name of test folder in node folder'
#   INPUT_SESAM_PY_VERSION:
#     description: 'Version of sesam-py to use'
  
# outputs:
#   OUTPUT_REPORT:
#     description: 'Summary of the validation'
#   GITHUB_OUTPUT:
#     description: 'Output "file' from 

export NODE=$INPUT_CI_NODE
export JWT=$INPUT_CI_JWT

# sesam-py "executabel"
sesam="python3 /sesam/sesam.py "

# Workspace
# $GITHUB_WORKSPACE
# Normally /github/workspace
node_path=$GITHUB_WORKSPACE"/node"
test_path=$node_path"/"$INPUT_TEST_FOLDER

# Install additional requirements if tests are present and have requirements.txt
if test -f $test_path/requirements.txt; then
  pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore -r $test_path/requirements.txt
fi

cd $node_path

# DEBUG
echo "DEBUG"
echo "node_path: $node_path"
echo "test_path: $test_path"
echo "\$@ : $@" 
echo "INPUT_SESAM_ARGS: $INPUT_SESAM_ARGS"
ls -la
echo "DEBUG END"

$sesam $INPUT_SESAM_ARGS
#  $sesam "$@" ???

# CLEANUP
echo "CLEANUP, resetting CI node"
$sesam -vv reset



