

class PolicyNum{
  String? policynum;
  String? quotationurl;
  String? userid;

  PolicyNum();

  Map<String, dynamic> toJson() => {'PolicyNumber': policynum, 'QuotationURL': quotationurl,'UserID' : userid};

  PolicyNum.fromSnapshot(snapshot)
      :policynum = snapshot.data()['PolicyNumber'],
        quotationurl = snapshot.data()['QuotationURL'],
        userid = snapshot.data()['UserID'];
}