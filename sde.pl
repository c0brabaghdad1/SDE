#!/usr/bin/perl 
 
use strict;
use warnings;
use LWP::UserAgent;
use Getopt::Long;
use Term::ANSIColor;

print color "dark green ";print color "BRIGHT_GREEN";
print "\n[---]    Swagger Directory Enumeration (SDE), SDE Version: v1.0  [---]\n";
print "                      Written by: Mustafa                             \n";
print "[---]    Follow me on Twitter: twitter.com/c0brabaghdad1         [---]\n";
my $options = GetOptions(
  'u=s' => \my $url,
#  'l=s'   => \my $file, # *You can enable this option if you want use other file don't forget disable #1 and enable #2 *
) or die "Invalid options passed to $0\n";
my $file = 'wordlist.txt'; #1
#if(defined($file)){} #2
if(!defined($url)){
	print color "YELLOW";
	print "\n\n===================== EXAMPLES ====================\n";
	print "Exemple :  /sde.pl -u https://google.com by Default using wordlist.txt \n";
    print "Exemple :  /sde.pl -u https://google.com -l list.txt\n";
    exit 1;}
chomp $url;chomp $file;
print color "BRIGHT_BLUE";print "\n\n[*] Starting ...\n";sleep(1);print "[*] Let's Go .......\n\n";
if(open(LIST,'<', $file)or die $!){
		while(my $list = <LIST>){
			chomp $list;
			my $full_url = $url.'/'.$list;
			my $req = HTTP::Request->new(GET=>$full_url);
			my $ua = LWP::UserAgent->new(timeout => 10);
			my $page = $ua->request($req);
			my $sc = $page->code(); # sc === status code
			if($sc == 200 ){
					print color 'BRIGHT_GREEN';
					print "[+] 200 Found -> ";
					print $full_url, "\n";
					my $i = 1;
			}
			if($sc == 403  ){
					print color 'BRIGHT_RED';
					print "[+] 403 Forbidden -> ";
					print $full_url, "\n";
					my $i = 1;
			}
			if($sc == 404  ){
					print color 'reset';
					print "[+] 404 Not Found -> ";
					print $full_url, "\n";
					my $i = 1;
			}
			elsif($sc != 200 and $sc != 403 and $sc != 404){
					print color 'BRIGHT_YELLOW';
					print "[*] HTTP ", $page->code(), "  -> ";
					print $full_url, "\n";
					my $i = 1;
			}	
		}
}
