#!/usr/bin/env perl
my @files;
my $current_file = "";
my $current_file_failures = 0;
while(<>){
  chomp;
  next unless $_;
  my ($file, $line, $col, $severity, $msg) = /^(.*?):(\d+):(\d+): (note|error|warning): (.*)$/
    or die "Bail out! Input not in GCC format: $_";
  # First line of input
  unless ($current_file){
     $current_file = $file;
     redo;
  }
  # New file - flush previous warnings
  if($current_file ne $file){
     &emit_current;
     &reset_current;
  }
  print "# $_\n";
  $current_file_failed++ if $severity ne "note";
}

&emit_current if $current_file;
printf("1..%s\n", scalar @files);

sub reset_current {
  $current_file=$file;
  $current_file_failures=0;
}

sub emit_current {
  push @files, $current_file;
  printf("%s %s - %s\n", $current_file_failed ? "not ok" : "ok", scalar @files, $current_file);
}
