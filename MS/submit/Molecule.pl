#!perl
# Coder: Mr. Rao
# Time: 2020/09/28
# Purpose: Obtain coordination of  molecule C2 and C9 every frames from trajectory file
use strict;
use MaterialsScript qw(:all);

# Input files include xtd and trj file,
# which restore the trajectory information about solute and aolvent molecules
my $doc = Documents->Import("MFI_Dio_48_Fur_12.xtd");

my $trajectory = $doc->Trajectory;

my $File1=Documents->New("Dioxane_48.txt");
my $File2=Documents->New("Furfuryl.txt");

my $NumberOfMolecules = $doc->DisplayRange->Molecules->Count;

for (my $frame=1; $frame<=$trajectory->NumFrames; ++$frame){
	$trajectory->CurrentFrame = $frame;
	$File1->Append(sprintf "%s %i \n", "Frame", $frame);
	$File2->Append(sprintf "%s %i \n", "Frame", $frame);
	for (my $i =0; $i < $NumberOfMolecules; ++$i){
		my $molecule = $doc->DisplayRange->Molecules($i);
		my $NumAtoms = $molecule->NumAtoms;
		if ($NumAtoms eq 14){
			my $center = $molecule->Center;
			$File1->Append(sprintf "%s %f %f %f\n", $molecule->ChemicalFormula, $center->X, $center->Y, $center->Z);
		}
		
		if ($NumAtoms eq 13){
			my $center = $molecule->Center;
                        $File2->Append(sprintf "%s %f %f %f\n", $molecule->ChemicalFormula, $center->X, $center->Y, $center->Z);
		}
	}
}
$File1->Close;
$File2->Close;
