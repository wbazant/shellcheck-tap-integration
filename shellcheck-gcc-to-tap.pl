#!/usr/bin/env perl
# Usage: shellcheck -f gcc ... | shellcheck-gcc-to-tap.pl
use strict;
use warnings;
my @files;
my $current_file;
my $current_file_failures;
while(<>){
  chomp;
  next unless $_;
  my ($file, $line, $col, $severity, $msg) = /^(.*?):(\d+):(\d+): (note|error|warning): (.*)$/ 
    or do {
    print "Bail out! Input not in GCC format: $_\n";
    exit(1);
  };
  # Set the program state on the first line of input
  unless ($current_file){
     &set_current_file($file);
     redo;
  }
  # Begin output for next file
  if($current_file ne $file){
     &emit_current;
     &set_current_file($file);
  }
  print "# $_\n";
  $current_file_failures++ if $severity ne "note";
}

&emit_current if $current_file;
printf("1..%s\n", scalar @files);

sub set_current_file {
  $current_file=$_[0];
  $current_file_failures=0;
}

sub emit_current {
  push @files, $current_file;
  printf("%s %s - %s\n", $current_file_failures ? "not ok" : "ok", scalar @files, $current_file);
}
