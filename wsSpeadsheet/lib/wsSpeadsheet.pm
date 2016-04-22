package wsSpeadsheet;
use strict;
use warnings;

use Dancer ':syntax';

use Text::Iconv;
use Spreadsheet::XLSX;
my $converter = Text::Iconv->new("utf-8", "windows-1251");

our $VERSION = '0.1';

post '/convert' => sub {
    	content_type 'application/json';
	
	my $spreadsheet = request->upload('spreadsheet');
	my $excelParser = Spreadsheet::XLSX->new($spreadsheet->file_handle, $converter);
	my @worksheets = map($_->{Cells},@{$excelParser->{Worksheet}});
	foreach my $worksheet (@worksheets) {
		foreach my $row  (@$worksheet) {
			@$row = map($_->{Val},@$row);
		}
	}
	return to_json(\@worksheets);
};

get '/version' => sub {
	content_type 'application/json';
	
	return to_json { version => $VERSION };
};

get '/' => sub {
	template 'index';
};

true;
