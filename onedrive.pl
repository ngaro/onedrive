#!/usr/bin/perl
use warnings; use strict;
use autodie;
use 5.20.0;
=ongebruikte modules
use File::Temp;
use Path::Tiny;
use Time::Piece;
use Data::Dumper;
=cut

#Stuur naar STDERR, met lichte opmaak: foutcode $_[0], foutboodschap $_[1] en sterf met de foutcode. Indien $_[2] bestaat wordt hiermee gestorven
#Opgepast: returncodes kunnen best onder 79 blijven, en nog beter onder 64: Zie /usr/include/sysexits.h voor meer info
sub fout {
	my $returncode=$_[0];
	$returncode=pop if(@_==3);
	say STDERR "ERROR $_[0]: $_[1]"; exit $returncode;
}

#toon wat tussen =pod en =cut staat indien -h of --help is gegeven en stop het programma
sub toonsomshelp {
	if(defined $ARGV[0] and ($ARGV[0] eq "-h" or $ARGV[0] eq "--help")) {
		my $help="";
		open(DIT,$0);
		while(<DIT>) { last if(/^\s*=pod\s*$/); }
		while(<DIT>) {
			last if(/^\s*=cut\s*$/);
			$help.=$_;
		}
		close DIT;
		print $help;
		exit;
	}
}

=pod
DOET: Starts a docker container for onedrive
ARGUMENTEN: <none>
=cut

my $image="onedrive";
my $container="onedrive";
my $onedrivedir=$ENV{HOME}."/$container";

fout(1, "Run this program as a regular user instead of root") if($<==0);
mkdir $onedrivedir unless ( -d $onedrivedir );
fout(50,"Kan niet bouwen") unless (system "cd /home/garo/dockerimages/onedrive && docker build -t $image" ==0) #TODO later vervangen door een pull
system "docker run -it --restart on-failure -v $onedrivedir:/onedrive --name $container $image";
