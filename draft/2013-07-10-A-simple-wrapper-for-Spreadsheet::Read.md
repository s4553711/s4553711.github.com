---
layout: post
title: A simple wrapper for Spreadsheet::Read
date: 2013-07-10 20:27:01
categories:
	- perl
	- Spreadsheet::Read
---
Main Story
---
Recently I have massively use Spreadsheet::Read in my work to parse input data from user in xls or xlsx with header, so this simple wrapper is created to simplify my job. Below is my package.

``` perl
package Tool::DB::ExcelHelper;
use utf8;
use strict;
use warnings;

use Spreadsheet::Read;
use Encode qw(decode encode is_utf8);

our $VERSION = "1.00";

sub new {
	my ($class) = @_;
	my $self = bless({},$class);

	$self->{row} = 2;
	$self->{pos} = {};
	$self->{reflect_pos} = {};
	$self->{tmp_content} = undef;

	return $self;
}

sub AUTOLOAD {
	my ($name) = our $AUTOLOAD =~ /::(\w+)$/;
	my $self = shift;

	unless (exists $self->{tmp_content}{$name} ) {
	    return undef;
	}

	return $self->{tmp_content}{$name};
}

sub Read {
	my ($self,$input,$schema) = @_;
	$self->{schema} = $schema;
	$self->{refs} = ReadData($input, dfmt=>'yyyy/mm/dd');
	for my $cols (1..$self->{refs}->[1]{maxcol}){
		if (defined($schema->{decode('UTF-8',$self->{refs}->[1]{cr2cell($cols,1)})})){
			$self->{pos}{decode('UTF-8',$self->{refs}->[1]{cr2cell($cols,1)})} = $cols;
		}
	}
}

sub get_next {
	my ($self) = @_;
	if ( $self->{row} <= $self->{refs}->[1]{maxrow}){
		foreach my $tmp_col (keys %{$self->{pos}}){
			$self->{tmp_content}{$self->{schema}{$tmp_col}} = 
				$self->{refs}->[1]{cr2cell( $self->{pos}{$tmp_col},$self->{row} )};
		}
		$self->{row}++;
		return 1;
	}

	return 0;
}

1;
```
Usage
---
And the usage is simple too. You just need to constructed a schema to tell the program how to read the excel file. I assume that there is a excel file with header like this:

![Imgur](http://i.imgur.com/wpHQChC.png)

Then using the sample code to read the data in the column.

``` perl
use Tool::DB::ExcelHelper;
 
my $xls_schema = {
	No => 'ID',
 	Gene => 'GeneSymbol'
};
 
my $tool = Tool::DB::ExcelHelper->new();
$tool->Read('input.xlsx',$xls_schema);
 
while($tool->get_next()){
    print $tool->ID."\n";
    print $tool->GeneSymbol."\n";
}
```
