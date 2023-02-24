// class BuyRequests{
//   String? companyaddress;
//   String? companyname;
//   String? contactno;
//   String? emailid;
//   String? insuranceprovided;
//
//   BuyRequests();
//
//   Map<String, dynamic> toJson() => {'CompanyName': companyname,'ContactNumber': contactno,'Email' : emailid, 'InsuranceProvided': insuranceprovided, 'CompanyAddress': companyaddress};
//
//   BuyRequests.fromSnapshot(snapshot)
//       :companyname = snapshot.data()['CompanyName'],
//         contactno = snapshot.data()['ContactNumber'],
//         emailid = snapshot.data()['Email'],
//         insuranceprovided = snapshot.data()['InsuranceProvided'],
//         companyaddress = snapshot.data()['CompanyAddress'];
// }

class healthtpdata{
  // String? companyaddress;
  String? companyname;
  // String? contactno;
  // String? emailid;
  String? insuranceprovided;

  healthtpdata();

  Map<String, dynamic> toJson() => {'CompanyName': companyname, 'InsuranceProvided': insuranceprovided};

  healthtpdata.fromSnapshot(snapshot)
      :companyname = snapshot.data()['CompanyName'],
        // contactno = snapshot.data()['ContactNumber'],
        // emailid = snapshot.data()['Email'],
        insuranceprovided = snapshot.data()['InsuranceProvided'];
        // companyaddress = snapshot.data()['CompanyAddress'];
}

class lifetpdata{
  // String? companyaddress;
  String? companyname;
  // String? contactno;
  // String? emailid;
  String? insuranceprovided;

  lifetpdata();

  Map<String, dynamic> toJson() => {'CompanyName': companyname, 'InsuranceProvided': insuranceprovided};

  lifetpdata.fromSnapshot(snapshot)
      :companyname = snapshot.data()['CompanyName'],
        // contactno = snapshot.data()['ContactNumber'],
        // emailid = snapshot.data()['Email'],
        insuranceprovided = snapshot.data()['InsuranceProvided'];
        // companyaddress = snapshot.data()['CompanyAddress'];
}