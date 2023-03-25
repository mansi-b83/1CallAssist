class BuyRequests{
  String? category;
  String? option;
  String? requestid;
  String? contactno;
  String? userid;

  BuyRequests();

  Map<String, dynamic> toJson() => {'RequestID': requestid,'UserId': userid,'Category' : category, 'Option': option, 'ContactNo': contactno};

  BuyRequests.fromSnapshot(snapshot)
  :requestid = snapshot.data()['RequestID'],
  userid = snapshot.data()['UserId'],
  category = snapshot.data()['Category'],
  option = snapshot.data()['Option'],
  contactno = snapshot.data()['ContactNo'];
}

class RenewRequests{
  String? category;
  String? option;
  String? requestid;
  String? contactno;
  String? userid;

  RenewRequests();

  Map<String, dynamic> toJson() => {'RequestID': requestid,'UserId': userid,'Category' : category, 'Option': option, 'ContactNo': contactno};

  RenewRequests.fromSnapshot(snapshot)
      :requestid = snapshot.data()['RequestID'],
        userid = snapshot.data()['UserId'],
        category = snapshot.data()['Category'],
        option = snapshot.data()['Option'],
        contactno = snapshot.data()['ContactNo'];
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