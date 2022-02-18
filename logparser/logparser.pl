#!/usr/local/bin/perl -w
#
#  Log Parser, parses access_log into individual customer logfiles.
#  Stephen Misel
#  fm@misel.com
#
#  Do *not* supply any logging directives inside VirtualHosts.  The one
#  and only directive should be in the main http server configuration:
#
#
#  LogFormat "%v %h %l %u %t \"%r\" %s %b \"%{Referer}i\" \"%{User-Agent}i\"" parser
#  CustomLog "|/path/to/logparser" parser
#

use IO::Handle;
$myname = $0;

$io = new IO::Handle;

$io->fdopen(fileno(STDIN), "r");
$io->blocking(-1);
$SIG{TERM} = \&diedie;
$SIG{HUP}  = \&diedie;
$SIG{INT}  = \&diedie;

$numbuff = 1000;
$logdate = `date +%Y%m%d`;
chomp($logdate);

$0 = "$myname : reading";
while (1) {

    if ($log_line = <$io>) {
        ($vhost) = split (/\s/, $log_line);
        $vhost =~ s/^www\.//;
        $vhost = lc($vhost) or "access";
        $log_line =~ s/^\S*\s+//;
        $logs{$vhost} .= $log_line;
        $_ = $log_line;
        (@log) = m/^(\S+) (\S+) (\S+) \[([^]]+)\] "(\w+) (\S+).*" (\d+) (\S+)/o;
        $bytes{$vhost} = $bytes{$vhost} + $log[7];
        $log[7] = 0;
        $count++;
        $sleeper = 0;
        &writelogs if ($count > $numbuff);
    } else {

        # nothing waiting for me.
        $0 = "$myname : sleep";
        sleep(5);
        $sleeper++;
        &writelogs if ($sleeper == 5);
    }

}

sub writelogs {
    $0 = "$myname : writing";
    foreach $h (keys(%logs)) {
        open($h, "</logs/usage/$h\_$logdate.log");
        $oldbytes = <$h> || 0;
        $bytes{$h} = ($bytes{$h} / 1024) + $oldbytes;
        close($h);

        open($h, ">/logs/usage/$h\_$logdate.log")
          || &logerror(">>/logs/usage/$h\_$logdate.log : $!");
        print $h "$bytes{$h}\n";
        close($h);

        open($h, ">>/logs/$h/access_$logdate.log")
          || &logerror(">>/logs/$h/access_$logdate.log : $!");
        print $h "$logs{$h}";
        close($h);
    }

    %logs  = ();
    $count = 0;
    %usage = ();
    %bytes = ();
    $0     = "$myname : reading";
    return (1);
}

sub logerror {
    ($error) = @_;
    open(ER, ">>/tmp/logparser.log");
    print ER "$error\n";
    close(ER);
}

sub diedie {

    writelogs;
    exit(0);
}
