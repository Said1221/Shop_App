import 'package:shop_app/models/loginModel.dart';

class loginModel{
  bool status;
  String message;
  loginData data;

  loginModel.fromJson(Map<String , dynamic>json){
    status = json['status'];
    message = json['message'];
    data = loginData.fromJson(json['data']);
  }
}

class loginData{
  int id;
  String name;
  String email;
  String phone;
  String token;

  loginData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.token,
});

  loginData.fromJson(Map<String , dynamic>json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
  }

}