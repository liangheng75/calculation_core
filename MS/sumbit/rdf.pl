#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc = Documents->Import("MFI_Dioxane_48_Furfuryl_12.xtd");


my $results = Modules->Forcite->Analysis->RadialDistributionFunction($doc, Settings(
	RDFComputeMolecularComponents => "No", 
	RDFComputeStructureFactor => "Yes", 
	RDFSetA => "O", 
	RDFSetB => "Osi"));
my $outRDFChart = $results->RDFChart;
my $outRDFChartAsStudyTable = $results->RDFChartAsStudyTable;
