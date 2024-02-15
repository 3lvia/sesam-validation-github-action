#! /bin/sh
sesam="python3 /sesam/sesam.py "
test_path="/github/workspace/node/tests"

if test -f $test_path/requirements.txt; then
  pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore -r $test_path/requirements.txt
fi

$sesam $@
