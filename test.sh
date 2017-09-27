#!/bin/bash
#Test with any strings as arguments
# shellcheck source=./run-shellcheck-on-files.sh
source "$(dirname "${BASH_SOURCE[0]}")/run-shellcheck-on-files.sh"
# shellcheck source=./shellcheck-test-dummy.sh
runShellcheckOnFiles "$(dirname "${BASH_SOURCE[0]}")/shellcheck-test-dummy.sh" "$@"
