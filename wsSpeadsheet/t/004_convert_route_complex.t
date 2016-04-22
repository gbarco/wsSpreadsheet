use Test::More tests => 2;
use strict;
use warnings;

use wsSpeadsheet;

# the order is important
use Dancer::Test;

my $excel = dancer_response('POST' => '/convert',{ files => [{filename => 't/test_files/test_json_numbers.xlsx', name => 'spreadsheet'}] });
is_deeply($excel->{content},'[[["test","json"],["1","1","2","3"],["2"],["3"]]]', "get json response for test_json_numbers.xlsx");

my $multisheetExcel = dancer_response('POST' => '/convert',{ files => [{filename => 't/test_files/test_json_multisheet.xlsx', name => 'spreadsheet'}] });
is_deeply($multisheetExcel->{content},'[[["test","json"]],[["1","1","2","3"],["2"],["3"]]]', "get json response for test_json_multisheet.xlsx");
