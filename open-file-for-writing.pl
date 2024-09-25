# `use 5.32.1;` seems to invoke
#     use strict;
# by default. In fact, it does. See
#     https://metacpan.org/pod/perl5120delta#Implicit_strictures
# Anything `use 5.11.0;` or higher does invoke
# `use strict;`.
use 5.32.1;
use warnings;
use English;
use Carp;

my $output_fh;
my $output_filename = './open-file-for-writing-out.txt';
my $encoding = ':encoding(UTF-8)';

# In another PowerShell session, run
# [System.IO.File]::Open('C:\...\open-file-for-writing-out.txt', 'Open', 'Read', 'None')
# to cause open() to croak. Close the Powershell session to release
# the lock.
open($output_fh, "> $encoding", $output_filename) or
    croak "$PROGRAM_NAME: Couldn't open $output_filename in write-open mode: $OS_ERROR";
say $output_fh 'ZZZ';
# I don't know how to cause this to croak.
close($output_fh) or croak "$PROGRAM_NAME: $output_fh: $OS_ERROR";
