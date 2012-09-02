#!/usr/bin/perl
package Pake;
use lib "/home/ec2-user/perl5/lib/perl5";
use Text::Markdown 'markdown';
use Mojo::Template;
use YAML::Tiny;

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
    open(OT,">../draft/".$now->ymd."-".$file_title.".md") || die "Log> Error while creating article\n";

    print "Pake> Create Post .. $title\n";
    
    print OT "---\n";
    print OT "layout: post\n";
    print OT "title: $title\n";
    print OT "date: ".$now->ymd." ".$now->hms."\n";
    print OT "categories:\n";
    print OT "---";

    close OT;

}

sub Generate {
    
    print "Pake> Generating article in HTML\n";
    opendir(DIR,"../draft")||die "Pake> Error Reading draft\n";
    while(my $file = readdir(DIR)){

        next if ($file eq '.' || $file eq '..');

        print "Pake> Process .. draft/$file\n";

        open(FH,"../draft/$file")||die "Pake> Error While reading file .. $file\n";

        my $tmp_line = '';
        my $comment_count = 0;

        while(<FH>){

            chomp;
            my $line = $_;

            if ($line =~ /^---/){

                if ($comment_count == 0){

                    $comment_count += 1;

                } elsif ($comment_count ==1){

                    # Get article setting
                    my $yaml = YAML::Tiny->read_string($tmp_line);

                    $comment_count += 1;
                
                    $tmp_line = '';

                    next;

                }
            }

            $tmp_line .= "$line\n";
            
        }

        # Initate Mojo::Template
        my $mt = Mojo::Template->new;
 
        # Get the content of source file       
        (my $html_file = $file) =~ s/\.md$//g;

        # Output the html file
        open(OT2,">../draft/$html_file.html")||die "Error Open $html_file.html\n";

        my $argv = {title=>'Article',content=>markdown($tmp_line)};
        my $result = $mt->render_file('../templates/article.html.ep',$argv);
        print OT2 "$result";

        close OT2;
        close FH;
    }
}

my %opts = ();

getopt(':pg', \%opts);

if (exists $opts{p}){

    post($opts{p});

} elsif (exists $opts{g}){
    
    Generate();

} else {

    print "Usage> pake.pl -p \"Title\"  .. create post\n";
    print "               -g          .. publish article\n";

}
