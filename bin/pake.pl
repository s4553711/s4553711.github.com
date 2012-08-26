#!/usr/bin/perl
package Pake;
use lib "/home/s4553711/perl5/lib/perl5";

use utf8;
use strict;
use DateTime;
use Getopt::Std;
use Data::Dumper;

our $VERSION = "0.01";

sub post {
    my $title = shift;

    # Get DateTime for the title of the post
    my $now = DateTime->now(time_zone  => 'Asia/Taipei');
    print "Log> Create Post .. ".$now->ymd." ".$now->hms."\n";

}

my %opts = ();
getopt(':p', \%opts);

if (exists $opts{p}){

    post($opts{p});

} else {

    print "Usage> pake.pl -p \"Title of the article\"\n";

}
