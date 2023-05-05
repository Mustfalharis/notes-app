class LoginModel {
  String? status;
  Data? data;
  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  dynamic? id;
  dynamic? usrname;
  dynamic? email;
  dynamic? password;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usrname = json['usrname'];
    email = json['email'];
    password = json['password'];
  }
}
