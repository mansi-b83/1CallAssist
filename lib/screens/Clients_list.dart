class ClientRequests{
  List? company;
  String? userid;
  String? empid;
  String? reqid;
  String? category;
  String? option;

  ClientRequests();

  Map<String, dynamic> toJson() => {'RequestID': reqid,'UserID': userid,'Category' : category, 'Option': option, 'Companies': company, 'EmployeeID' : empid};

  ClientRequests.fromSnapshot(snapshot)
      :reqid = snapshot.data()['RequestID'],
        userid = snapshot.data()['UserID'],
        category = snapshot.data()['Category'],
        option = snapshot.data()['Option'],
        company = snapshot.data()['Companies'],
        empid = snapshot.data()['EmployeeID'];
}

class ClientInfo{
  List? company;
  String? userid;
  String? empid;
  String? reqid;
  String? category;
  String? option;

  ClientInfo();

  Map<String, dynamic> toJson() => {'RequestID': reqid,'UserID': userid,'Category' : category, 'Option': option, 'Companies': company, 'EmployeeID' : empid};

  ClientInfo.fromSnapshot(snapshot)
      :reqid = snapshot.data()['RequestID'],
        userid = snapshot.data()['UserID'],
        category = snapshot.data()['Category'],
        option = snapshot.data()['Option'],
        company = snapshot.data()['Companies'],
        empid = snapshot.data()['EmployeeID'];
}