class LeadModel {
  int leadId;
  String leadFirstName;
  String leadLastName;
  String leadPhone;
  String leadSecPhone;
  String leadAddress;
  String leadCity;
  String leadState;
  String leadPinCode;
  String householdPhoto;
  String householdYUsage;
  String householdMUsage;
  String financialInfoTime;
  String utilityCompany;
  String maxOffset;
  String leadType;
  String leadCounty;
  String leadNotes;
  String leadCreatedTime;

  LeadModel(
      {this.leadId,
      this.leadFirstName,
      this.leadLastName,
      this.leadPhone,
      this.leadSecPhone,
      this.leadAddress,
      this.leadCity,
      this.leadState,
      this.leadPinCode,
      this.householdPhoto,
      this.householdYUsage,
      this.householdMUsage,
      this.financialInfoTime,
      this.utilityCompany,
      this.maxOffset,
      this.leadType,
      this.leadCounty,
      this.leadNotes,this.leadCreatedTime});

  LeadModel.fromJson(Map<String, dynamic> json) {
    leadId = json['leadId'];
    leadFirstName = json['leadFirstName'];
    leadLastName = json['leadLastName'];
    leadPhone = json['leadPhone'];
    leadSecPhone = json['leadSecPhone'];
    leadAddress = json['leadAddress'];
    leadCity = json['leadCity'];
    leadState = json['leadState'];
    leadPinCode = json['leadPinCode'];
    householdPhoto = json['householdPhoto'];
    householdYUsage = json['householdYUsage'];
    householdMUsage = json['householdMUsage'];
    financialInfoTime = json['financialInfoTime'];
    utilityCompany = json['utilityCompany'];
    maxOffset = json['maxOffset'];
    leadType = json['leadType'];
    leadCounty = json['leadCounty'];
    leadNotes = json['leadNotes'];
    leadCreatedTime=json['leadCreatedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leadId != null) {
      data['leadId'] = this.leadId;
    }
    data['leadFirstName'] = this.leadFirstName;
    data['leadLastName'] = this.leadLastName;
    data['leadPhone'] = this.leadPhone;
    data['leadSecPhone'] = this.leadSecPhone;
    data['leadAddress'] = this.leadAddress;
    data['leadCity'] = this.leadCity;
    data['leadState'] = this.leadState;
    data['leadPinCode'] = this.leadPinCode;
    data['householdPhoto'] = this.householdPhoto;
    data['householdYUsage'] = this.householdYUsage;
    data['householdMUsage'] = this.householdMUsage;
    data['financialInfoTime'] = this.financialInfoTime;
    data['utilityCompany'] = this.utilityCompany;
    data['maxOffset'] = this.maxOffset;
    data['leadType'] = this.leadType;
    data['leadCounty'] = this.leadCounty;
    data['leadNotes'] = this.leadNotes;
    data['leadCreatedTime']=this.leadCreatedTime;
    return data;
  }
}
