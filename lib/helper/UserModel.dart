class UserModel{
  int id;
  String name;
  String email;
  String pass;
  String status;


  UserModel({this.id,this.name, this.email, this.pass, this.status});


  UserModel.fromMap(dynamic obj) {
    this.name = obj['user_name'];
    this.email = obj['email'];
    this.pass = obj['pass'];
    this.status = obj['status'];
  }
  String get emailId => email;
  String get passs => pass;
  String get userName => name;
  String get userStatus => status;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["user_name"] = name;
    map["email"] = email;
    map["status"] = status;
    map["pass"] = pass;
    return map;
  }
}