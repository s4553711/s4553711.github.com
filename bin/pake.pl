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

    my $file_title = $title;
    $file_title =~ s/\s/-/g;

    # create article in md
    open(OT,">../post/".$now->ymd."-".$file_title.".md") || die "Log> Error while creating article\n";

    print "Log> Create Post .. $title\n";
    
    print OT "---\n";
    print OT "layout: post\n";
    print OT "title: $title\n";
    print OT "date: ".$now->ymd." ".$now->hms."\n";
    print OT "categories:\n";
    print OT "---";

    close OT;

}

my %opts = ();
getopt(':p', \%opts);

if (exists $opts{p}){

    post($opts{p});

} else {

    print "Usage> pake.pl -p \"Title of the article\"\n";

}
