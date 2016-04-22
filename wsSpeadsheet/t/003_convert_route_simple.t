use Test::More tests => 1;
use strict;
use warnings;

use wsSpeadsheet;

# the order is important
use Dancer::Test;

my $simpleExcel = dancer_response('POST' => '/convert',{ files => [{filename => 't/test_files/test_json.xlsx', name => 'spreadsheet'}] });
is_deeply($simpleExcel->{content},'[[["test","json"]]]', "get json response for test_json.xlsx");
