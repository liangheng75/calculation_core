#!perl
# Coder: Mr. Rao
# Time: 2020/10/10
# Purpose: Obatin center of each molecule every frames from trajectory file
use strict;
use MaterialsScript qw(:all);

# Input files include xtd and trj file,
# which restore the trajectory information about solute and aolvent molecules
my $doc = Documents->Import("MFI_2-Butanol_48_2-Methylfuran_12.xtd");

my $trajectory = $doc->Trajectory;

my $File = Documents->New("center.txt");

my $NumberOfMolecules = $doc->DisplayRange->Molecules->Count;

for (my $frame=1; $frame<=$trajectory->NumFrames; ++$frame){
	$trajectory->CurrentFrame = $frame;
	$File->Append(sprintf "%s %i \n", "Frame", $frame);
	for (my $i =0; $i < $NumberOfMolecules; ++$i){
		my $molecule = $doc->DisplayRange->Molecules($i);
		my $center = $molecule->center;
		$File->Append(sprintf "%s %f %f %f \n", $molecule->ChemicalFormula, $center->X, $center->Y, $center->Z);
	}
}
$File->Close;
