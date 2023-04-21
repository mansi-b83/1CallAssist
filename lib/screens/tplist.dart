class healthtpdata{
  String? companyname;
  String? insuranceprovided;

  healthtpdata();

  Map<String, dynamic> toJson() => {'CompanyName': companyname, 'InsuranceProvided': insuranceprovided};

  healthtpdata.fromSnapshot(snapshot)
      :companyname = snapshot.data()['CompanyName'],
        insuranceprovided = snapshot.data()['InsuranceProvided'];
}

class lifetpdata{
  String? companyname;
  String? insuranceprovided;

  lifetpdata();

  Map<String, dynamic> toJson() => {'CompanyName': companyname, 'InsuranceProvided': insuranceprovided};

  lifetpdata.fromSnapshot(snapshot)
      :companyname = snapshot.data()['CompanyName'],
        insuranceprovided = snapshot.data()['InsuranceProvided'];
}