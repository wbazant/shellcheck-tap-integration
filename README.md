## Shellcheck TAP integration

A semi-opinionated script to make [Shellcheck](https://github.com/koalaman/shellcheck) output a stream compliant with[ Test anything protocol](http://testanything.org/)

### Example output
```
$ /var/tmp/shellcheck-tap-integration/test.sh /var/tmp/shellcheck-tap-integration/*
1..3
not ok 1 - /var/tmp/shellcheck-tap-integration/main.sh
# /var/tmp/shellcheck-tap-integration/main.sh:2:6 warning: In POSIX sh, echo flags are undefined. 2
# /var/tmp/shellcheck-tap-integration/main.sh:2:9: note: Double quote to prevent globbing and word splitting. 2
ok 2 - /var/tmp/shellcheck-tap-integration/shellcheck-test-dummy.sh
not ok 3 - /var/tmp/shellcheck-tap-integration/test.sh
# /var/tmp/shellcheck-tap-integration/test.sh:2:2: error: You need a space after the [ and before the ]. 1

$ /var/tmp/shellcheck-tap-integration/main.sh
1..0

$ /var/tmp/shellcheck-tap-integration/main.sh /var/tmp/shellcheck-tap-integration/*
1..3
ok 1 - /var/tmp/shellcheck-tap-integration/main.sh
ok 2 - /var/tmp/shellcheck-tap-integration/shellcheck-test-dummy.sh
ok 3 - /var/tmp/shellcheck-tap-integration/test.sh
```

### Requirements
`bash`, [Shellcheck](https://github.com/koalaman/shellcheck)

### Installation
Paste the function from `run-shellcheck-on-files.sh` into your script ;)

### Example usages
```
#Run shellcheck on the whole source code
find $SOURCE_FOLDER -type f -name '.sh\|.bash' | xargs ./run-shellcheck-on-files.sh

#Run shellcheck on files touched in the last ten commits
git diff --name-only HEAD~10..HEAD . | grep '.sh\|.bash' | xargs ./run-shellcheck-on-files.sh
```
