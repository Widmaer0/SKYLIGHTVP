class RegisterModel {
  String id,
      firstName,
      lastName,
      streetAddress,
      city,
      state,
      postalCode,
      phoneNumber,
      email,
      idLicense;
  RegisterModel({this.firstName, this.lastName, this.streetAddress, this.city,
      this.state, this.postalCode, this.email,
      this.idLicense});

 //  RegisterModel(
//      this.id,
//      this.firstName,
//      this.lastName,
//      this.streetAddress,
//      this.city,
//      this.state,
//      this.postalCoe,
//      this.phoneNumber,
//      this.email,
//      this.idLicense,
//      this.routingNum,
//      this.accountNumber,
//      this.bankName,
//      this.userName,
//      this.password,
//      this.photo);



  factory RegisterModel.fromJson(Map<String, dynamic> parsedJson) {
    return new RegisterModel(
        firstName: parsedJson['firstName'] ?? "",
        lastName: parsedJson['lastName'] ?? "",
      streetAddress: parsedJson['streetAddress'] ?? "",
      city: parsedJson['city'] ?? "",
      state: parsedJson['state'] ?? "",
      postalCode: parsedJson['postalCode'] ?? "",
      email: parsedJson['email'] ?? "",
      idLicense: parsedJson['idLicense'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": this.firstName,
      "lastName": this.lastName,
      "streetAddress": this.streetAddress,
      "city": this.city,
      "state": this.state,
      "postalCode": this.postalCode,
      "email": this.email,
      "idLicense": this.idLicense
    };
  }
//  String get reg_id {
//    return id;
//  }
//
//  void set reg_id(String reg_id) {
//    this.reg_id = reg_id;
//  }
//  String get first_name {
//    return firstName;
//  }
//
//  void set first_name(String fname) {
//    this.firstName = fname;
//  }
//
//  String get last_name {
//    return lastName;
//  }
//
//  void set last_name(String lname) {
//    this.lastName = lname;
//  }
//
//  String get street_addresse {
//    return streetAddress;
//  }
//
//  void set street_address(String streetAddress) {
//    this.streetAddress = streetAddress;
//  }
//
//  String get city_name {
//    return city;
//  }
//
//  void set city_name(String city) {
//    this.city = city;
//  }
//
//  String get state_name {
//    return state;
//  }
//
//  void set state_name(String state) {
//    this.state = state;
//  }
//
//  String get postal_code {
//    return postalCode;
//  }
//
//  void set postal_code(String postal_code) {
//    this.postalCode = postal_code;
//  }
//
//  String get phone_number {
//    return phoneNumber;
//  }
//
//  void set phone_number(String phoneNumber) {
//    this.phoneNumber = phoneNumber;
//  }
  String get email_address {
    return email;
  }

  void set email_address(String email) {
    this.email = email;
  }
//  String get id_license {
//    return idLicense;
//  }
//
//  void set id_license(String idLicense) {
//    this.idLicense = idLicense;
//  }


}

class RegisterBank {
  String routingNum, accountNumber, bankName;
  RegisterBank({ this.routingNum, this.accountNumber, this.bankName});

  factory RegisterBank.fromJson(Map<String, dynamic> parsedJson) {
    return new RegisterBank(
        routingNum: parsedJson['routingNum'] ?? "",
        accountNumber: parsedJson['accountNumber'] ?? "",
        bankName: parsedJson['bankName'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "routingNum": this.routingNum,
      "accountNumber": this.accountNumber,
      "bankName": this.bankName
    };
  }
}

class RegisterPhoto {
  String userName, password, photo;

  RegisterPhoto({ this.userName, this.password});
  factory RegisterPhoto.fromJson(Map<String, dynamic> parsedJson) {
    return new RegisterPhoto(
        userName: parsedJson['userName'] ?? "",
        password: parsedJson['password'] ?? "");
       // photo: parsedJson['photo'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "userName": this.userName,
      "password": this.password
      //"photo": this.photo
    };
  }
}
