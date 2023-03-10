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