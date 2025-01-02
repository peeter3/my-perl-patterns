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
use DBI;

use Data::Dumper qw(Dumper);

# The list `@special_chars` contains all the special
# characters on my keyboard. The list
# `@special_chars_not_allowed` contains special
# characters that are not allowed. Generate a list,
# `@special_chars_allowed`, of allowed special
# characters that I am able to type from my keyboard.
# Thank you https://perlmaven.com/sqlite-in-memory

# Do not include `(`, `)`, `#`, `,` in this `qw`
# declaration. These generate warnings.
my @special_chars = qw(
  ~ ` ! @ $ % ^ & * _ - + = | \ } ] { [
  : ; " ' < > . ? /
);

# Now add these without qw to supress warnings.
push @special_chars, ( '(', ')', ',', '#' );

# Now @special_characters has all the special characters
# on my keyboard.
my @special_chars_not_allowed = qw(
  " & ' / < > [ \ ] { | } ~ ^ !
);

#foreach (@special_chars) {
#    say;
#}

#say 'NOT ALLOWED';
#foreach (@special_chars_not_allowed) {
#    say;
#}

my $dbh = DBI->connect("dbi:SQLite:dbname=:memory:");
$dbh->do(
    'CREATE TABLE special_chars (
char TEXT
)'
);
$dbh->do(
    'CREATE TABLE special_chars_not_allowed (
char TEXT
)'
);

for my $special_char (@special_chars) {

    # The `undef` is a placeholder for a hash reference
    # that is not used.
    $dbh->do( "INSERT INTO special_chars (char) VALUES (?)",
        undef, $special_char );
}
for my $special_char (@special_chars_not_allowed) {

    # The `undef` is a placeholder for a hash reference
    # that is not used.
    $dbh->do( "INSERT INTO special_chars_not_allowed (char) VALUES (?)",
        undef, $special_char );
}

# Let SQL do the work.
my $sql_select = <<'SQL_SELECT';
SELECT char FROM special_chars
WHERE char NOT IN
(SELECT char FROM special_chars_not_allowed)
SQL_SELECT
my @special_chars_allowed;    # Initialize for use below.
my $sth = $dbh->prepare($sql_select);
$sth->execute;

#while ( my $h = $sth->fetchrow_hashref ) {
#    print Dumper $h;
#}
while ( my $h = $sth->fetchrow_hashref ) {
    push @special_chars_allowed, $h->{char};
}
foreach (@special_chars_allowed) {
    print;
}
print "\n";

$dbh->disconnect or croak 'Could not disconnect from database';
