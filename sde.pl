#!/usr/bin/perl 
 
use strict;
use warnings;
use LWP::UserAgent;
use Getopt::Long;
use Term::ANSIColor;

system('clear');
print color "BRIGHT_GREEN";
print "\n[---]    Swagger Directory Enumeration (SDE), SDE Version: v1.1  [---]\n";
print "                      Written by: Mustafa                             \n";
print "[---]    Follow me on Twitter: twitter.com/c0brabaghdad1         [---]\n";
my $options = GetOptions(
  'u=s' => \my $url,
  'l=s'   => \my $file, 
) or die "Invalid options passed to $0\n";
if(defined($url) and defined($file)){
chomp $url;chomp $file;
print color "BRIGHT_BLUE";print "\n\n[*] Starting ...\n";sleep(1);print "[*] Let's Go .......\n\n";
if(open(LIST,'<', $file)or die $!){
		while(my $list = <LIST>){
			chomp $list;
			if($url !~ /^https?:/){
		      $url = 'http://'.$url;
            }      
			my $full_url = $url.'/'.$list;
			my $req = HTTP::Request->new(GET=>$full_url);
			my $ua = LWP::UserAgent->new(timeout => 10);
			my $page = $ua->request($req);
			my $sc = $page->code(); # sc === status code
			if($sc == 200 ){
					print color 'BRIGHT_GREEN';
					print "[+] 200 Found -> ";
					print $full_url, "\n";
			}
			if($sc == 403  ){
					print color 'BRIGHT_RED';
					print "[+] 403 Forbidden -> ";
					print $full_url, "\n";
			}
			if($sc == 404  ){
					print color 'reset';
					print "[+] 404 Not Found -> ";
					print $full_url, "\n";
			}
			elsif($sc != 200 and $sc != 403 and $sc != 404){
					print color 'BRIGHT_YELLOW';
					print "[*] HTTP ", $page->code(), "  -> ";
					print $full_url, "\n";
			}	
		}
}
}
if(!defined($url) or !defined($file)){
	print color "YELLOW";
	print "\n\n===================== EXAMPLES ====================\n";
	print "Exemple :  /sde.pl -u target.tld -l wordlist.txt\n";
	print "Exemple :  /sde.pl -u https://target.tld -l wordlist.txt\n";
    exit 1;}