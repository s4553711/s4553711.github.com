#!/usr/bin/perl
package Pake;
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

	# articel list
	my @article_list;

    opendir(DIR,"../draft")||die "Pake> Error Reading draft\n";
    while(my $file = readdir(DIR)){

        next if ($file eq '.' || $file eq '..' || $file =~ /swp$/);

        print "Pake> Process .. draft/$file\n";

        open(FH,"../draft/$file")||die "Pake> Error While reading file .. $file\n";

        my $tmp_line = '';
        my $comment_count = 0;
		my $yaml = '';

        while(<FH>){

            chomp;
            my $line = $_;

            if ($line =~ /^---/){

                if ($comment_count == 0){

                    $comment_count += 1;

                } elsif ($comment_count ==1){

                    # Get article setting
                    $yaml = YAML::Tiny->read_string($tmp_line);

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
        open(OT2,">../post/$html_file.html")||die "Error Open $html_file.html\n";
		push(@article_list,{file=>"post/$html_file.html",title=>$yaml->[0]{title}});

        my $argv = {
			title=>$yaml->[0]{title},
			content=>markdown($tmp_line),
			date=>$yaml->[0]{date}
		};

		# Rendering the article page
        my $result = $mt->render_file('../templates/article.html.ep',$argv);
        print OT2 "$result";

        close OT2;
        close FH;
    }

    open(OT3,">../article_list.html")||die "Error Open article_list.html\n";

	my $mt_list = Mojo::Template->new;
	my $argv2 = {
		list=>\@article_list,
		title=>'article list'
	};
	my $list_content = $mt_list->render_file('../templates/list.html.ep',$argv2);
	print OT3 $list_content;

	close OT3;
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
