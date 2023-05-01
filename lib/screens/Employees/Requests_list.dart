class BuyRequests{
  String? category;
  String? option;
  String? requestid;
  String? contactno;
  String? userid;
  String? reqstatus;

  BuyRequests();

  Map<String, dynamic> toJson() => {'RequestID': requestid,'UserId': userid,'Category' : category, 'Option': option, 'ContactNo': contactno, 'Status' : reqstatus};

  BuyRequests.fromSnapshot(snapshot)
  :requestid = snapshot.data()['RequestID'],
  userid = snapshot.data()['UserId'],
  category = snapshot.data()['Category'],
  option = snapshot.data()['Option'],
  contactno = snapshot.data()['ContactNo'],
  reqstatus = snapshot.data()['Status'];
}

class RenewRequests{
  String? category;
  String? option;
  String? requestid;
  String? contactno;
  String? userid;
  String? reqstatus;

  RenewRequests();

  Map<String, dynamic> toJson() => {'RequestID': requestid,'UserId': userid,'Category' : category, 'Option': option, 'ContactNo': contactno, 'Status': reqstatus};

  RenewRequests.fromSnapshot(snapshot)
      :requestid = snapshot.data()['RequestID'],
        userid = snapshot.data()['UserId'],
        category = snapshot.data()['Category'],
        option = snapshot.data()['Option'],
        contactno = snapshot.data()['ContactNo'],
        reqstatus = snapshot.data()['Status'];
}

class ClaimRequests{
  String? category;
  String? option;
  String? requestid;
  String? contactno;
  String? userid;
  String? reqstatus;
  String? policynum;

  ClaimRequests();

  Map<String, dynamic> toJson() => {'RequestID': requestid,'UserId': userid,'Category' : category, 'Option': option, 'ContactNo': contactno, 'Status': reqstatus, 'PolicyNumber': policynum};

  ClaimRequests.fromSnapshot(snapshot) 
      :requestid = snapshot.data()['RequestID'],
        userid = snapshot.data()['UserId'],
        category = snapshot.data()['Category'],
        option = snapshot.data()['Option'],
        contactno = snapshot.data()['ContactNo'],
        reqstatus = snapshot.data()['Status'],
        policynum = snapshot.data()['PolicyNumber'];
}


class TpQuotations{
  String? compname;
  String? quotation_url;
  String? requestid;


  TpQuotations();

  Map<String, dynamic> toJson() => {'RequestID': requestid,'CompanyName': compname,'QuotationURL' : quotation_url};

  TpQuotations.fromSnapshot(snapshot)
      :requestid = snapshot.data()['RequestID'],
        compname = snapshot.data()['CompanyName'],
        quotation_url = snapshot.data()['QuotationURL'];
}