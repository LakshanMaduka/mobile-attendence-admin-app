import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  String? uid;
  String name;
  String email;
  String phone;
  String indexno;
  String classname;
  String address;
  String date;
  String key;
  String verifyText;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.indexno,
    this.classname = "",
    this.address = "",
    required this.date,
    required this.key,
    required this.verifyText,
  });
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'indexno': indexno,
      'classname': classname,
      'address': address,
      'key': key,
      'date': date,
      'verifyText': verifyText,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> res) {
    return UserModel(
      uid: res['uid'] ?? "",
      name: res['name'],
      email: res['email'],
      phone: res['phone'] ?? "",
      indexno: res['indexno'],
      classname: res['classname'] ?? "",
      date: res['date'],
      key: res['key'],
      address: res['address'] ?? "",
      verifyText: res['verifyText'],
    );
  }

  updateData(UserModel userModel) {
    uid = userModel.uid;
    name = userModel.name;
    email = userModel.email;
    phone = userModel.phone;
    indexno = userModel.indexno;
    classname = userModel.classname;
    date = userModel.date;
    address = userModel.address;
    verifyText = userModel.verifyText;
    notifyListeners();
  }
}
