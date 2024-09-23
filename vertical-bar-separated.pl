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

# Include `Dumper` because this is useful for debugging
# hashes.
use Data::Dumper qw(Dumper);

# Each row is `|`-separated (pipe-separated)  data
# With a leading `|` and a trailing `|`; both of
# which need to be removed. Also, remove all whitespace
# before and after `|`.
my $input_filename = './vertical-bar-separated-in.txt';
my $encoding       = ':encoding(UTF-8)';

# Open for reading
open( my $input_fh, "< $encoding", $input_filename )
  or croak
  "$PROGRAM_NAME: Couldn't open $input_filename in read mode: $OS_ERROR";

# Avoid "Wide character" warning when printing out UTF-8
# characters.
use open qw( :std :encoding(UTF-8) );

# In list context, `<>` reads the whole file,
# line by line.
my @input_lines = <$input_fh>;
chomp @input_lines;
for my $input_line (@input_lines) {
    say $input_line;
    # Strip leading `|` plus whitespace.
    # Strip trailing whitespace plus `|`.
    $input_line =~ s/^\|\s*(.*)\s*\|$/$1/;
    say $input_line;
    # Split on whitespace followed by `|` followed by
    # whitespace.
    my @input_fields = split(/\s*\|\s*/, $input_line);
    say $input_fields[0];
    say $input_fields[1];
    say $input_fields[2];
}
