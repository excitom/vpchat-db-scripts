######################
#
# create XML for a Well Fargo Global Payment Gateway credit card transaction
#
sub doCcXml {
  my ($custLoginId, $pswd, $custPermId, $clientId, $merchantId, $sellerUserId, $termId, $MCCCode);

  if ($G_config{'testServer'}) {
    #$custLoginId = 'HalsoftTrial1API';
    #$pswd = 'Halsoft78730';
    #$custPermId = 'WFG';
    #$clientId = 'WFAB';
    #$merchantId = '174000000999';
    #$sellerUserId = '200003';
    #$termId = '851101';
    #$MCCCode = '5999';
    $custLoginId = 'halsoftapi';
    $pswd = 'TESTapi1';
    $custPermId = 'WFG';
    $clientId = 'HALS';
    $merchantId = '174263364997';
    $sellerUserId = '200028';
    $termId = '851101';
    $MCCCode = '7399';
  } else {
    $custLoginId = 'halsoftapi';
    $pswd = 'bri8rla2';
    $custPermId = 'WFG';
    $clientId = 'HALS';
    $merchantId = '174263364997';
    $sellerUserId = '200028';
    $termId = '851101';
    $MCCCode = '7399';
  }
  
  my $srcUserId = $sellerUserId . $trans{'accountID'};
  my $trnType = ($fields{'Country'} eq 'US') ? 'CCPurchase' : 'CCPurchaseIntl';

  my $i = join('', split(/\./, $trans{'ip'}));
  $trans{'uuid'} = sprintf "%8.8x-%4.4x-%4.4x-%4.4x-%6.6x%6.6x", $trans{'now'}, 0,0,0, $i, $trans{'accountID'};

  #my (@f) = split(/-/, $trans{'invoice'});
  #my $refId = "$f[0]-$f[1]-$f[3]";
  my $refId = $trans{'accountID'};
  my $autoSettleFlag = 'Yes';

  #
  # Don't pass a <CVV2Code> element unless 'CVV2Present'
  #
  my $CVV2PresentInd = '';
  my $CVV2Code = '';
  if ($fields{'CVV2PresentInd'} == 0) {
    $CVV2PresentInd = 'CVV2ByPassed';
  }
  elsif ($fields{'CVV2PresentInd'} == 1) {
    $CVV2PresentInd = 'CVV2Present';
    $CVV2Code = "\n<CVV2Code>$fields{'CVV2Code'}</CVV2Code>";
  }
  elsif ($fields{'CVV2PresentInd'} == 2) {
    $CVV2PresentInd = 'CVV2Illegible';
  }
  else {
    $CVV2PresentInd = 'CVV2ByPassed';
  }

  my $brand = getcctype($fields{'CcAcctId'});
  my $POSCondCode = ($brand eq 'Visa') ? 'OpenNetTran' : 'MailPhoneOrder';

  #
  # The old gateway accomodated two different names:
  # - first/last name of the person making the transaction
  # - name as it appears on the card
  #
  # The new gateway has only a first/last name requirement. We
  # could just use first/last name of the person making the transacion,
  # but name as it appears on the card is a better choice. Since
  # this is a single field in our database, we need to split it into
  # first/last name. A name like "Billy Bob Smith, Jr." becomes first
  # name "Billy" last name "Bob Smith, Jr.".
  #
  ##my $n = $fields{'CardholderName'};
  ##$n =~ s/^\s+//;
  ##$n =~ s/\s+$//;
  ##my @name = split(/\s+/, $n);
  ##my $firstName = shift @name;
  ##my $lastName = join(' ', @name);
  ##
  ## Change of strategy - 4/1/4
  ##
  my $firstName = $fields{'FirstName'};
  my $lastName = $fields{'LastName'};

  $G_buffer =<<XML;
<?xml version="1.0" encoding="UTF-8" ?>
<IFX xmlns="http://ice.wellsfargo.com/ifxlite">
 <SignonRq>
  <SignonPswd>
   <CustId>
    <SPName>WFB</SPName>
    <CustPermId>$custPermId</CustPermId>
    <CustLoginId>$custLoginId</CustLoginId>
   </CustId>
   <CustPswd>
    <CryptType>NONE</CryptType>
    <Pswd>$pswd</Pswd>
   </CustPswd>
  </SignonPswd>
  <ClientDt>
   <Year>$trans{'year'}</Year>
   <Month>$trans{'mon'}</Month>
   <Day>$trans{'day'}</Day>
   <Hour>$trans{'hr'}</Hour>
   <Minute>$trans{'min'}</Minute>
   <Second>$trans{'sec'}</Second>
  </ClientDt>
  <CustLangPref>ENG</CustLangPref>
  <ClientApp>
   <Org>Vpchat</Org>
   <Name>WFG</Name>
   <Version>1</Version>
  </ClientApp>
  <SuppressEcho>True</SuppressEcho>
 </SignonRq>
 <SmBusSvcRq>
  <RqUID>$trans{'uuid'}</RqUID>
  <SmBusPurAddRq>
   <RqUID>$trans{'uuid'}</RqUID>
   <TrnType>$trnType</TrnType>
   <SmBusPurInfo>
    <BuyerInfo>
     <PhoneNum>
      <PhoneType>DayPhone</PhoneType>
      <Phone>$fields{'Phone'}</Phone>
     </PhoneNum>
     <BuyerType>IndividualBuyer</BuyerType>
     <EmailAddr>$fields{'EmailAddr'}</EmailAddr>
     <BillShipAddrSame>True</BillShipAddrSame>
     <PurRqMethod>SecOnline</PurRqMethod>
     <PostAddr>
      <Addr1>$fields{'Addr1'}</Addr1>
      <City>$fields{'City'}</City>
      <StateProv>$fields{'StateProv'}</StateProv>
      <PostalCode>$fields{'PostalCode'}</PostalCode>
      <Country>$fields{'Country'}</Country>
     </PostAddr>
    </BuyerInfo>
    <SellerInfo>
     <SellerUserId>$sellerUserId</SellerUserId>
     <BuyerIdWithSeller>$trans{'accountID'}</BuyerIdWithSeller>
     <InvoiceInd>Storefront</InvoiceInd>
    </SellerInfo>
    <SrcInfo>
     <SrcUniqueId>Halsoft100103</SrcUniqueId>
     <ClientId>$clientId</ClientId>
     <StartDt>
      <Year>$trans{'year'}</Year>
      <Month>$trans{'mon'}</Month>
      <Day>$trans{'day'}</Day>
      <Hour>$trans{'hr'}</Hour>
      <Minute>$trans{'min'}</Minute>
      <Second>$trans{'sec'}</Second>
     </StartDt>
     <EndDt>
      <Year>$trans{'year'}</Year>
      <Month>$trans{'mon'}</Month>
      <Day>$trans{'day'}</Day>
      <Hour>$trans{'hr'}</Hour>
      <Minute>$trans{'min'}</Minute>
      <Second>$trans{'sec'}</Second>
     </EndDt>
     <IPAddr>$trans{'ip'}</IPAddr>
     <SrcUserId>$srcUserId</SrcUserId>
    </SrcInfo>
    <CCEcAcctInfo>
     <AcctId>$fields{'CcAcctId'}</AcctId>
     <CCEcAcct>
      <ExpDt>
       <Year>$fields{'Year'}</Year>
       <Month>$fields{'Month'}</Month>
      </ExpDt>
      <PersonName>
       <LastName>$lastName</LastName>
       <FirstName>$firstName</FirstName>
      </PersonName>
      <PostAddr>
       <Addr1>$fields{'Addr1'}</Addr1>
       <City>$fields{'City'}</City>
       <StateProv>$fields{'StateProv'}</StateProv>
       <PostalCode>$fields{'PostalCode'}</PostalCode>
       <Country>$fields{'Country'}</Country>
      </PostAddr>
      <Brand>$brand</Brand>
     </CCEcAcct>
    </CCEcAcctInfo>
    <CCAdditionalInfo>
     <MCCCode>$MCCCode</MCCCode>
     <POSModeCapability>
      <Mode>ManualKeyEntry</Mode>
      <Capability>TermNoPIN</Capability>
     </POSModeCapability>
     <POSCondCode>$POSCondCode</POSCondCode >
     <TermId>$termId</TermId>
     <MerchantId>$merchantId</MerchantId>
     <CurCode>USD</CurCode>
     <PostalCode>$fields{'PostalCode'}</PostalCode>
     <CVV2Info>
      <CVV2PresentInd>$CVV2PresentInd</CVV2PresentInd>$CVV2Code
     </CVV2Info>
     <ECAdditionalPOSInfo>ChanEncryptECT</ECAdditionalPOSInfo>
    </CCAdditionalInfo>
    <TotalAmt>
     <Amt>$trans{'amount'}</Amt>
     <CurCode>USD</CurCode>
    </TotalAmt>
    <ShippingInfo>
     <PersonName>
      <LastName>$lastName</LastName>
      <FirstName>$firstName</FirstName>
     </PersonName>
     <PostAddr>
      <Addr1>$fields{'Addr1'}</Addr1>
      <City>$fields{'City'}</City>
      <StateProv>$fields{'StateProv'}</StateProv>
      <PostalCode>$fields{'PostalCode'}</PostalCode>
      <Country>$fields{'Country'}</Country>
     </PostAddr>
    </ShippingInfo>
    <MerchantRefId>$refId</MerchantRefId>
    <Instructions>
     <AutoSettleFlag>$autoSettleFlag</AutoSettleFlag>
    </Instructions>
   </SmBusPurInfo>
  </SmBusPurAddRq>
 </SmBusSvcRq>
</IFX>
XML
}
1;
