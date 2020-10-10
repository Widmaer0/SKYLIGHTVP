class RegisterResponseModel {

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
  String routingNum, accountNumber, bankName;
  String userName, password, photo;

  RegisterResponseModel({


      this.id,
      this.firstName,
      this.lastName,
      this.streetAddress,
      this.city,
      this.state,
      this.postalCode,
      this.phoneNumber,
      this.email,
      this.idLicense,
      this.routingNum,
      this.accountNumber,
      this.bankName,
      this.userName,
      this.password,
      this.photo});



  factory RegisterResponseModel.fromJson(Map<String, dynamic> parsedJson) {
    return new RegisterResponseModel(
        firstName: parsedJson['firstName'] ?? "",
        lastName: parsedJson['lastName'] ?? "",
      streetAddress: parsedJson['streetAddress'] ?? "",
      city: parsedJson['city'] ?? "",
      state: parsedJson['state'] ?? "",
      postalCode: parsedJson['postalCode'] ?? "",
      email: parsedJson['email'] ?? "",
      idLicense: parsedJson['idLicense'] ?? "",
    routingNum: parsedJson['routingNum'] ?? "",
    accountNumber: parsedJson['accountNumber'] ?? "",
    bankName: parsedJson['bankName'] ?? "",
        userName: parsedJson['userName'] ?? "",
        password: parsedJson['password'] ?? "",
     photo: parsedJson['photo'] ?? "");
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
      "idLicense": this.idLicense,
      "routingNum": this.routingNum,
      "accountNumber": this.accountNumber,
      "bankName": this.bankName,
      "userName": this.userName,
      "password": this.password,
      "photo": this.photo
    };
  }



}

//class RegisterBank {
//  String routingNum, accountNumber, bankName;
//  RegisterBank({ this.routingNum, this.accountNumber, this.bankName});
//
//  factory RegisterBank.fromJson(Map<String, dynamic> parsedJson) {
//    return new RegisterBank(
//        routingNum: parsedJson['routingNum'] ?? "",
//        accountNumber: parsedJson['accountNumber'] ?? "",
//        bankName: parsedJson['bankName'] ?? "");
//  }
//
//  Map<String, dynamic> toJson() {
//    return {
//      "routingNum": this.routingNum,
//      "accountNumber": this.accountNumber,
//      "bankName": this.bankName
//    };
//  }
//}
//
//class RegisterPhoto {
//  String userName, password, photo;
//
//  RegisterPhoto({ this.userName, this.password});
//  factory RegisterPhoto.fromJson(Map<String, dynamic> parsedJson) {
//    return new RegisterPhoto(
//        userName: parsedJson['userName'] ?? "",
//        password: parsedJson['password'] ?? "");
//       // photo: parsedJson['photo'] ?? "");
//  }
//
//  Map<String, dynamic> toJson() {
//    return {
//      "userName": this.userName,
//      "password": this.password
//      //"photo": this.photo
//    };
//  }
//}
