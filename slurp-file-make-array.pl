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

# In list context, `<>` reads the whole file,
# line by line.
my @short_words = <$input_fh>;

# I don't know why, but we need to chomp every
# element in the list.
chomp @short_words;

# Now we have a clean list.
print Dumper \@short_words;
close $input_fh;

