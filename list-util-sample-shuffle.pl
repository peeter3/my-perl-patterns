# `use 5.32.1;` seems to invoke
#     use strict;
# by default. In fact, it does. See
#     https://metacpan.org/pod/perl5120delta#Implicit_strictures
# Anything `use 5.11.0;` or higher does invoke
# `use strict;`.
use 5.32.1;
use warnings;
# `use English;` and `use Carp;` are not used
# by this script
#use English;
#use Carp;

use List::Util qw( shuffle sample );

my @words_orig = (
    'apple', 'river', 'money', 'bird',  'cash',  'card',  'lake',  'tea',
    'mall',  'salad', 'world', 'hat',   'chest', 'gate',  'water', 'paint',
    'bath',  'face',  'back',  'piano', 'heart', 'mouse', 'army',  'dirt',
    'paper', 'map',   'cheek', 'bread', 'sun',   'wood',  'fat',   'boat',
    'page',  'tooth', 'shirt', 'milk',  'youth', 'oil',   'hand',  'girl',
    'town',  'mud',   'pie',   'cell',  'fish',  'pizza', 'book',  'bus',
    'meat',  'ear',   'lady',  'cycle', 'boss',  'eye',   'meal',  'fire',
    'hair',  'guest', 'uncle', 'lab',   'case',  'poet',  'queen', 'rock',
    'son',   'virus', 'dog',   'honey', 'oven',  'soup',  'child', 'king',
    'desk',  'city',  'car',   'steak', 'salt',  'actor', 'dad',   'frame',
    'gene',  'scale', 'phone', 'poem',  'menu',  'mom',   'web',   'wife',
    'field', 'beer',  'pipe',  'box',   'buyer', 'bag',   'house', 'owner',
    'hall',  'photo', 'radio', 'soil'
);

say '*******   Pick these 7   *******';
# Pick 7 words
my @some_words = sample 7, @words_orig;
foreach my $some_word (@some_words) {
    say $some_word;
}

say '*******   Shuffle them   *******';
my @some_words_shuffled = shuffle @some_words;
foreach my $some_word (@some_words_shuffled) {
    say $some_word;
}

say '*******   Sample 3 of them   *******';
my @some_words_sampled = sample 3, @some_words;
foreach my $some_word (@some_words_sampled) {
    say $some_word;
}
