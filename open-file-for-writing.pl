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

open($output_fh, "> $encoding", $output_filename) or
    croak "$0: Couldn't open $output_filename in write-open mode: $!";
say $output_fh 'ZZZ';
close($output_fh);
