
# Intended for inclusion in the transaction CGI
#
# sub parsePurchaseResponse {
#  require "purchaseResponse.pl";
# }
#
sub parsePurchaseResponse {
  my $res = shift @_;
  undef %RESPONSE;

  #
  # Log the raw response data
  #
  my $now = scalar localtime;
  local *LOG;
  my $logFile = "/logs/purchaseResponses.log";
  open(LOG, ">>$logFile") || die "Can't append to $logFile: $!";
  print LOG "$now\t$res\n";
  close LOG;

  # fail-safe default
  if (!defined($G_authnet_delim) || ($G_authnet_delim eq '')) {
    $_authnet_delim = ':';
  }

  my (@resp)= split(/$G_authnet_delim/, $res); 

  # Refer to authorize.net AIM documentation
  # for field ordering and description

  $RESPONSE{'ResponseCode'}       = $resp[0];
  $RESPONSE{'ResponseSubcode'}    = $resp[1];
  $RESPONSE{'ResponseReasonCode'} = $resp[2];
  $RESPONSE{'ResponseReasonText'} = $resp[3];
  $RESPONSE{'ApprovalCode'}       = $resp[4];
  $RESPONSE{'AVSresult'}          = $resp[5];
  $RESPONSE{'TransactionID'}      = $resp[6];
  $RESPONSE{'Invoice'}            = $resp[7];
  $RESPONSE{'Amount'}             = $resp[9];
  $RESPONSE{'Method'}             = $resp[10];
  $RESPONSE{'AccountID'}          = $resp[12];
  $RESPONSE{'MD5'}                = lc($resp[37]);
  $RESPONSE{'CVVresponse'}        = $resp[38];
  $RESPONSE{'CAVVresponse'}       = $resp[39];

  #
  # Check the MD5 hash
  #
  my $amt = sprintf("%10.2f", $trans{'amount'});
  $amt =~ s/\s+//;
  my $str = $G_authnet_hash . $G_authnet_login . $RESPONSE{'TransactionID'} . $amt;
  my $hash = &md5($str);
  if ($RESPONSE{'MD5'} ne $hash) {
    my $to = $G_config{'devEmail'};
    open(LOG, "| /usr/bin/mailx -s 'Authorize.Net MD5 Mismatch' $to") || die "Can't send mail: $!";
    print LOG <<ERROR;
When:\t$now
Server: $G_config{'thisHost'}
Account ID: $accountID
ERROR
    my ($k);
    foreach $k (sort keys %RESPONSE) {
      print LOG "$k:\t$RESPONSE{$k}\n";
    }
    close LOG;
  }

  return $RESPONSE{'ResponseCode'};
}
1;
