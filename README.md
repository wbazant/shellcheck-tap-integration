# Shellcheck TAP integration

Make [Shellcheck](https://github.com/koalaman/shellcheck) output a stream compliant with[ Test anything protocol](http://testanything.org/)

## `shellcheck-gcc-to-tap.pl`

The better one probably, works on a stream. Requirements: system Perl on any OS.

### Usage example

```
shellcheck -f gcc /var/tmp/test.sh /var/tmp/test-2.sh | /var/tmp/shellcheck-gcc-to-tap.pl
# /var/tmp/test.sh:6:1: error: Couldn't parse this for loop. Fix to allow more checks. [SC1073]
# /var/tmp/test.sh:7:1: error: Expected 'do'. [SC1058]
# /var/tmp/test.sh:7:1: error: Expected 'do'. Fix any mentioned problems and try again. [SC1072]
not ok 1 - /var/tmp/test.sh
# /var/tmp/test-2.sh:2:7: error: Double quote array expansions to avoid re-splitting elements. [SC2068]
# /var/tmp/test-2.sh:3:10: warning: This apostrophe terminated the single quoted string! [SC1011]
# /var/tmp/test-2.sh:3:11: note: This word is outside of quotes. Did you intend to 'nest '"'single quotes'"' instead'?  [SC2026]
# /var/tmp/test-2.sh:3:31: warning: Did you forget to close this single quoted string? [SC1078]
# /var/tmp/test-2.sh:4:6: note: This is actually an end quote, but due to next char it looks suspect. [SC1079]
# /var/tmp/test-2.sh:5:6: note: Expressions don't expand in single quotes, use double quotes for that. [SC2016]
# /var/tmp/test-2.sh:6:17: warning: Use single quotes, otherwise this expands now rather than when signalled. [SC2064]
not ok 2 - /var/tmp/test-2.sh
1..2
```

## run-shellcheck-on-files.sh

The previous idea how to do this.

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
