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

use Data::Dumper qw(Dumper);

my $input_filename = './slurp-file-make-array.txt';
my $encoding       = ':encoding(UTF-8)';

my $slurp = '';

# Open for reading
open( my $input_fh, "< $encoding", $input_filename )
  or croak
  "$PROGRAM_NAME: Couldn't open $input_filename in read mode: $OS_ERROR";
{
    # Localize the variable in the shortest scope possible.
    # $INPUT_RECORD_SEPARATOR is newline by default.
    local $INPUT_RECORD_SEPARATOR = undef;    # Enable localized slurp mode
    # Slurp everything, including newlines, into a single string.
    $slurp = <$input_fh>;   
    my @short_words = split( /\n/, $slurp );
    print Dumper \@short_words;
}
close $input_fh;

